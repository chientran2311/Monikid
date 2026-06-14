import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'transaction_filter_state.dart';

part 'transaction_filter_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionFilterNotifier extends _$TransactionFilterNotifier {
  late final Logger _logger;

  @override
  TransactionFilterState build() {
    _logger = getIt<Logger>();
    return const TransactionFilterState();
  }

  void getTransByDate(DateTime? date) {
    if (state.selectedDate == date) return;
    _logger.d('Transaction filter — date: $date');
    state = state.copyWith(selectedDate: date);
  }

  void getTransByCategory(String? categoryKey) {
    if (state.selectedCategoryKey == categoryKey) return;
    _logger.d('Transaction filter — category: $categoryKey');
    state = state.copyWith(selectedCategoryKey: categoryKey);
  }

  void setTypeFilter(String type) {
    if (state.transactionTypeFilter == type) return;
    _logger.d('Transaction filter — type: $type');
    state = state.copyWith(transactionTypeFilter: type);
  }
}
