import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_item.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class GroupedTransactionList extends StatelessWidget {
  final Map<String, List<TransactionModel>> grouped;
  final bool isDark;
  final void Function(TransactionModel) onTap;
  final bool showBadge;

  const GroupedTransactionList({
    super.key,
    required this.grouped,
    required this.isDark,
    required this.onTap,
    this.showBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    final dateKeys = grouped.keys.toList();

    if (dateKeys.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Text(
              'Không có giao dịch nào.',
              style: context.typo.body.medium.copyWith(color: isDark ? Colors.white54 : AppTheme.textMuted),
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final dateKey = dateKeys[index];
        final dateTxs = grouped[dateKey]!;

        double dailyTotal = 0;
        for (final tx in dateTxs) {
          dailyTotal += tx.type == 'expense' ? -tx.amount : tx.amount;
        }
        final isIncome = dailyTotal >= 0;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dateKey.toUpperCase(),
                    style: context.typo.caption.medium.copyWith(fontWeight: FontWeight.w600, color: AppTheme.textMuted, letterSpacing: 0.5),
                  ),
                  Text(
                    '${isIncome ? '+' : '-'} ${CurrencyFormatter.format(dailyTotal.abs())}',
                    style: context.typo.caption.medium.copyWith(fontWeight: FontWeight.w500, color: isIncome
                          ? const Color(0xFF2563eb)
                          : AppTheme.redAlert),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...dateTxs.map(
                (tx) =>
                    TransactionItem(transaction: tx, onTap: () => onTap(tx), showBadge: showBadge),
              ),
            ],
          ),
        );
      }, childCount: dateKeys.length),
    );
  }
}
