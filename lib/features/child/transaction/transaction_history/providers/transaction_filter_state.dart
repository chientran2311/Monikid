import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_filter_state.freezed.dart';

@freezed
abstract class TransactionFilterState with _$TransactionFilterState {
  const factory TransactionFilterState({
    DateTime? selectedDate,
    String? selectedCategoryKey,
    // 'all' | 'income' | 'expense'
    @Default('all') String transactionTypeFilter,
  }) = _TransactionFilterState;

  const TransactionFilterState._();

  bool get hasFilter =>
      selectedDate != null ||
      selectedCategoryKey != null ||
      transactionTypeFilter != 'all';

  String? get activeType => transactionTypeFilter == 'all' ? null : transactionTypeFilter;
}
