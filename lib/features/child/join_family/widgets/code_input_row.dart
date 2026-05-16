import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
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
    return Container(
      width: 44.r,
      height: 56.r,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isActive ? AppTheme.primary : borderColor,
          width: isActive ? 2 : 1,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        char,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
