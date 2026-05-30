import 'dart:convert';
import 'dart:io';

import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:logger/logger.dart';

import 'package:monikid/core/service/ai_analysis_service.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_ocr_result.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/repositories/ai/gemma_model_repository.dart';
import 'package:monikid/repositories/ai/prompt_util.dart';

/// [AiAnalysisService] backed by an on-device Gemma model via flutter_gemma 0.11.16.
///
/// Installation flow (0.11.16 API):
///   1. FlutterGemma.initialize()         — called once in main()
///   2. FlutterGemma.installModel()
///        .fromFile(path).install()        — register local .task file as active model
///   3. FlutterGemma.getActiveModel(...)   — load model into memory
///   4. model.createSession(...)           — one session per inference call
class LocalGemmaAiAnalysisService implements AiAnalysisService {
  LocalGemmaAiAnalysisService({
    required GemmaModelRepository gemmaRepository,
    Logger? logger,
  })  : _gemmaRepository = gemmaRepository,
        _logger = logger ?? Logger();

  final GemmaModelRepository _gemmaRepository;
  final Logger _logger;

  bool _isInstalled = false;
  InferenceModel? _model;

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

      // Not a ZIP archive (PK\x03\x04) → web/WASM variant incompatible with flutter_gemma.
      // The *-web.task files use a WASM binary format, not the MediaPipe ZIP bundle.
      if (bytes.length >= 4 &&
          !(bytes[0] == 0x50 && bytes[1] == 0x4B && bytes[2] == 0x03 && bytes[3] == 0x04)) {
        throw StateError(
          'LocalGemmaAiAnalysisService: model file is not a MediaPipe ZIP bundle '
          '(expected PK\\x03\\x04, got ${bytes.take(4).map((b) => "0x${b.toRadixString(16).padLeft(2,"0")}").join(" ")}). '
          'Web/WASM variants (*-web.task) are not supported — '
          'download the standard .task or .tflite format instead.',
        );
      }
    } catch (e, st) {
      if (e is StateError) rethrow;
      _logger.w('LocalGemmaAiAnalysisService._validateModelFormat: could not read file.', error: e, stackTrace: st);
    }
  }

  /// Registers the model file with the LiteRT runtime and loads it into memory.
  ///
  /// Uses flutter_gemma 0.11.16 API:
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
    // ModelType.general is intentional: buildLocalGemmaPrompt already applies
    // the Gemma IT chat template manually (<start_of_turn>user/model tags).
    // Using ModelType.gemmaIt here would cause addQueryChunk to double-wrap
    // the prompt with the same template → malformed input → native crash.
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: calling installModel.fromFile.');
    await FlutterGemma.installModel(
      modelType: ModelType.general,
      fileType: ModelFileType.task,
    ).fromFile(path).install();
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: installModel done.');

    // Step 2: Load the model into memory.
    // This is the call that fails if the .task format is incompatible with the
    // bundled LiteRT native library version.
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: calling getActiveModel — '
        'if app crashes here the .task format is incompatible with this LiteRT version.');
    _model = await FlutterGemma.getActiveModel(
      maxTokens: 1024,
      preferredBackend: PreferredBackend.cpu,
    );
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: getActiveModel done, model=$_model');

    _isInstalled = true;
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: model ready.');
  }

  @override
  Future<TransactionAiResult?> analyzeReceipt(
    ReceiptOcrResult ocrResult,
    List<CategoryModel> categories,
  ) async {
    // Entire method wrapped so _ensureInstalled failures are also caught.
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
      );

      _logger.d(
        'LocalGemmaAiAnalysisService.analyzeReceipt: full prompt '
        '(${prompt.length} chars):\n'
        '═════════════════════════════════════\n'
        '$prompt\n'
        '═════════════════════════════════════',
      );

      // Each analyzeReceipt call uses a fresh session to avoid cross-call
      // context leakage (sessions are not reusable).
      _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: creating session.');
      final session = await _model!.createSession(
        temperature: 0.7,
        topK: 40,
        randomSeed: 1,
      );
      _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: session created, adding query chunk.');

      await session.addQueryChunk(Message(text: prompt, isUser: true));
      _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: chunk added, awaiting response.');

      final responseText = await session.getResponse();
      _logger.i('LocalGemmaAiAnalysisService.analyzeReceipt: response received '
          '(${responseText.length} chars), closing session.');
      await session.close();

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
      // Gemma may use wrong key names (e.g. "amount" instead of "amount_minor",
      // "date" instead of "transaction_date") — accept both and fall back to
      // safe defaults so the generated fromJson never sees a null num cast.
      // Also translate Gemma's fixed semantic category key to the app's actual
      // default category ID so the notifier validation step finds a match.
      final gemmaCategory = decoded['category'] as String? ?? 'other_expense';
      final safe = <String, dynamic>{
        'amount_minor': (decoded['amount_minor'] as num?)?.toInt()
            ?? (decoded['amount'] as num?)?.toInt()
            ?? 0,
        'category': _mapGemmaCategory(gemmaCategory),
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
        'LocalGemmaAiAnalysisService.analyzeReceipt failed.',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Maps Gemma's fixed 9-category semantic keys to the app's default category
  /// IDs. Custom-category UUIDs are never in this map — the notifier falls back
  /// to the default expense category for those anyway.
  static const _kGemmaCategoryMap = <String, String>{
    'food_drink': 'expense-an-uong',
    'transport': 'expense-di-chuyen',
    'shopping': 'expense-mua-sam',
    'education': 'expense-hoc-tap',
    'health': 'expense-suc-khoe',
    'entertainment': 'expense-giai-tri',
    'personal_care': 'expense-sinh-hoat',
    'bills_utilities': 'expense-sinh-hoat',
    'other_expense': 'expense-khac',
  };

  String _mapGemmaCategory(String gemmaKey) =>
      _kGemmaCategoryMap[gemmaKey] ?? 'expense-khac';

  /// Extracts the first `{...}` JSON object from [text].
  String? _extractJsonObject(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start == -1 || end == -1 || end <= start) return null;
    return text.substring(start, end + 1);
  }
}
