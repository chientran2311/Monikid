import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/widgets/transaction_detail_evidence_section.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/widgets/transaction_detail_info_row.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class ParentTransactionDetailCard extends StatelessWidget {
  const ParentTransactionDetailCard({
    required this.transaction,
    required this.isDark,
    super.key,
  });

  final TransactionModel transaction;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final isEdited = transaction.updatedAt != null &&
        transaction.createdAt != null &&
        transaction.updatedAt!.isAfter(transaction.createdAt!);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Stack(
        children: [
          if (isEdited)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  context.l10n.homeParTransactionTagEdited,
                  style: context.typo.caption.small.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                transaction.categoryIcon ?? '💸',
                style: context.typo.display.big,
              ),
              SizedBox(height: 12.h),
              Text(
                CurrencyFormatter.format(transaction.amountMinor),
                style: context.typo.display.small.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                transaction.categoryLabel,
                style: context.typo.body.medium.copyWith(color: mutedColor),
              ),
              SizedBox(height: 24.h),
              TransactionDetailInfoRow(
                label: context.l10n.transactionDetailTimeLabel,
                value: DateFormat('dd/MM/yyyy - HH:mm').format(transaction.date),
                isDark: isDark,
              ),
              if (transaction.createdAt != null) ...[
                SizedBox(height: 16.h),
                TransactionDetailInfoRow(
                  label: context.l10n.transactionDetailCreatedAtLabel,
                  value: DateFormat('dd/MM/yyyy - HH:mm')
                      .format(transaction.createdAt!),
                  isDark: isDark,
                ),
              ],
              if (transaction.note != null && transaction.note!.isNotEmpty) ...[
                SizedBox(height: 16.h),
                TransactionDetailInfoRow(
                  label: context.l10n.transactionDetailNoteLabel,
                  value: transaction.note!,
                  isDark: isDark,
                ),
              ],
              if (transaction.evidenceImage != null) ...[
                SizedBox(height: 24.h),
                TransactionDetailEvidenceSection(
                  evidenceImage: transaction.evidenceImage!,
                  isDark: isDark,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
