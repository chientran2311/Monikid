import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ParentTopCategoriesSection extends StatelessWidget {
  const ParentTopCategoriesSection({
    super.key,
    required this.isDark,
    this.items = const [],
    this.onItemTap,
  });

  final bool isDark;
  final List<ParentCategoryItem> items;
  final ValueChanged<ParentCategoryItem>? onItemTap;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Text(
            s.parentStatisticTopCategoriesTitle.toUpperCase(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: mutedColor,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        if (items.isEmpty)
          _EmptyState(isDark: isDark)
        else
          Container(
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: borderColor, width: 0.5),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Column(
              children: List.generate(items.length, (i) {
                final item = items[i];
                final isLast = i == items.length - 1;
                return _CategoryRow(
                  item: item,
                  isDark: isDark,
                  showDivider: !isLast,
                  onTap: onItemTap != null ? () => onItemTap!(item) : null,
                );
              }),
            ),
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Text(
        s.parentStatisticNoData,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14.sp, color: mutedColor),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.item,
    required this.isDark,
    required this.showDivider,
    this.onTap,
  });

  final ParentCategoryItem item;
  final bool isDark;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: item.iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: item.iconColor, size: 20.r),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        item.transactionLabel,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: mutedColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  item.amount,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.chevron_right_rounded,
                    size: 20.r, color: mutedColor),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, thickness: 0.5, color: borderColor),
      ],
    );
  }
}

class ParentCategoryItem {
  const ParentCategoryItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.name,
    required this.transactionLabel,
    required this.amount,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String name;
  final String transactionLabel;
  final String amount;
}
