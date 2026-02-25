import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_transaction_state.freezed.dart';

@freezed
abstract class DetailTransactionState with _$DetailTransactionState {
  const factory DetailTransactionState.initial() = _Initial;
  const factory DetailTransactionState.loading() = _Loading;
  const factory DetailTransactionState.success() = _Success;
  const factory DetailTransactionState.error(String message) = _Error;
}
