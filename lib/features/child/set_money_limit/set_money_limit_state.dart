import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_money_limit_state.freezed.dart';

enum SetMoneyLimitStatus {
  initial,
  loading,
  ready,
  saving,
  success,
  error,
}

enum SetMoneyLimitValidationError {
  empty,
  nonPositive,
  unauthenticated,
  saveFailed,
}

@freezed
abstract class SetMoneyLimitState with _$SetMoneyLimitState {
  const factory SetMoneyLimitState({
    @Default(SetMoneyLimitStatus.initial) SetMoneyLimitStatus status,
    String? userId,
    int? storedLimitMinor,
    @Default('') String amountInput,
    SetMoneyLimitValidationError? validationError,
  }) = _SetMoneyLimitState;

  const SetMoneyLimitState._();

  bool get hasStoredLimit =>
      storedLimitMinor != null && storedLimitMinor! > 0;

  bool get isLoading => status == SetMoneyLimitStatus.loading;
  bool get isReady =>
      status == SetMoneyLimitStatus.ready ||
      status == SetMoneyLimitStatus.success;
  bool get isSaving => status == SetMoneyLimitStatus.saving;
  bool get isError => status == SetMoneyLimitStatus.error;
}
