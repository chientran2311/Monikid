import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ProfileEditTextField extends StatelessWidget {
  const ProfileEditTextField({
    super.key,
    required this.label,
    this.hint,
    required this.initialValue,
    this.errorText,
    required this.onChanged,
    this.icon,
    this.enabled = true,
    this.keyboardType,
    required this.isDark,
  });

  final String label;
  final String? hint;
  final String initialValue;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final IconData? icon;
  final bool enabled;
  final TextInputType? keyboardType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final surfaceColor = isDark ? AppTheme.surfaceVariant : AppTheme.backgroundLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final labelColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final iconColor = isDark ? AppTheme.textGrey : AppTheme.textMuted;
    final disabledTextColor = isDark ? AppTheme.textGrey : AppTheme.textMuted;
    final disabledFillColor = isDark ? AppTheme.backgroundDark : AppTheme.surfaceLightGrey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(
            label,
            style: context.typo.body.medium.copyWith(
              fontWeight: FontWeight.w600,
              color: labelColor,
            ),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: context.typo.body.big.copyWith(
            color: enabled ? textColor : disabledTextColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: iconColor),
            filled: true,
            fillColor: enabled ? surfaceColor : disabledFillColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            prefixIcon: icon != null
                ? Icon(icon, color: iconColor, size: 20.r)
                : null,
            suffixIcon: !enabled
                ? Icon(Icons.lock, color: iconColor, size: 20.r)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppTheme.primary, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: borderColor),
            ),
            errorText: errorText,
            errorStyle: context.typo.caption.big.copyWith(
              color: AppTheme.redAlert,
            ),
          ),
        ),
      ],
    );
  }
}
