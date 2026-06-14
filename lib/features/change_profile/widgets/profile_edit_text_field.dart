import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ProfileEditTextField extends StatelessWidget {
  const ProfileEditTextField({
    super.key,
    required this.controller,
    this.hint,
    this.errorText,
    required this.onChanged,
    this.enabled = true,
    this.keyboardType,
    required this.isDark,
  });

  final TextEditingController controller;
  final String? hint;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final TextInputType? keyboardType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    const disabledTextColor = AppTheme.textMuted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: context.typo.body.big.copyWith(
            color: enabled ? textColor : disabledTextColor,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppTheme.textMuted,
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: 4.h),
          Text(
            errorText!,
            style: context.typo.caption.big.copyWith(color: AppTheme.redAlert),
          ),
        ],
      ],
    );
  }
}
