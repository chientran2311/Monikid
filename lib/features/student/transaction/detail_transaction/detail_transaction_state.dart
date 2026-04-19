import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/features/student/transaction/transaction_status.dart';
import 'package:monikid/models/entities/transaction_model.dart';

part 'detail_transaction_state.freezed.dart';

@freezed
abstract class DetailTransactionState with _$DetailTransactionState {
  const factory DetailTransactionState({
    @Default(TransactionStatus.initial) TransactionStatus status,
    String? currentTransactionId,
    TransactionModel? transaction,
    String? errorMessage,
  }) = _DetailTransactionState;

  const DetailTransactionState._();

  bool get isLoading => status == TransactionStatus.loading;
  bool get isDeleting => status == TransactionStatus.submitting;
}
