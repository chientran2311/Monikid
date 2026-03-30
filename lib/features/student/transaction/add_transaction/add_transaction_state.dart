import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/student/transaction/transaction_status.dart';

part 'add_transaction_state.freezed.dart';

@freezed
abstract class AddTransactionState with _$AddTransactionState {
  const factory AddTransactionState({
    @Default(TransactionStatus.initial) TransactionStatus status,
    String? errorMessage,
  }) = _AddTransactionState;

  const AddTransactionState._();

  bool get isLoading => status == TransactionStatus.loading;
}
