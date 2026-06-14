import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:monikid/models/entities/transaction_model.dart';

part 'category_transaction_list_state.freezed.dart';

enum CategoryTransactionListStatus { initial, loading, success, empty, error }

@freezed
abstract class CategoryTransactionListState
    with _$CategoryTransactionListState {
  const factory CategoryTransactionListState({
    @Default(CategoryTransactionListStatus.initial)
    CategoryTransactionListStatus status,
    @Default([]) List<TransactionModel> transactions,
    String? errorMessage,
  }) = _CategoryTransactionListState;

  const CategoryTransactionListState._();

  bool get isLoading => status == CategoryTransactionListStatus.loading;
  bool get hasError => status == CategoryTransactionListStatus.error;
}
