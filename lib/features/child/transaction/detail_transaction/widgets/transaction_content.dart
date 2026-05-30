import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
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
    final borderColor = isDark ? AppTheme.surfaceVariant : AppTheme.borderLight;
    final note = transaction.note;
    final hasNote = note != null && note.isNotEmpty;

    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SummaryHeader(transaction: transaction, isDark: isDark),
          Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: borderColor),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 24.r,
                        offset: Offset(0, 8.h),
                      ),
                    ],
            ),
            child: Column(
              children: [
                TransactionDetailRow(
                  icon: transaction.categoryEmoji ?? '📦',
                  label: s.transactionCategoryLabel,
                  value: transaction.category,
                  isDark: isDark,
                ),
                _Divider(color: borderColor),
                TransactionDetailRow(
                  icon: '📅',
                  label: s.transactionDetailTimeLabel,
                  value: DateFormat('dd/MM/yyyy – HH:mm').format(transaction.date),
                  isDark: isDark,
                ),
                if (hasNote) ...[
                  _Divider(color: borderColor),
                  TransactionDetailRow(
                    icon: '📝',
                    label: s.transactionDetailNoteLabel,
                    value: note,
                    isDark: isDark,
                  ),
                ],
                _Divider(color: borderColor),
                EvidenceSection(state: state, isDark: isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      thickness: 1.r,
      color: color,
    );
  }
}
