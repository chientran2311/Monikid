import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class LanguageOptionTile extends StatelessWidget {
  const LanguageOptionTile({
    super.key,
    required this.flag,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String flag;
  final String label;
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
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
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
              Text(
                flag,
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.titleLarge,
                  weight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyleFactory.style(
                    size: AppFontSizes.subtitleSmall,
                    weight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ),
              _SelectionMark(isSelected: isSelected, isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionMark extends StatelessWidget {
  const _SelectionMark({required this.isSelected, required this.isDark});

  final bool isSelected;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 24.r,
      height: 24.r,
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.primary
            : AppTheme.textWhite.withValues(alpha: 0),
        shape: BoxShape.circle,
        border: isSelected ? null : Border.all(color: borderColor, width: 2.w),
      ),
      child: isSelected
          ? Icon(Icons.check_rounded, color: AppTheme.textWhite, size: 16.r)
          : const SizedBox.shrink(),
    );
  }
}
