import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:logger/logger.dart';

import 'package:monikid/core/service/ai_analysis_service.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_ocr_result.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/repositories/ai/gemma_model_repository.dart';
import 'package:monikid/repositories/ai/prompt_util.dart'
    show buildLocalGemmaPrompt, kLocalGemmaSystemInstruction;

/// [AiAnalysisService] backed by an on-device Gemma 4 E2B model via flutter_gemma 0.16.5.
///
/// Installation flow (0.16.5 API):
///   1. FlutterGemma.initialize()         — called once in main()
///   2. FlutterGemma.installModel()
///        .fromFile(path).install()        — register local .task file as active model
///   3. FlutterGemma.getActiveModel(...)   — load model into memory
///   4. model.createChat(...)             — one InferenceChat per inference call
class LocalGemmaAiAnalysisService implements AiAnalysisService {
  LocalGemmaAiAnalysisService({
    required GemmaModelRepository gemmaRepository,
    Logger? logger,
  })  : _gemmaRepository = gemmaRepository,
        _logger = logger ?? Logger();

  final GemmaModelRepository _gemmaRepository;
  final Logger _logger;

  // Single source of truth for the model type — change here to switch models.
  static const _kModelType = ModelType.gemma4;

  bool _isInstalled = false;
  InferenceModel? _model;
  Completer<void>? _analysisDone;

  /// Clears in-memory model state so the next [analyzeReceipt] call
  /// re-installs from disk. Call this after the model file is deleted.
  void reset() {
    _isInstalled = false;
    _model = null;
    _logger.i('LocalGemmaAiAnalysisService.reset: in-memory state cleared.');
  }

  /// Reads the first 32 bytes of the model file in hex to detect format issues
  /// before passing the file to native MediaPipe — turns native crashes into
  /// catchable Dart exceptions for common bad-file scenarios.
  Future<void> _validateModelFormat(String path) async {
    try {
      final file = File(path);
      final raf = await file.open();
      final bytes = await raf.read(32);
      await raf.close();

      final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ');
      final ascii = String.fromCharCodes(bytes.map((b) => (b >= 32 && b < 127) ? b : 0x2E));
      _logger.i(
        'LocalGemmaAiAnalysisService._validateModelFormat:\n'
        '  hex : $hex\n'
        '  text: $ascii',
      );

      // HTML error page → failed download
      if (bytes.length >= 2 && bytes[0] == 0x3C && (bytes[1] == 0x21 || bytes[1] == 0x68)) {
        throw StateError(
          'LocalGemmaAiAnalysisService: model file appears to be an HTML page '
          '(magic=0x3C) — likely a failed/partial download. Delete and re-download.',
        );
      }

      // .litertlm files use LiteRT-LM format (not ZIP) — no magic-byte check needed.
      // Only guard against HTML pages (failed downloads) which is done above.
    } catch (e, st) {
      if (e is StateError) rethrow;
      _logger.w('LocalGemmaAiAnalysisService._validateModelFormat: could not read file.', error: e, stackTrace: st);
    }
  }

  /// Registers the model file with the LiteRT runtime and loads it into memory.
  ///
  /// Uses flutter_gemma 0.16.5 API:
  ///   - [FlutterGemma.installModel().fromFile(path).install()] — registers the .task file
  ///   - [FlutterGemma.getActiveModel()] — loads model into memory
  ///
  /// Idempotent — subsequent calls return immediately if already loaded.
  Future<void> _ensureInstalled() async {
    if (_isInstalled && _model != null) {
      _logger.d('LocalGemmaAiAnalysisService._ensureInstalled: already installed, skipping.');
      return;
    }

    final isCached = await _gemmaRepository.isModelCached();
    if (!isCached) {
      throw StateError(
        'LocalGemmaAiAnalysisService._ensureInstalled: '
        'model file missing or corrupted — cannot install.',
      );
    }

    final path = await _gemmaRepository.getCachedModelPath();
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: path=$path');

    await _validateModelFormat(path);

    // Step 1: Register local .task file with the LiteRT runtime.
    // flutter_gemma applies the correct chat template automatically for each
    // ModelType via addQueryChunk — do NOT manually wrap prompts with template tags.
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: calling installModel.fromFile ($_kModelType).');
    await FlutterGemma.installModel(
      modelType: _kModelType,
      fileType: ModelFileType.litertlm,
    ).fromFile(path).install();
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: installModel done.');

    // Step 2: Load the model into memory.
    // This is the call that fails if the .task format is incompatible with the
    // bundled LiteRT native library version.
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: calling getActiveModel — '
        'if app crashes here the .task format is incompatible with this LiteRT version.');
    // maxTokens is the TOTAL KV-cache size (input + output). The prompt
    // (system instruction + full category list + few-shot examples + OCR
    // context) routinely exceeds 1024 tokens; with a 1024 cache the prefill
    // slice overflows the compiled KV cache and LiteRT fails with
    // DYNAMIC_UPDATE_SLICE "update > operand" → "Failed to invoke the compiled
    // model". 2048 gives headroom for input plus the generated JSON.
    _model = await FlutterGemma.getActiveModel(
      maxTokens: 2048,
      preferredBackend: PreferredBackend.cpu,
    );
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: getActiveModel done, model=$_model runtimeType=${_model.runtimeType}');

    _isInstalled = true;
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: model ready.');
  }

  @override
  Future<TransactionAiResult?> analyzeReceipt(
    ReceiptOcrResult ocrResult,
    List<CategoryModel> categories,
  ) async {
    // LiteRT does not support concurrent sessions on the same model.
    // Serialize calls so addQueryChunk is never called before PredictDone.
    while (_analysisDone != null) {
      _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: queued — waiting for previous analysis.');
      await _analysisDone!.future.catchError((_) {});
    }
    _analysisDone = Completer<void>();
    try {
      final isCached = await _gemmaRepository.isModelCached();
      if (!isCached) {
        throw StateError(
          'LocalGemmaAiAnalysisService: model file missing or corrupted. '
          'Download the model before calling analyzeReceipt.',
        );
      }

      _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: calling _ensureInstalled.');
      await _ensureInstalled();
      _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: _ensureInstalled done.');

      final prompt = buildLocalGemmaPrompt(
        ocrResult: ocrResult,
        languageCode: 'vi',
        modelType: _kModelType,
        categories: categories,
      );

      _logger.d(
        'LocalGemmaAiAnalysisService.analyzeReceipt: full prompt '
        '(${prompt.length} chars):\n'
        '═════════════════════════════════════\n'
        '$prompt\n'
        '═════════════════════════════════════',
      );

      // Each analyzeReceipt call uses a fresh InferenceChat (0.16.5 API) to
      // avoid cross-call KV-cache contamination. Streaming (generateChatResponseAsync)
      // is used so on-device CPU inference — which can take minutes — does not
      // hit a hard wall-clock timeout. A 60-second per-token stall timeout closes
      // the stream if the model freezes mid-generation; partial output is still
      // passed to _extractJsonObject which handles it gracefully.
      _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: creating chat (timeout 30s).');
      final chat = await _model!.createChat(
        temperature: 0.1,
        topK: 1,
        randomSeed: 1,
        modelType: _kModelType,
        systemInstruction: kLocalGemmaSystemInstruction,
        isThinking: false,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw TimeoutException(
          'LocalGemmaAiAnalysisService: createChat timed out after 30s — '
          'model may be in broken state.',
        ),
      );

      _logger.i(
        'LocalGemmaAiAnalysisService.analyzeReceipt: chat created, adding query chunk.\n'
        'prompt snippet (first 200 chars):\n'
        '${prompt.length > 200 ? prompt.substring(0, 200) : prompt}',
      );

      final responseText = await () async {
        try {
          await chat.addQueryChunk(Message(text: prompt, isUser: true));
          _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: chunk added, streaming response.');

          final buffer = StringBuffer();
          await for (final response in chat.generateChatResponseAsync().timeout(
            // Per-token stall timeout — fires only if NO new token arrives for 60s.
            // The total response time is unbounded; slow CPU devices may take minutes.
            const Duration(seconds: 60),
            onTimeout: (sink) {
              _logger.w(
                'LocalGemmaAiAnalysisService: token stream stalled 60s — closing stream. '
                'Partial output: ${buffer.length} chars.',
              );
              sink.close();
            },
          )) {
            if (response is TextResponse) {
              buffer.write(response.token);
            }
          }
          return buffer.toString();
        } finally {
          // Swallow PlatformException if native inference is still running
          // (happens when stream timeout fires before MediaPipe emits done=true).
          // The native session will complete and free itself; don't reset model.
          try {
            await chat.close();
          } catch (e) {
            _logger.w(
              'LocalGemmaAiAnalysisService: chat.close() failed — '
              'native inference still running, session will self-release.',
              error: e,
            );
          }
        }
      }();
      _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: stream done '
          '(${responseText.length} chars).');

      _logger.d(
        'LocalGemmaAiAnalysisService.analyzeReceipt: raw Gemma response:\n'
        '─────────────────────────────────────\n'
        '$responseText\n'
        '─────────────────────────────────────',
      );

      final jsonText = _extractJsonObject(responseText);
      if (jsonText == null) {
        _logger.w(
          'LocalGemmaAiAnalysisService: could not extract JSON from response.\n'
          'raw=${responseText.length > 300 ? responseText.substring(0, 300) : responseText}',
        );
        return null;
      }

      _logger.d('LocalGemmaAiAnalysisService: extracted JSON:\n$jsonText');

      final decoded = jsonDecode(jsonText) as Map<String, dynamic>;
      final safe = <String, dynamic>{
        'amount_minor': (decoded['amount_minor'] as num?)?.toInt()
            ?? (decoded['amount'] as num?)?.toInt()
            ?? 0,
        'category': _resolveCategoryIndex(decoded['category'], categories, ocrResult),
        'description': decoded['description'] as String? ?? '',
        'transaction_date': decoded['transaction_date'] as String?
            ?? decoded['date'] as String?
            ?? '',
      };
      final result = TransactionAiResult.fromJson(safe);
      _logger.i(
        'LocalGemmaAiAnalysisService: parsed result — '
        'categoryKey=${result.categoryKey} | '
        'amountMinor=${result.amountMinor} | '
        'note="${result.note}" | '
        'transactionDate=${result.transactionDate}',
      );
      return result;
    } catch (error, stackTrace) {
      _logger.e(
        'LocalGemmaAiAnalysisService.analyzeReceipt failed — resetting model state.',
        error: error,
        stackTrace: stackTrace,
      );
      // Reset so next call re-initializes the native model from scratch.
      // A failed chat (IllegalStateException, timeout) leaves the LiteRT
      // engine in an unusable state; subsequent createChat calls will hang.
      _isInstalled = false;
      _model = null;
      return null;
    } finally {
      final done = _analysisDone;
      _analysisDone = null;
      done?.complete();
    }
  }

  /// Resolves the model's `category` output (a 1-based index into [categories])
  /// to a real category ID.
  ///
  /// Priority:
  ///   1. Valid index — the model returned the position of an item in the list.
  ///   2. Keyword fallback — index missing/out of range; classify from the OCR
  ///      text via [_keywordFallback].
  String _resolveCategoryIndex(
    dynamic raw,
    List<CategoryModel> categories,
    ReceiptOcrResult ocrResult,
  ) {
    if (categories.isEmpty) return 'expense-khac';
    final index = raw is int ? raw : int.tryParse(raw?.toString().trim() ?? '');
    if (index != null && index >= 1 && index <= categories.length) {
      return categories[index - 1].id;
    }
    _logger.w(
      'LocalGemmaAiAnalysisService: category index "$raw" invalid '
      '(list size ${categories.length}) — using keyword fallback.',
    );
    return _keywordFallback(ocrResult, categories);
  }

  /// Deterministic category classification from the OCR text. Used when the
  /// model fails to return a usable index. Scans description + raw text for
  /// known keywords and maps to a default category ID (only if it exists in
  /// the passed list); otherwise falls back to "expense-khac" / first item.
  String _keywordFallback(
    ReceiptOcrResult ocrResult,
    List<CategoryModel> categories,
  ) {
    final text = <String?>[
      ocrResult.conventionHint?.purpose,
      ocrResult.description,
      ocrResult.rawText,
    ].whereType<String>().join(' ').toLowerCase();

    for (final (keywords, id) in _kKeywordRules) {
      if (keywords.any(text.contains) && categories.any((c) => c.id == id)) {
        return id;
      }
    }
    final fallback = categories.firstWhere(
      (c) => c.id == 'expense-khac',
      orElse: () => categories.first,
    );
    return fallback.id;
  }

  /// Keyword → default category ID rules for the deterministic fallback.
  /// First matching rule wins; income rules are checked first so an income
  /// keyword is not shadowed by a generic expense match.
  static const List<(List<String>, String)> _kKeywordRules = [
    (['lương', 'salary', 'thưởng', 'nhận lương'], 'income-luong'),
    (['ăn', 'cơm', 'phở', 'café', 'cafe', 'quán', 'nhà hàng', 'baemin', 'shopeefood', 'food'], 'expense-an-uong'),
    (['grab', 'gojek', 'xăng', 'taxi', 'xe', 'bus', 'vé'], 'expense-di-chuyen'),
    (['shopee', 'lazada', 'tiki', 'mua', 'order', 'cửa hàng'], 'expense-mua-sam'),
    (['học phí', 'sách', 'vở', 'trường', 'khóa học'], 'expense-hoc-tap'),
    (['thuốc', 'bệnh viện', 'phòng khám', 'nhà thuốc'], 'expense-suc-khoe'),
    (['game', 'cinema', 'rạp', 'karaoke', 'netflix', 'spotify', 'phim'], 'expense-giai-tri'),
    (['điện', 'nước', 'internet', 'wifi', 'tiền nhà', 'gas'], 'expense-sinh-hoat'),
  ];

  /// Extracts the first balanced `{...}` JSON object from [text].
  ///
  /// Uses a depth counter so nested objects don't confuse the end boundary,
  /// and preamble text before the first `{` is ignored.
  String? _extractJsonObject(String text) {
    int depth = 0, start = -1;
    for (int i = 0; i < text.length; i++) {
      if (text[i] == '{') {
        if (depth == 0) start = i;
        depth++;
      } else if (text[i] == '}') {
        depth--;
        if (depth == 0 && start != -1) return text.substring(start, i + 1);
      }
    }
    return null;
  }
}
