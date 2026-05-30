import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class CodeInputRow extends StatelessWidget {
  const CodeInputRow({
    super.key,
    required this.code,
    required this.isDark,
    required this.surfaceColor,
    required this.borderColor,
    required this.textColor,
    required this.onTap,
    this.onLongPress,
  });

  final String code;
  final bool isDark;
  final Color surfaceColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(6, (i) {
          final char = i < code.length ? code[i] : '';
          final isActive = i == code.length;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: _CodeBox(
              char: char,
              isActive: isActive,
              surfaceColor: surfaceColor,
              borderColor: borderColor,
              textColor: textColor,
            ),
          );
        }),
      ),
    );
  }
}

class _CodeBox extends StatelessWidget {
  const _CodeBox({
    required this.char,
    required this.isActive,
    required this.surfaceColor,
    required this.borderColor,
    required this.textColor,
  });

  final String char;
  final bool isActive;
  final Color surfaceColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isActive ? 1.05 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 44.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isActive
                ? AppTheme.primary.withValues(alpha: 0.45)
                : borderColor,
            width: isActive ? 1.5 : 1.0,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.12),
                    blurRadius: 0,
                    spreadRadius: 4.r,
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          char,
          style: context.typo.title.big.copyWith(color: textColor),
        ),
      ),
    );
  }
}
