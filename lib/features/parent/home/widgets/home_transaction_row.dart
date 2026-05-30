import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class HomeTransactionRow extends StatelessWidget {
  const HomeTransactionRow({
    super.key,
    required this.tx,
    required this.textColor,
    required this.mutedColor,
    required this.borderColor,
    required this.showDivider,
  });

  final TransactionModel tx;
  final Color textColor;
  final Color mutedColor;
  final Color borderColor;
  final bool showDivider;

  static ({IconData icon, Color bg, Color fg}) _iconConfig(
    String categoryKey,
    String type,
  ) {
    if (type != 'expense') {
      return (
        icon: Icons.payments_rounded,
        bg: AppTheme.primaryLight,
        fg: AppTheme.primary,
      );
    }
    final k = categoryKey.toLowerCase();
    if (k.contains('snack') ||
        k.contains('food') ||
        k.contains('restaurant') ||
        k.contains('cafeteria')) {
      return (
        icon: Icons.restaurant_rounded,
        bg: AppTheme.amberFill,
        fg: AppTheme.amberText,
      );
    }
    if (k.contains('game') || k.contains('esport') || k.contains('app_store')) {
      return (
        icon: Icons.sports_esports_rounded,
        bg: AppTheme.infoSurface,
        fg: AppTheme.chartBlue,
      );
    }
    if (k.contains('book') ||
        k.contains('school') ||
        k.contains('study') ||
        k.contains('notebook')) {
      return (
        icon: Icons.menu_book_rounded,
        bg: AppTheme.primaryLight,
        fg: AppTheme.primary,
      );
    }
    if (k.contains('gift')) {
      return (
        icon: Icons.card_giftcard_rounded,
        bg: AppTheme.dangerSurface,
        fg: AppTheme.redAlert,
      );
    }
    if (k.contains('movie') ||
        k.contains('cinema') ||
        k.contains('entertainment')) {
      return (
        icon: Icons.movie_outlined,
        bg: AppTheme.infoSurface,
        fg: AppTheme.chartPurple,
      );
    }
    return (
      icon: Icons.shopping_bag_outlined,
      bg: AppTheme.amberFill,
      fg: AppTheme.orangeWarning,
    );
  }

  // 'new' | 'edited' | null
  String? get _tag {
    final created = tx.createdAt;
    final updated = tx.updatedAt;
    if (created == null) return null;
    if (updated == null || !updated.isAfter(created)) return 'new';
    return 'edited';
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final cfg = _iconConfig(tx.categoryKey, tx.type);
    final isExpense = tx.type == 'expense';
    final amountColor = isExpense ? AppTheme.redAlert : AppTheme.chartBlue;
    final amountText =
        '${isExpense ? '-' : '+'}${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(tx.amount)}';
    final dateText = DateFormat('dd MMM, HH:mm').format(tx.date);
    final tag = _tag;

    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: cfg.bg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(cfg.icon, color: cfg.fg, size: 20.r),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              tx.categoryLabel,
                              style: context.typo.body.big.copyWith(
                                fontWeight: FontWeight.w600,
                                color: textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (tag != null) ...[
                            SizedBox(width: 6.w),
                            _TagBadge(
                              label: tag == 'new'
                                  ? s.homeParTransactionTagNew
                                  : s.homeParTransactionTagEdited,
                              isNew: tag == 'new',
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        dateText,
                        style: context.typo.body.small.copyWith(color: mutedColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  amountText,
                  style: context.typo.body.big.copyWith(
                    fontWeight: FontWeight.w600,
                    color: amountColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(height: 1, thickness: 0.5, color: borderColor),
      ],
    );
  }
}

class _TagBadge extends StatelessWidget {
  const _TagBadge({required this.label, required this.isNew});

  final String label;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final bg = isNew ? AppTheme.primaryLight : AppTheme.amberFill;
    final fg = isNew ? AppTheme.primary : AppTheme.amberText;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: context.typo.caption.medium.copyWith(
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}
