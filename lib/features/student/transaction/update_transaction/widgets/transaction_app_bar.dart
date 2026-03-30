import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';

class TransactionAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TransactionAppBar({
    super.key,
    required this.isDark,
    required this.textColor,
    required this.canPop,
  });

  final bool isDark;
  final Color textColor;
  final bool canPop;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isDark
          ? AppTheme.backgroundDark.withOpacity(0.95)
          : AppTheme.backgroundLight.withOpacity(0.95),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: textColor),
        onPressed: canPop ? () => context.pop() : null,
      ),
      title: Text(
        'Chỉnh sửa Giao dịch',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
