import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/service/gemini_ai_service.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/features/child/chooseAImodel/choose_ai_model_provider.dart';
import 'package:monikid/features/child/home/ocr_service.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_category_option.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/repositories/ai/prompt_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_scan_bill_notifier.freezed.dart';
part 'home_scan_bill_notifier.g.dart';

// ---------------------------------------------------------------------------
// Status enum
// ---------------------------------------------------------------------------

enum HomeScanBillStatus { idle, scanning, analyzing, ready, error }

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

@freezed
abstract class HomeScanBillState with _$HomeScanBillState {
  const factory HomeScanBillState({
    @Default(HomeScanBillStatus.idle) HomeScanBillStatus status,
    TransactionAiResult? transactionAiResult,
    TransactionImageSelection? scannedImage,
    String? errorMessage,
  }) = _HomeScanBillState;

  const HomeScanBillState._();

  bool get isBusy =>
      status == HomeScanBillStatus.scanning ||
      status == HomeScanBillStatus.analyzing;
}

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

@Riverpod(keepAlive: false)
class HomeScanBillNotifier extends _$HomeScanBillNotifier {
  late final Logger _logger;
  late final GeminiAiService _geminiService;
  late final HomeReceiptOcrService _ocrService;

  @override
  HomeScanBillState build() {
    _logger = getIt<Logger>();
    _geminiService = getIt<GeminiAiService>();
    _ocrService = ref.read(homeReceiptOcrServiceProvider);
    return const HomeScanBillState();
  }

  /// Runs the full OCR → AI pipeline for the given [selection].
  ///
  /// State transitions:
  ///   idle → scanning → analyzing → ready   (happy path)
  ///   idle → scanning → error               (OCR returned null)
  ///   idle → scanning → analyzing → error   (AI failed)
  Future<void> scanAndAnalyze(TransactionImageSelection selection) async {
    state = state.copyWith(
      status: HomeScanBillStatus.scanning,
      errorMessage: null,
      transactionAiResult: null,
      scannedImage: selection,
    );

    // ── Step 1: OCR ──────────────────────────────────────────────────────────
    final ocrResult = await _ocrService.scan(selection);
    if (ocrResult == null) {
      _logger.w(
        'scanAndAnalyze: OCR returned null for file=${selection.fileName}.',
      );
      state = state.copyWith(
        status: HomeScanBillStatus.error,
        errorMessage: 'ocr_failed',
      );
      return;
    }

    // ── Step 2: AI analysis ──────────────────────────────────────────────────
    state = state.copyWith(status: HomeScanBillStatus.analyzing);

    try {
      final categories =
          ref.read(categoryStreamProvider).valueOrNull ?? defaultCategories;
      final languageCode = ref.read(changeLanguageProvider).localeCode;
      final selectedModel =
          ref.read(chooseAiModelNotifierProvider).valueOrNull?.selectedModel ??
          'gemini-2.5-flash';

      final categoryOptions = categories
          .map(
            (c) => ReceiptCategoryOption(
              key: c.id,
              label: c.label,
              type: c.type,
            ),
          )
          .toList(growable: false);

      final prompt = buildReceiptAnalysisPrompt(
        ocrText: ocrResult.rawText,
        languageCode: languageCode,
        categories: categoryOptions,
      );

      _logger.i(
        'scanAndAnalyze: calling Gemini. '
        'model=$selectedModel '
        'promptLength=${prompt.length}',
      );

      final resultMap = await _geminiService.generateStructuredContent(
        systemInstruction: kReceiptAnalysisSystemInstruction,
        prompt: prompt,
        model: selectedModel,
      );

      if (resultMap == null) {
        _logger.w('scanAndAnalyze: Gemini returned null/empty map.');
        state = state.copyWith(
          status: HomeScanBillStatus.error,
          errorMessage: 'empty_response',
        );
        return;
      }

      // ── Step 3: Parse + validate categoryKey ─────────────────────────────
      TransactionAiResult result = TransactionAiResult.fromJson(resultMap);

      final validIds = categoryOptions.map((c) => c.key).toSet();
      CategoryModel? matchedCategory;
      if (validIds.contains(result.categoryKey)) {
        matchedCategory = categories.firstWhere(
          (c) => c.id == result.categoryKey,
        );
      } else {
        _logger.w(
          'scanAndAnalyze: AI returned unknown categoryKey="${result.categoryKey}", '
          'falling back to default expense category.',
        );
        matchedCategory =
            getDefaultCategoryForType('expense', categories: categories);
      }
      result = result.copyWith(
        categoryKey: matchedCategory.id,
      );

      _logger.i(
        'scanAndAnalyze: pipeline complete. '
        'categoryKey=${result.categoryKey} '
        'amountMinor=${result.amountMinor}',
      );

      state = state.copyWith(
        status: HomeScanBillStatus.ready,
        transactionAiResult: result,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'scanAndAnalyze failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: HomeScanBillStatus.error,
        errorMessage: 'request_failed',
        scannedImage: null,
      );
    }
  }

  /// Resets the notifier back to idle. Call after navigation or after
  /// showing the error snackbar so the next scan starts clean.
  void reset() {
    state = const HomeScanBillState();
  }
}
