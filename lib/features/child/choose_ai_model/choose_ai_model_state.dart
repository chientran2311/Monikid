import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';

part 'choose_ai_model_state.freezed.dart';

class GeminiModelOption {
  const GeminiModelOption({
    required this.displayName,
    required this.modelId,
  });

  final String displayName;
  final String modelId;
}

const kGeminiModelOptions = [
  GeminiModelOption(displayName: 'Gemini 2.5 Flash', modelId: 'gemini-2.5-flash'),
  GeminiModelOption(displayName: 'Gemma 4 31B', modelId: 'gemma-4-31b-it'),
  GeminiModelOption(displayName: 'Gemini 3 Flash', modelId: 'gemini-3.0-flash'),
  GeminiModelOption(displayName: 'Gemini 3.1 Flash Lite', modelId: 'gemini-3.1-flash-lite'),
];

enum ChooseAiModelStatus {
  initial,
  savingApiKey,
  selectingModel,
  apiKeyReady,
  sendingPrompt,
  success,
  analyzingTransaction,
  transactionReady,
  error,
}

enum ChooseAiModelError {
  emptyApiKey,
  emptyPrompt,
  invalidApiKey,
  timedOut,
  emptyResponse,
  requestFailed,
}

enum GemmaDownloadStatus {
  idle,
  checkingCache,
  readyToDownload,
  downloading,
  downloaded,
  deleting,
  error,
}

@freezed
abstract class ChooseAiModelState with _$ChooseAiModelState {
  const factory ChooseAiModelState({
    @Default(ChooseAiModelStatus.initial) ChooseAiModelStatus status,
    @Default('') String apiKeyInput,
    @Default('') String promptInput,
    @Default(false) bool hasSavedApiKey,
    @Default('gemini-2.5-flash') String selectedModel,
    String? responseText,
    TransactionAiResult? transactionAiResult,
    ChooseAiModelError? error,
    @Default(GemmaDownloadStatus.idle) GemmaDownloadStatus gemmaStatus,
    @Default(0.0) double gemmaDownloadProgress,
    String? gemmaDownloadError,
  }) = _ChooseAiModelState;

  const ChooseAiModelState._();

  bool get isSavingApiKey => status == ChooseAiModelStatus.savingApiKey;
  bool get isSelectingModel => status == ChooseAiModelStatus.selectingModel;
  bool get isSendingPrompt => status == ChooseAiModelStatus.sendingPrompt;
  bool get isAnalyzingTransaction =>
      status == ChooseAiModelStatus.analyzingTransaction;
  bool get isBusy =>
      isSavingApiKey ||
      isSelectingModel ||
      isSendingPrompt ||
      isAnalyzingTransaction;
  bool get hasError => status == ChooseAiModelStatus.error && error != null;
  bool get hasResponse =>
      responseText != null && responseText!.trim().isNotEmpty;
  bool get hasTransactionResult => transactionAiResult != null;

  bool get isGemmaDownloading => gemmaStatus == GemmaDownloadStatus.downloading;
  bool get isGemmaDownloaded => gemmaStatus == GemmaDownloadStatus.downloaded;
  bool get isGemmaDeleting => gemmaStatus == GemmaDownloadStatus.deleting;
  bool get isGemmaError => gemmaStatus == GemmaDownloadStatus.error;
}
