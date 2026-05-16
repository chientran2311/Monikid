import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class CurrencyOptionTile extends StatelessWidget {
  const CurrencyOptionTile({
    super.key,
    required this.label,
    required this.symbol,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final String symbol;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final textColor =
        isSelected ? Theme.of(context).colorScheme.onSurface : AppTheme.textGrey;
    final borderColor = isSelected
        ? AppTheme.primary
        : AppTheme.textWhite.withValues(alpha: 0);

    return Material(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: borderColor, width: 2.w),
            boxShadow: [
              BoxShadow(
                color: AppTheme.textBlack.withValues(alpha: 0.04),
                blurRadius: 12.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Row(
            children: [
              _CurrencyBadge(symbol: symbol),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.textLarge,
                    weight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              _RadioMark(isSelected: isSelected, isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencyBadge extends StatelessWidget {
  const _CurrencyBadge({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.r,
      height: 42.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppTheme.primaryLight,
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.borderLight, width: 1.w),
      ),
      child: Text(
        symbol,
        style: AppTextStyleFactory.style(
          size: AppFontSizes.subtitleSmall,
          weight: FontWeight.w800,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

class _RadioMark extends StatelessWidget {
  const _RadioMark({required this.isSelected, required this.isDark});

  final bool isSelected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 24.r,
      height: 24.r,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppTheme.primary : borderColor,
          width: 2.w,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary
              : AppTheme.textWhite.withValues(alpha: 0),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
