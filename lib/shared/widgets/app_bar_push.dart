import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';

/// Custom AppBar with back button and title
/// Used for screens that need navigation back functionality
class AppBarPush extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPush({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
  });

  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark;

    return AppBar(
      backgroundColor: isDark
          ? AppTheme.surfaceDark.withValues(alpha: 0.9)
          : AppTheme.surfaceLight.withValues(alpha: 0.9),
      elevation: 1,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20),
        color: AppTheme.primary,
        onPressed: onBackPressed ?? () => context.pop(),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      actions: actions,
    );
  }
}
