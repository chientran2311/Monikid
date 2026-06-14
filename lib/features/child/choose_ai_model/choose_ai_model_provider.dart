import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/service/ai_analysis_service.dart';
import 'package:monikid/core/service/gemini_ai_service.dart';
import 'package:monikid/core/service/local_gemma_ai_analysis_service.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_state.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_category_option.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_ocr_result.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/repositories/ai/gemma_model_repository.dart';
import 'package:monikid/repositories/ai/prompt_util.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'choose_ai_model_provider.g.dart';

@Riverpod(keepAlive: true)
class ChooseAiModelNotifier extends _$ChooseAiModelNotifier {
  late final Logger _logger;
  late final AppSecureStorage _secureStorage;
  late final AppLocalStorage _localStorage;
  late final GeminiAiService _geminiService;
  late final GemmaModelRepository _modelRepository;
  late final LocalGemmaAiAnalysisService _localGemmaService;
  CancelToken? _gemmaCancelToken;

  @override
  Future<ChooseAiModelState> build() async {
    _logger = getIt<Logger>();
    _secureStorage = getIt<AppSecureStorage>();
    _localStorage = getIt<AppLocalStorage>();
    _geminiService = getIt<GeminiAiService>();
    _modelRepository = getIt<GemmaModelRepository>();
    _localGemmaService =
        getIt<AiAnalysisService>(instanceName: 'local') as LocalGemmaAiAnalysisService;

    _logger.d('ChooseAiModelNotifier.build: START');

    final storedApiKey =
        await _secureStorage.read(StorageKeys.userGeminiApiKey);
    final hasStoredApiKey =
        await _localStorage.readBool(StorageKeys.hasStoredGeminiApiKey) ??
            false;
    final storedModel =
        await _localStorage.read(StorageKeys.selectedAiModel) ??
            kGeminiModelOptions.first.modelId;

    bool useLocalModel =
        await _localStorage.readBool(StorageKeys.useLocalModel) ?? false;

    // Clean up any stale .part file from a previous killed download
    await _modelRepository.reconcileStalePartFile();

    final isCached = await _modelRepository.isModelCached();
    if (isCached) {
      // Safe to call only when model is confirmed cached — getCachedModelPath throws if no file found.
      final modelPath = await _modelRepository.getCachedModelPath();
      _logger.d('ChooseAiModelNotifier.build: modelPath=$modelPath isCached=true | useLocalModel=$useLocalModel');
    } else {
      _logger.d('ChooseAiModelNotifier.build: isCached=false | useLocalModel=$useLocalModel');
    }

    final hasKeyInStorage = storedApiKey != null && storedApiKey.isNotEmpty;

    // EC-3: model file gone externally — reset useLocalModel preference
    if (!isCached && useLocalModel) {
      _logger.w('ChooseAiModelNotifier.build: model not cached but useLocalModel=true — resetting.');
      await _localStorage.writeBool(key: StorageKeys.useLocalModel, value: false);
      useLocalModel = false;
    }
    // EC-4: both flags dirty (old data) — prefer Gemini, reset local
    else if (isCached && useLocalModel && hasStoredApiKey && hasKeyInStorage) {
      _logger.w('ChooseAiModelNotifier.build: both useLocalModel=true and hasSavedApiKey=true — resetting useLocalModel.');
      await _localStorage.writeBool(key: StorageKeys.useLocalModel, value: false);
      useLocalModel = false;
    }

    _logger.d(
      'ChooseAiModelNotifier.build: DONE '
      'hasKeyInStorage=$hasKeyInStorage '
      'hasSavedApiKey=${hasStoredApiKey && hasKeyInStorage} '
      'isCached=$isCached useLocalModel=$useLocalModel',
    );

    return ChooseAiModelState(
      status: ChooseAiModelStatus.initial,
      apiKeyInput: storedApiKey ?? '',
      promptInput: '',
      hasSavedApiKey: hasStoredApiKey && hasKeyInStorage,
      hasKeyInStorage: hasKeyInStorage,
      responseText: null,
      error: null,
      selectedModel: storedModel,
      gemmaStatus: isCached
          ? GemmaDownloadStatus.downloaded
          : GemmaDownloadStatus.readyToDownload,
      useLocalModel: useLocalModel,
    );
  }

  Future<void> toggleLocalModel(bool value) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    try {
      await _localStorage.writeBool(key: StorageKeys.useLocalModel, value: value);

      if (value) {
        // Turning local ON — disable Gemini (Group 2 mutual exclusivity)
        await _localStorage.writeBool(
            key: StorageKeys.hasStoredGeminiApiKey, value: false);
        state = AsyncValue.data(
            currentState.copyWith(useLocalModel: true, hasSavedApiKey: false));
        _logger.i('useLocalModel=true: Gemini deactivated.');
      } else {
        state = AsyncValue.data(currentState.copyWith(useLocalModel: false));
        _logger.i('useLocalModel=false.');
      }
    } catch (error, stackTrace) {
      _logger.e('Failed to toggle useLocalModel preference.',
          error: error, stackTrace: stackTrace);
    }
  }

  void updateApiKeyInput(String value) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    state = AsyncValue.data(currentState.copyWith(
      status: ChooseAiModelStatus.initial,
      apiKeyInput: value,
      hasSavedApiKey: false,
      error: null,
    ));
  }

  void updatePromptInput(String value) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    state = AsyncValue.data(currentState.copyWith(
      status: currentState.hasSavedApiKey
          ? ChooseAiModelStatus.apiKeyReady
          : ChooseAiModelStatus.initial,
      promptInput: value,
      error: null,
      responseText: currentState.hasResponse ? currentState.responseText : null,
    ));
  }

  Future<void> updateSelectedModel(String modelId) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    if (currentState.selectedModel == modelId) return;

    state = AsyncValue.data(currentState.copyWith(
      status: ChooseAiModelStatus.selectingModel,
      error: null,
    ));

    try {
      await _localStorage.write(key: StorageKeys.selectedAiModel, value: modelId);
      state = AsyncValue.data(currentState.copyWith(
        selectedModel: modelId,
        status: currentState.hasSavedApiKey
            ? ChooseAiModelStatus.apiKeyReady
            : ChooseAiModelStatus.initial,
        responseText: null,
        error: null,
      ));
      _logger.i('Selected AI model updated: $modelId');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to update selected AI model.',
        error: error,
        stackTrace: stackTrace,
      );
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.requestFailed,
      ));
    }
  }

  Future<void> updateSelectedModelWithConfirmation(
    BuildContext context,
    String modelId,
    String displayName,
  ) async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;
    if (currentState.selectedModel == modelId) return;
    if (currentState.isSavingApiKey ||
        currentState.isSelectingModel ||
        currentState.status == ChooseAiModelStatus.error) {
      return;
    }
    final s = context.l10n;

    if (!context.mounted) return;
    showDialog<void>(
      context: context,
      builder: (_) => ConfirmDialog(
        title: displayName,
        subtitle: s.aiModelSelectModelConfirmMessage,
        confirmLabel: s.aiModelUseThisModel,
        cancelLabel: s.actionCancel,
        onConfirm: () => updateSelectedModel(modelId),
      ),
    );
  }

  Future<void> downloadLocalModel() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    _gemmaCancelToken = CancelToken();

    state = AsyncValue.data(currentState.copyWith(
      gemmaStatus: GemmaDownloadStatus.downloading,
      gemmaDownloadProgress: 0.0,
      gemmaDownloadError: null,
    ));

    try {
      await _modelRepository.downloadModel(
        onProgress: (progress) {
          final s = state.valueOrNull;
          if (s == null) return;
          state = AsyncValue.data(s.copyWith(gemmaDownloadProgress: progress));
        },
        cancelToken: _gemmaCancelToken,
      );

      // downloadModel returns normally on cancel (no rethrow) — check if cancelled
      final s = state.valueOrNull;
      if (s == null || s.gemmaStatus != GemmaDownloadStatus.downloading) return;

      state = AsyncValue.data(s.copyWith(
        gemmaStatus: GemmaDownloadStatus.downloaded,
        gemmaDownloadProgress: 1.0,
      ));
    } on DioException catch (e) {
      final s = state.valueOrNull;
      if (s == null) return;
      state = AsyncValue.data(s.copyWith(
        gemmaStatus: GemmaDownloadStatus.error,
        gemmaDownloadError: _mapDioError(e),
      ));
    } catch (e, st) {
      _logger.e('downloadLocalModel failed.', error: e, stackTrace: st);
      final s = state.valueOrNull;
      if (s == null) return;
      state = AsyncValue.data(s.copyWith(
        gemmaStatus: GemmaDownloadStatus.error,
        gemmaDownloadError: e.toString(),
      ));
    }
  }

  void cancelModelDownload() {
    _gemmaCancelToken?.cancel();
    _gemmaCancelToken = null;
    final s = state.valueOrNull;
    if (s == null) return;
    state = AsyncValue.data(s.copyWith(
      gemmaStatus: GemmaDownloadStatus.readyToDownload,
      gemmaDownloadProgress: 0.0,
      gemmaDownloadError: null,
    ));
  }

  Future<void> deleteLocalModel() async {
    final s = state.valueOrNull;
    if (s == null) return;
    state = AsyncValue.data(s.copyWith(gemmaStatus: GemmaDownloadStatus.deleting));
    await _modelRepository.deleteCachedModel();

    // EC-2: model deleted — clear useLocalModel so switch doesn't show ON with no model
    await _localStorage.writeBool(key: StorageKeys.useLocalModel, value: false);

    // Reset in-memory flutter_gemma state to avoid phantom "loaded" session
    _localGemmaService.reset();

    state = AsyncValue.data(state.valueOrNull!.copyWith(
      gemmaStatus: GemmaDownloadStatus.readyToDownload,
      gemmaDownloadProgress: 0.0,
      gemmaDownloadError: null,
      useLocalModel: false,
    ));
    _logger.i('deleteLocalModel: model deleted, useLocalModel reset, gemma service reset.');
  }

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 401 || code == 403) return 'Access denied to download link.';
        if (code == 404) return 'Model file not found.';
        return 'Server error ($code).';
      default:
        return e.message ?? 'Download failed. Please try again.';
    }
  }

  Future<void> saveApiKey() async {
    _logger.d('saveApiKey: CALLED — providerState=${state.runtimeType} valueOrNull=${state.valueOrNull != null}');
    final currentState = state.valueOrNull;
    if (currentState == null) {
      _logger.w('saveApiKey: ABORTED — provider not yet loaded (AsyncLoading/AsyncError)');
      return;
    }

    final normalizedApiKey = currentState.apiKeyInput.trim();
    _logger.d('saveApiKey: input length=${normalizedApiKey.length}');

    if (normalizedApiKey.isEmpty) {
      _logger.w('saveApiKey: empty API key — aborting.');
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.emptyApiKey,
        hasSavedApiKey: false,
      ));
      return;
    }

    // Reject keys with non-printable ASCII or control chars (e.g. newlines).
    // Valid Gemini API keys are printable ASCII only.
    final validKeyPattern = RegExp(r'^[\x20-\x7E]+$');
    if (!validKeyPattern.hasMatch(normalizedApiKey)) {
      _logger.w('saveApiKey: key contains invalid characters (non-ASCII or control chars).');
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.invalidApiKey,
        hasSavedApiKey: false,
      ));
      return;
    }

    _logger.i('saveApiKey: [1/4] setting loading state...');
    state = AsyncValue.data(currentState.copyWith(
      status: ChooseAiModelStatus.savingApiKey,
      error: null,
      hasSavedApiKey: false,
    ));

    try {
      _logger.i('saveApiKey: [2/4] validating key via Gemini API...');
      await _geminiService.validateApiKey(normalizedApiKey);
      _logger.i('saveApiKey: [2/4] key is valid.');

      _logger.i('saveApiKey: [3/4] writing to FlutterSecureStorage...');
      await _secureStorage.write(
        key: StorageKeys.userGeminiApiKey,
        value: normalizedApiKey,
      );
      await _localStorage.writeBool(
          key: StorageKeys.hasStoredGeminiApiKey, value: true);
      _logger.i('saveApiKey: [3/4] key saved. hasStoredGeminiApiKey=true');

      _logger.i('saveApiKey: [4/4] deactivating local model (EC-1)...');
      await _localStorage.writeBool(
          key: StorageKeys.useLocalModel, value: false);

      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.apiKeyReady,
        apiKeyInput: normalizedApiKey,
        hasSavedApiKey: true,
        hasKeyInStorage: true,
        useLocalModel: false,
        error: null,
      ));
      _logger.i('saveApiKey: [4/4] done. status=apiKeyReady hasSavedApiKey=true');
    } catch (error, stackTrace) {
      _logger.e('saveApiKey: FAILED.', error: error, stackTrace: stackTrace);
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: _mapError(error),
        hasSavedApiKey: false,
      ));
    }
  }

  Future<void> removeApiKey() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    state = AsyncValue.data(currentState.copyWith(
      status: ChooseAiModelStatus.savingApiKey,
    ));

    try {
      await _secureStorage.delete(key: StorageKeys.userGeminiApiKey);
      await _localStorage.writeBool(
        key: StorageKeys.hasStoredGeminiApiKey,
        value: false,
      );

      state = AsyncValue.data(ChooseAiModelState(
        status: ChooseAiModelStatus.initial,
        apiKeyInput: '',
        promptInput: currentState.promptInput,
        hasSavedApiKey: false,
        hasKeyInStorage: false,
        responseText: null,
        error: null,
      ));

      _logger.i('Gemini API key removed.');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to remove Gemini API key.',
        error: error,
        stackTrace: stackTrace,
      );
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.requestFailed,
      ));
    }
  }

  Future<void> disableApiKey() async {
    final currentState = state.valueOrNull;
    if (currentState == null || !currentState.hasSavedApiKey) return;

    state = AsyncValue.data(currentState.copyWith(
      status: ChooseAiModelStatus.savingApiKey,
    ));

    try {
      await _localStorage.writeBool(
        key: StorageKeys.hasStoredGeminiApiKey,
        value: false,
      );
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.initial,
        hasSavedApiKey: false,
        error: null,
      ));
      _logger.i('Gemini API key disabled (key preserved in storage).');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to disable Gemini API key.',
        error: error,
        stackTrace: stackTrace,
      );
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.requestFailed,
      ));
    }
  }

  Future<void> enableApiKey() async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.hasSavedApiKey) return;

    state = AsyncValue.data(currentState.copyWith(
      status: ChooseAiModelStatus.savingApiKey,
    ));

    try {
      final storedKey =
          await _secureStorage.read(StorageKeys.userGeminiApiKey);
      if (storedKey == null || storedKey.isEmpty) {
        state = AsyncValue.data(currentState.copyWith(
          status: ChooseAiModelStatus.initial,
        ));
        return;
      }
      // Group 2: turning Gemini ON — disable local model
      await _localStorage.writeBool(
          key: StorageKeys.hasStoredGeminiApiKey, value: true);
      await _localStorage.writeBool(
          key: StorageKeys.useLocalModel, value: false);
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.apiKeyReady,
        apiKeyInput: storedKey,
        hasSavedApiKey: true,
        useLocalModel: false,
        error: null,
      ));
      _logger.i('Gemini API key re-enabled: local model deactivated.');
    } catch (error, stackTrace) {
      _logger.e('Failed to enable Gemini API key.',
          error: error, stackTrace: stackTrace);
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.requestFailed,
      ));
    }
  }

  Future<void> sendPrompt() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    if (!currentState.hasSavedApiKey || currentState.apiKeyInput.trim().isEmpty) {
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.emptyApiKey,
        hasSavedApiKey: false,
      ));
      return;
    }

    final normalizedPrompt = currentState.promptInput.trim();
    if (normalizedPrompt.isEmpty) {
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.emptyPrompt,
      ));
      return;
    }

    state = AsyncValue.data(currentState.copyWith(
      status: ChooseAiModelStatus.sendingPrompt,
      error: null,
      responseText: null,
    ));

    try {
      final responseText = await _geminiService.generateContent(
        prompt: normalizedPrompt,
        model: currentState.selectedModel,
      );

      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.success,
        responseText: responseText?.trim(),
        error: null,
        hasSavedApiKey: true,
      ));
    } catch (error, stackTrace) {
      _logger.e(
        'Gemini prompt request failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: _mapError(error),
        hasSavedApiKey: true,
      ));
    }
  }

  Future<void> analyzeTransaction() async {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    if (!currentState.hasSavedApiKey) {
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.emptyApiKey,
      ));
      return;
    }

    final normalizedPrompt = currentState.promptInput.trim();
    if (normalizedPrompt.isEmpty) {
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: ChooseAiModelError.emptyPrompt,
      ));
      return;
    }

    state = AsyncValue.data(currentState.copyWith(
      status: ChooseAiModelStatus.analyzingTransaction,
      error: null,
      transactionAiResult: null,
    ));

    try {
      final categories =
          ref.read(categoryStreamProvider).valueOrNull ?? [];
      final languageCode =
          ref.read(changeLanguageProvider).localeCode;

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
        ocrResult: ReceiptOcrResult(rawText: normalizedPrompt),
        languageCode: languageCode,
        categories: categoryOptions,
      );

      final resultMap = await _geminiService.generateStructuredContent(
        systemInstruction: kReceiptAnalysisSystemInstruction,
        prompt: prompt,
        model: currentState.selectedModel,
      );

      if (resultMap == null) {
        state = AsyncValue.data(currentState.copyWith(
          status: ChooseAiModelStatus.error,
          error: ChooseAiModelError.emptyResponse,
        ));
        return;
      }

      TransactionAiResult result = TransactionAiResult.fromJson(resultMap);

      final validIds = categoryOptions.map((c) => c.key).toSet();
      if (validIds.contains(result.categoryKey)) {
        final matched = categories.firstWhere((c) => c.id == result.categoryKey);
        result = result.copyWith(categoryKey: matched.id);
      } else {
        _logger.w(
          'AI returned unknown categoryKey="${result.categoryKey}", falling back to default.',
        );
        final fallback = getDefaultCategoryForType(
          'expense',
          categories: categories,
        );
        result = result.copyWith(categoryKey: fallback.id);
      }

      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.transactionReady,
        transactionAiResult: result,
        error: null,
      ));
    } catch (error, stackTrace) {
      _logger.e(
        'analyzeTransaction failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = AsyncValue.data(currentState.copyWith(
        status: ChooseAiModelStatus.error,
        error: _mapError(error),
      ));
    }
  }

  ChooseAiModelError _mapError(dynamic error) {
    if (error is InvalidApiKey || error is UnsupportedUserLocation) {
      return ChooseAiModelError.invalidApiKey;
    }
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('timeout') || errorString.contains('timed out')) {
      return ChooseAiModelError.timedOut;
    }
    if (errorString.contains('empty') || errorString.contains('no text')) {
      return ChooseAiModelError.emptyResponse;
    }
    return ChooseAiModelError.requestFailed;
  }
}
