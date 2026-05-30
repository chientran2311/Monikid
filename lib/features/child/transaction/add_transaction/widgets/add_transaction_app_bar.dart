import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class AddTransactionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddTransactionAppBar({
    super.key,
    required this.title,
    required this.cancelLabel,
    required this.onCancel,
    required this.isDark,
    required this.backgroundColor,
    required this.textColor,
    required this.enabled,
  });

  final String title;
  final String cancelLabel;
  final VoidCallback onCancel;
  final bool isDark;
  final Color backgroundColor;
  final Color textColor;
  final bool enabled;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leadingWidth: 80,
      leading: TextButton(
        onPressed: enabled ? onCancel : null,
        child: Text(
          cancelLabel,
          style: context.typo.subtitle.small.copyWith(fontWeight: FontWeight.w500, color: isDark ? AppTheme.textMuted : AppTheme.textGrey),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: context.typo.subtitle.medium.copyWith(fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}
