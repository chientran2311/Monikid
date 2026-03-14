import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_request_money_state.freezed.dart';

@freezed
abstract class AddRequestMoneyState with _$AddRequestMoneyState {
  const factory AddRequestMoneyState({
    @Default(0.0) double amount,
    @Default('snacks') String category,
    @Default('') String note,
    @Default([]) List<String> recipients,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = _AddRequestMoneyState;

  const AddRequestMoneyState._();
}
