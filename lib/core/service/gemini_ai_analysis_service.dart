import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/service/ai_analysis_service.dart';
import 'package:monikid/core/service/gemini_ai_service.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_category_option.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_ocr_result.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/repositories/ai/prompt_util.dart';

class GeminiAiAnalysisService implements AiAnalysisService {
  GeminiAiAnalysisService({
    required GeminiAiService geminiService,
    required AppLocalStorage localStorage,
    Logger? logger,
  })  : _geminiService = geminiService,
        _localStorage = localStorage,
        _logger = logger ?? Logger();

  final GeminiAiService _geminiService;
  final AppLocalStorage _localStorage;
  final Logger _logger;

  @override
  Future<TransactionAiResult?> analyzeReceipt(
    ReceiptOcrResult ocrResult,
    List<CategoryModel> categories,
  ) async {
    final selectedModel =
        await _localStorage.read(StorageKeys.selectedAiModel) ??
            'gemini-2.5-flash';

    final categoryOptions = categories
        .map((c) => ReceiptCategoryOption(key: c.id, label: c.label, type: c.type))
        .toList(growable: false);

    final prompt = buildReceiptAnalysisPrompt(
      ocrResult: ocrResult,
      languageCode: 'vi',
      categories: categoryOptions,
    );

    _logger.i(
      'GeminiAiAnalysisService.analyzeReceipt: '
      'model=$selectedModel promptLength=${prompt.length}',
    );

    final resultMap = await _geminiService.generateStructuredContent(
      systemInstruction: kReceiptAnalysisSystemInstruction,
      prompt: prompt,
      model: selectedModel,
    );

    if (resultMap == null) {
      _logger.w('GeminiAiAnalysisService: generateStructuredContent returned null.');
      return null;
    }

    return TransactionAiResult.fromJson(resultMap);
  }
}
