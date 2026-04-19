import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';

part 'request_money_history_state.freezed.dart';

@freezed
abstract class RequestMoneyHistoryState with _$RequestMoneyHistoryState {
  const factory RequestMoneyHistoryState({
    RequestMoneyModel? request,
    @Default(false) bool isSaving,
    @Default(false) bool isDeleting,
    String? errorMessage,
    @Default(false) bool isSuccess,
  }) = _RequestMoneyHistoryState;

  const RequestMoneyHistoryState._();
}
