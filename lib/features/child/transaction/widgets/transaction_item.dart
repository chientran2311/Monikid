import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/l10n/app_localizations.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class TransactionItem extends ConsumerWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    this.onTap,
    this.showBadge = true,
  });

  final TransactionModel transaction;
  final VoidCallback? onTap;
  final bool showBadge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryStreamProvider).value ?? defaultCategories;
    final categoryLabel =
        findCategoryByTransactionKey(categories, transaction.categoryKey)?.label ??
        transaction.categoryLabel;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isExpense = transaction.type == 'expense';
    final style = _catStyleFor(transaction.categoryKey);
    final emoji = transaction.categoryIcon ?? (isExpense ? '🛍️' : '💸');
    final title = (transaction.note?.isNotEmpty ?? false)
        ? transaction.note!
        : categoryLabel;
    final amountStr =
        '${isExpense ? '-' : '+'}${CurrencyFormatter.format(transaction.amountMinor.toDouble())}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.surfaceDark.withValues(alpha: 0.88)
              : Colors.white.withValues(alpha: 0.88),
          border: Border.all(
            color: isDark
                ? AppTheme.borderDark
                : AppTheme.primary.withValues(alpha: 0.16),
          ),
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.06),
              blurRadius: 28.r,
              offset: Offset(0, 12.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: EdgeInsets.all(13.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _CategoryIcon(emoji: emoji, style: style),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _TransactionContent(
                      title: title,
                      date: transaction.dateTs,
                      categoryLabel: categoryLabel,
                      isDark: isDark,
                      s: context.l10n,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  if (showBadge)
                    _AmountBadge(
                      amountStr: amountStr,
                      isExpense: isExpense,
                      isEdited: transaction.updatedAt != null &&
                          transaction.createdAt != null &&
                          transaction.updatedAt!.isAfter(transaction.createdAt!),
                      isDark: isDark,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({required this.emoji, required this.style});

  final String emoji;
  final _CatStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.r,
      height: 44.r,
      decoration: BoxDecoration(
        color: style.bg,
        border: Border.all(color: style.border),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Text(emoji, style: TextStyle(fontSize: 18.sp)),
      ),
    );
  }
}

class _TransactionContent extends StatelessWidget {
  const _TransactionContent({
    required this.title,
    required this.date,
    required this.categoryLabel,
    required this.isDark,
    required this.s,
  });

  final String title;
  final DateTime date;
  final String categoryLabel;
  final bool isDark;
  final AppLocalizations s;

  @override
  Widget build(BuildContext context) {
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.typo.body.medium.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.2,
            color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Text(
              _metaText(date, s),
              style: context.typo.caption.medium.copyWith(color: mutedColor),
            ),
            SizedBox(width: 6.w),
            Container(
              width: 4.r,
              height: 4.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: mutedColor.withValues(alpha: 0.5),
              ),
            ),
            SizedBox(width: 6.w),
            Flexible(
              child: Text(
                categoryLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    context.typo.caption.medium.copyWith(color: mutedColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AmountBadge extends StatelessWidget {
  const _AmountBadge({
    required this.amountStr,
    required this.isExpense,
    required this.isEdited,
    required this.isDark,
  });

  final String amountStr;
  final bool isExpense;
  final bool isEdited;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final badgeBg = isEdited
        ? (isDark ? AppTheme.darkWarningSurface : AppTheme.amberFill)
        : AppTheme.primary.withValues(alpha: 0.10);
    final badgeTextColor = isEdited
        ? (isDark ? AppTheme.darkWarningText : AppTheme.amberText)
        : AppTheme.primary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          amountStr,
          style: context.typo.body.medium.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.3,
            color: isExpense ? AppTheme.redAlert : AppTheme.primary,
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: badgeBg,
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Text(
            isEdited ? s.homeParTransactionTagEdited : s.homeParTransactionTagNew,
            style: context.typo.caption.small.copyWith(
              fontWeight: FontWeight.w800,
              color: badgeTextColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _CatStyle {
  const _CatStyle({required this.bg, required this.border});
  final Color bg;
  final Color border;
}

_CatStyle _catStyleFor(String categoryKey) {
  final k = categoryKey.toLowerCase();
  if (k.contains('food') ||
      k.contains('an_uong') ||
      k.contains('eat') ||
      k.contains('drink')) {
    return const _CatStyle(
      bg: AppTheme.txCategoryFoodBg,
      border: AppTheme.txCategoryFoodBorder,
    );
  }
  if (k.contains('school') ||
      k.contains('hoc_phi') ||
      k.contains('education') ||
      k.contains('fee')) {
    return const _CatStyle(
      bg: AppTheme.txCategorySchoolBg,
      border: AppTheme.txCategorySchoolBorder,
    );
  }
  if (k.contains('topup') ||
      k.contains('nap_tien') ||
      k.contains('income') ||
      k.contains('thu_nhap') ||
      k.contains('deposit')) {
    return const _CatStyle(
      bg: AppTheme.txCategoryTopupBg,
      border: AppTheme.txCategoryTopupBorder,
    );
  }
  if (k.contains('book') ||
      k.contains('hoc_tap') ||
      k.contains('learning') ||
      k.contains('study')) {
    return const _CatStyle(
      bg: AppTheme.txCategoryBookBg,
      border: AppTheme.txCategoryBookBorder,
    );
  }
  return const _CatStyle(
    bg: AppTheme.txCategoryOtherBg,
    border: AppTheme.txCategoryOtherBorder,
  );
}

String _metaText(DateTime date, AppLocalizations s) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final txDay = DateTime(date.year, date.month, date.day);
  final time = DateFormat('HH:mm').format(date);
  if (txDay == today) return '$time · ${s.dateToday}';
  final yesterday = today.subtract(const Duration(days: 1));
  if (txDay == yesterday) return '${s.dateYesterday} · $time';
  return '${DateFormat('dd MMM').format(date)} · $time';
}
