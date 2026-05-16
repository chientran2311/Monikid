import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/service/ai_provider_resolver.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_provider.dart';
import 'package:monikid/features/child/home/ocr_service.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_category_option.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
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
  late final AiProviderResolver _resolver;
  late final HomeReceiptOcrService _ocrService;
  bool _cancelled = false;

  @override
  HomeScanBillState build() {
    _logger = getIt<Logger>();
    _resolver = getIt<AiProviderResolver>();
    _ocrService = ref.read(homeReceiptOcrServiceProvider);
    return const HomeScanBillState();
  }

  /// Cancels any in-progress scan. The underlying request is not aborted but
  /// its result is discarded. State resets to idle immediately.
  void cancel() {
    _cancelled = true;
    state = const HomeScanBillState();
  }

  /// Runs the full OCR → AI pipeline for the given [selection].
  ///
  /// State transitions:
  ///   idle → scanning → analyzing → ready   (happy path)
  ///   idle → scanning → error               (OCR returned null)
  ///   idle → scanning → analyzing → error   (AI failed or no provider)
  Future<void> scanAndAnalyze(TransactionImageSelection selection) async {
    _cancelled = false;
    state = state.copyWith(
      status: HomeScanBillStatus.scanning,
      errorMessage: null,
      transactionAiResult: null,
      scannedImage: selection,
    );

    // ── Step 1: OCR ──────────────────────────────────────────────────────────
    final ocrResult = await _ocrService.scan(selection);
    if (_cancelled) return;
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

    _logger.d(
      'scanAndAnalyze: OCR output (${ocrResult.rawText.length} chars):\n'
      '─────────────────────────────────────\n'
      '${ocrResult.rawText}\n'
      '─────────────────────────────────────',
    );

    // ── Step 2: AI analysis ──────────────────────────────────────────────────
    state = state.copyWith(status: HomeScanBillStatus.analyzing);

    try {
      final categories =
          ref.read(categoryStreamProvider).valueOrNull ?? defaultCategories;

      // Resolve AI provider (4-case decision matrix per AiProviderResolver)
      final service = await _resolver.resolve();
      if (_cancelled) return;
      if (service == null) {
        _logger.w(
          'scanAndAnalyze: no AI provider available. '
          'useLocalModel=${ref.read(chooseAiModelNotifierProvider).valueOrNull?.useLocalModel} '
          'hasSavedApiKey=${ref.read(chooseAiModelNotifierProvider).valueOrNull?.hasSavedApiKey}',
        );
        state = state.copyWith(
          status: HomeScanBillStatus.error,
          errorMessage: 'scanBillNoAiAvailable',
        );
        return;
      }

      final categoryOptions = categories
          .map(
            (c) => ReceiptCategoryOption(
              key: c.id,
              label: c.label,
              type: c.type,
            ),
          )
          .toList(growable: false);

      _logger.i(
        'scanAndAnalyze: calling AI service. '
        'serviceType=${service.runtimeType}',
      );

      TransactionAiResult? aiResult;
      try {
        aiResult = await service.analyzeReceipt(ocrResult.rawText, categories);
      } catch (inferenceError, inferenceStack) {
        _logger.e(
          'scanAndAnalyze: AI service failed, attempting fallback.',
          error: inferenceError,
          stackTrace: inferenceStack,
        );
        // D-10: fallback to Gemini if local inference fails and API key is active
        final hasApiKey =
            ref.read(chooseAiModelNotifierProvider).valueOrNull?.hasSavedApiKey ??
                false;
        if (hasApiKey) {
          _logger.i('scanAndAnalyze: retrying via Gemini fallback.');
          aiResult = await _resolver.geminiService
              .analyzeReceipt(ocrResult.rawText, categories);
        } else {
          rethrow;
        }
      }

      if (_cancelled) return;
      if (aiResult == null) {
        _logger.w('scanAndAnalyze: AI service returned null/empty result.');
        state = state.copyWith(
          status: HomeScanBillStatus.error,
          errorMessage: 'empty_response',
        );
        return;
      }

      // ── Step 3: Validate categoryKey ────────────────────────────────────────
      final validIds = categoryOptions.map((c) => c.key).toSet();
      CategoryModel? matchedCategory;
      if (validIds.contains(aiResult.categoryKey)) {
        matchedCategory = categories.firstWhere(
          (c) => c.id == aiResult!.categoryKey,
        );
      } else {
        _logger.w(
          'scanAndAnalyze: AI returned unknown categoryKey="${aiResult.categoryKey}", '
          'falling back to default expense category.',
        );
        matchedCategory =
            getDefaultCategoryForType('expense', categories: categories);
      }
      final result = aiResult.copyWith(categoryKey: matchedCategory.id);

      _logger.i(
        'scanAndAnalyze: pipeline complete. '
        'serviceType=${service.runtimeType} '
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
