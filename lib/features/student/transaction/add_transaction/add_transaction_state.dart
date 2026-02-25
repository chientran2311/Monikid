import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_transaction_state.freezed.dart';

@freezed
abstract class AddTransactionState with _$AddTransactionState {
  const factory AddTransactionState.initial() = _Initial;
  const factory AddTransactionState.loading() = _Loading;
  const factory AddTransactionState.success() = _Success;
  const factory AddTransactionState.error(String message) = _Error;
}
