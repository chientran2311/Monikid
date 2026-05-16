import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'transaction_filter_state.dart';

part 'transaction_filter_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionFilterNotifier extends _$TransactionFilterNotifier {
  @override
  TransactionFilterState build() {
    return const TransactionFilterState();
  }

  void getTransByDate(DateTime? date) {
    if (state.selectedDate == date) return;
    state = state.copyWith(selectedDate: date);
  }

  void getTransByCategory(String? categoryKey) {
    if (state.selectedCategoryKey == categoryKey) return;
    state = state.copyWith(selectedCategoryKey: categoryKey);
  }

  void setTypeFilter(String type) {
    if (state.transactionTypeFilter == type) return;
    state = state.copyWith(transactionTypeFilter: type);
  }
}
