import 'dart:convert';

import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:logger/logger.dart';

import 'package:monikid/core/service/ai_analysis_service.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_category_option.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/repositories/ai/gemma_model_repository.dart';
import 'package:monikid/repositories/ai/prompt_util.dart';

/// [AiAnalysisService] backed by an on-device Gemma model via flutter_gemma.
///
/// The model is installed once (lazy singleton state) and reused across calls.
/// Each [analyzeReceipt] call creates a fresh session so there is no cross-call
/// context leakage.
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

  /// Ensures the local model file is registered with flutter_gemma and the
  /// [InferenceModel] is ready. Idempotent — subsequent calls return immediately.
  Future<void> _ensureInstalled() async {
    if (_isInstalled && _model != null) return;

    final isCached = await _gemmaRepository.isModelCached();
    if (!isCached) {
      throw StateError(
        'LocalGemmaAiAnalysisService._ensureInstalled: '
        'model file missing or corrupted — cannot install.',
      );
    }

    final path = await _gemmaRepository.getCachedModelPath();

    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: path=$path');

    await FlutterGemma.installModel(
      modelType: ModelType.gemmaIt,
      // .bin files require ModelFileType.binary so flutter_gemma applies the
      // chat template manually instead of relying on MediaPipe's built-in one.
      fileType: ModelFileType.binary,
    ).fromFile(path).install();

    _model = await FlutterGemma.getActiveModel(
      maxTokens: 512,
      preferredBackend: PreferredBackend.cpu,
    );

    _isInstalled = true;
    _logger.i('LocalGemmaAiAnalysisService._ensureInstalled: model ready.');
  }

  @override
  Future<TransactionAiResult?> analyzeReceipt(
    String ocrText,
    List<CategoryModel> categories,
  ) async {
    final isCached = await _gemmaRepository.isModelCached();
    if (!isCached) {
      throw StateError(
        'LocalGemmaAiAnalysisService: model file missing or corrupted. '
        'Download the model before calling analyzeReceipt.',
      );
    }

    await _ensureInstalled();

    final categoryOptions = categories
        .map(
          (c) => ReceiptCategoryOption(key: c.id, label: c.label, type: c.type),
        )
        .toList(growable: false);

    final prompt = buildLocalGemmaPrompt(
      ocrText: ocrText,
      languageCode: 'vi',
      categories: categoryOptions,
    );

    _logger.d(
      'LocalGemmaAiAnalysisService.analyzeReceipt: full prompt '
      '(${prompt.length} chars):\n'
      '═════════════════════════════════════\n'
      '$prompt\n'
      '═════════════════════════════════════',
    );

    try {
      final session = await _model!.createSession(
        temperature: 0.7,
        topK: 40,
        randomSeed: 1,
      );

      await session.addQueryChunk(Message(text: prompt, isUser: true));
      final responseText = await session.getResponse();
      await session.close();

      _logger.d(
        'LocalGemmaAiAnalysisService.analyzeReceipt: raw Gemma response '
        '(${responseText.length} chars):\n'
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

      _logger.d(
        'LocalGemmaAiAnalysisService: extracted JSON:\n$jsonText',
      );

      final decoded = jsonDecode(jsonText) as Map<String, dynamic>;
      final result = TransactionAiResult.fromJson(decoded);
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

  /// Extracts the first `{...}` JSON object from [text], or returns null if
  /// none is found.
  String? _extractJsonObject(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start == -1 || end == -1 || end <= start) return null;
    return text.substring(start, end + 1);
  }
}
