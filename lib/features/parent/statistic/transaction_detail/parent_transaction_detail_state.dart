import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:monikid/models/entities/transaction_model.dart';

part 'parent_transaction_detail_state.freezed.dart';

enum ParentTransactionDetailStatus { initial, loading, success, empty, error }

@freezed
abstract class ParentTransactionDetailState with _$ParentTransactionDetailState {
  const factory ParentTransactionDetailState({
    @Default(ParentTransactionDetailStatus.initial)
    ParentTransactionDetailStatus status,
    TransactionModel? transaction,
    String? errorMessage,
  }) = _ParentTransactionDetailState;

  const ParentTransactionDetailState._();

  bool get isLoading => status == ParentTransactionDetailStatus.loading;

  bool get hasError => status == ParentTransactionDetailStatus.error;
}
