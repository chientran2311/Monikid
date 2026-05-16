import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_state.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/evidence_section.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/summary_header.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/transaction_detail_row.dart';

class TransactionContent extends ConsumerWidget {
  const TransactionContent({super.key, required this.state, required this.isDark});

  final DetailTransactionState state;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = state.transaction!;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          SummaryHeader(transaction: transaction),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark
                    ? AppTheme.surfaceVariant
                    : AppTheme.surfaceLightGrey,
              ),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              children: [
                TransactionDetailRow(
                  iconData: Icons.calendar_today,
                  label: s.transactionDetailTimeLabel,
                  value: DateFormat(
                    'dd/MM/yyyy - HH:mm',
                  ).format(transaction.date),
                  isDark: isDark,
                ),
                Divider(
                  color: isDark
                      ? AppTheme.surfaceVariant
                      : AppTheme.surfaceLightGrey,
                  height: 32,
                ),
                if (transaction.note != null &&
                    transaction.note!.isNotEmpty) ...[
                  Divider(
                    color: isDark
                        ? AppTheme.surfaceVariant
                        : AppTheme.surfaceLightGrey,
                    height: 32,
                  ),
                  TransactionDetailRow(
                    iconData: Icons.description_outlined,
                    label: s.transactionDetailNoteLabel,
                    value: transaction.note!,
                    isDark: isDark,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          EvidenceSection(state: state, isDark: isDark),
        ],
      ),
    );
  }
}
