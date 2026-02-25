import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_transaction_state.freezed.dart';

@freezed
abstract class UpdateTransactionState with _$UpdateTransactionState {
  const factory UpdateTransactionState.initial() = _Initial;
  const factory UpdateTransactionState.loading() = _Loading;
  const factory UpdateTransactionState.success() = _Success;
  const factory UpdateTransactionState.error(String message) = _Error;
}
