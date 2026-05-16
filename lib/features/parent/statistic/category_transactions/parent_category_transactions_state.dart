import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:monikid/models/entities/transaction_model.dart';

part 'parent_category_transactions_state.freezed.dart';

enum ParentCategoryTransactionsStatus { initial, loading, success, empty, error }

@freezed
abstract class ParentCategoryTransactionsState
    with _$ParentCategoryTransactionsState {
  const factory ParentCategoryTransactionsState({
    @Default(ParentCategoryTransactionsStatus.initial)
    ParentCategoryTransactionsStatus status,
    @Default([]) List<TransactionModel> transactions,
    String? errorMessage,
  }) = _ParentCategoryTransactionsState;

  const ParentCategoryTransactionsState._();

  bool get isLoading => status == ParentCategoryTransactionsStatus.loading;

  bool get hasError => status == ParentCategoryTransactionsStatus.error;
}
