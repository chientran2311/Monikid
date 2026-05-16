import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
