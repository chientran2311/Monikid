import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/statistic/statistic_models.dart';
import 'package:monikid/features/child/statistic/widgets/statistic_ui_helpers.dart';

class StatisticTopCategoriesSection extends StatelessWidget {
  const StatisticTopCategoriesSection({
    super.key,
    required this.categories,
    required this.onViewAll,
  });

  final List<StatisticCategoryData> categories;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final visibleCategories = categories
        .where((item) => item.amountMinor > 0)
        .take(5)
        .toList(growable: false);
    if (visibleCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26.r),
        border: Border.all(color: AppTheme.borderLight),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D111811),
            blurRadius: 28,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.statisticTopCategoriesTitle,
                  style: context.typo.title.medium.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textBlack,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              InkWell(
                onTap: onViewAll,
                borderRadius: BorderRadius.circular(14.r),
                child: Ink(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Text(
                    context.l10n.homeStudentViewAll,
                    style: context.typo.caption.big.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ...List.generate(visibleCategories.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < visibleCategories.length - 1 ? 12.h : 0,
              ),
              child: _TrendItem(
                category: visibleCategories[index],
                iconBackground: _iconBackground(index),
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _iconBackground(int index) {
    const backgrounds = [
      Color(0xFFEEF7EE),
      Color(0xFFE8F5E9),
      Color(0xFFEDF7EE),
      Color(0xFFEEF8F1),
      Color(0xFFF1F7F1),
    ];
    return backgrounds[index % backgrounds.length];
  }
}

class _TrendItem extends StatelessWidget {
  const _TrendItem({
    required this.category,
    required this.iconBackground,
  });

  final StatisticCategoryData category;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    final sharePercent = (category.shareRatio * 100).toStringAsFixed(0);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 46.w,
          height: 46.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: iconBackground,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            category.categoryIcon ?? '•',
            style: TextStyle(fontSize: 20.sp),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.categoryLabel,
                style: context.typo.body.medium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textBlack,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                context.l10n.statisticTransactionCount(
                  category.transactionCount,
                ),
                style: context.typo.caption.medium.copyWith(
                  color: AppTheme.textGrey,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              context.formatStatisticCurrency(category.amountMinor),
              style: context.typo.body.medium.copyWith(
                fontWeight: FontWeight.w800,
                color: AppTheme.textBlack,
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              '$sharePercent%',
              style: context.typo.caption.medium.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.textGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
