import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class HomeTransactionRow extends ConsumerStatefulWidget {
  const HomeTransactionRow({
    super.key,
    required this.tx,
    required this.isDark,
    this.memberName,
    this.onTap,
  });

  final TransactionModel tx;
  final bool isDark;
  final String? memberName;
  final VoidCallback? onTap;

  @override
  ConsumerState<HomeTransactionRow> createState() => _HomeTransactionRowState();
}

class _HomeTransactionRowState extends ConsumerState<HomeTransactionRow> {
  bool _pressed = false;

  static ({IconData icon, Color bg, Color fg, Color borderColor}) _iconConfig(
    String categoryKey,
    String type,
  ) {
    if (type != 'expense') {
      return (
        icon: Icons.payments_rounded,
        bg: AppTheme.txCategoryTopupBg,
        fg: AppTheme.primary,
        borderColor: AppTheme.txCategoryTopupBorder,
      );
    }
    final k = categoryKey.toLowerCase();
    if (k.contains('snack') ||
        k.contains('food') ||
        k.contains('restaurant') ||
        k.contains('cafeteria')) {
      return (
        icon: Icons.restaurant_rounded,
        bg: AppTheme.txCategoryFoodBg,
        fg: AppTheme.txCategoryFoodIcon,
        borderColor: AppTheme.txCategoryFoodBorder,
      );
    }
    if (k.contains('game') ||
        k.contains('esport') ||
        k.contains('app_store')) {
      return (
        icon: Icons.sports_esports_rounded,
        bg: AppTheme.infoSurface,
        fg: AppTheme.chartBlue,
        borderColor: AppTheme.infoBorder,
      );
    }
    if (k.contains('book') ||
        k.contains('school') ||
        k.contains('study') ||
        k.contains('notebook') ||
        k.contains('education')) {
      return (
        icon: Icons.menu_book_rounded,
        bg: AppTheme.txCategoryBookBg,
        fg: AppTheme.primary,
        borderColor: AppTheme.txCategoryBookBorder,
      );
    }
    if (k.contains('gift')) {
      return (
        icon: Icons.card_giftcard_rounded,
        bg: AppTheme.dangerSurface,
        fg: AppTheme.redAlert,
        borderColor: AppTheme.dangerBorder,
      );
    }
    if (k.contains('movie') ||
        k.contains('cinema') ||
        k.contains('entertainment')) {
      return (
        icon: Icons.movie_outlined,
        bg: AppTheme.txCategoryOtherBg,
        fg: AppTheme.txCategoryOtherIcon,
        borderColor: AppTheme.txCategoryOtherBorder,
      );
    }
    return (
      icon: Icons.shopping_bag_outlined,
      bg: AppTheme.txCategoryFoodBg,
      fg: AppTheme.txStatusWarnIcon,
      borderColor: AppTheme.txCategoryFoodBorder,
    );
  }

  bool get _isEdited {
    final created = widget.tx.createdAt;
    final updated = widget.tx.updatedAt;
    if (created == null || updated == null) return false;
    return updated.isAfter(created);
  }

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final tx = widget.tx;
    final categories = ref.watch(categoryStreamProvider).value ?? defaultCategories;
    final categoryLabel =
        findCategoryByTransactionKey(categories, tx.categoryKey)?.label ??
        tx.categoryLabel;
    final cfg = _iconConfig(tx.categoryKey, tx.type);
    final isExpense = tx.type == 'expense';

    final amountColor = isExpense
        ? (widget.isDark ? Colors.white : AppTheme.homeParFg)
        : AppTheme.chartBlue;
    final amountText =
        '${isExpense ? '-' : '+'}${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(tx.amount).trim()}đ';

    final timeText = DateFormat('dd/MM, HH:mm').format(tx.date);
    final merchant = tx.merchantName?.isNotEmpty == true
        ? tx.merchantName!
        : tx.note?.isNotEmpty == true
            ? tx.note!
            : null;

    final title = widget.memberName != null
        ? '${widget.memberName} - $categoryLabel'
        : categoryLabel;

    return AnimatedScale(
      scale: _pressed ? 0.98 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onTap?.call();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isDark
                ? AppTheme.surfaceDark
                : Colors.white.withValues(alpha: 0.88),
            border: Border.all(
              color:
                  widget.isDark ? AppTheme.borderDark : AppTheme.borderLight,
            ),
            borderRadius: BorderRadius.circular(22.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? cfg.bg.withValues(alpha: 0.2)
                      : cfg.bg,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: cfg.borderColor),
                ),
                child: Icon(cfg.icon, color: cfg.fg, size: 20.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w900,
                              color: widget.isDark
                                  ? Colors.white
                                  : AppTheme.textBlack,
                              letterSpacing: -0.015 * 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (_isEdited) ...[
                          SizedBox(width: 6.w),
                          _TagBadge(label: s.homeParTransactionTagEdited),
                        ],
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          timeText,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: widget.isDark
                                ? AppTheme.textMuted
                                : AppTheme.textGrey,
                          ),
                        ),
                        if (merchant != null) ...[
                          SizedBox(width: 8.w),
                          _Dot(isDark: widget.isDark),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: Text(
                              merchant,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: widget.isDark
                                    ? AppTheme.textMuted
                                    : AppTheme.textGrey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    amountText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                      color: amountColor,
                      letterSpacing: -0.02 * 14,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  _StatusBadge(label: s.homeParTransactionSuccess),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagBadge extends StatelessWidget {
  const _TagBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.amberFill,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: AppTheme.amberText,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.r,
            height: 6.r,
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.r,
      height: 4.r,
      decoration: BoxDecoration(
        color: (isDark ? AppTheme.textMuted : AppTheme.textGrey)
            .withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
    );
  }
}
