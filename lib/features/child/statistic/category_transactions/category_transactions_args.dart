import 'package:monikid/features/transaction/transaction_type.dart';

class CategoryTransactionsArgs {
  const CategoryTransactionsArgs({
    required this.categoryKey,
    required this.categoryLabel,
    this.categoryIcon,
    required this.selectedTabIndex,
    required this.anchorDate,
    this.transactionType = TransactionType.expense,
  });

  final String categoryKey;
  final String categoryLabel;
  final String? categoryIcon;
  final int selectedTabIndex;
  final DateTime anchorDate;
  final TransactionType transactionType;
}
