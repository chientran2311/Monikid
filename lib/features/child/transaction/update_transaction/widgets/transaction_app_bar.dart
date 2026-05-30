import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

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
          ? AppTheme.backgroundDark.withValues(alpha: 0.95)
          : AppTheme.backgroundLight.withValues(alpha: 0.95),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: textColor),
        onPressed: canPop ? () => context.pop() : null,
      ),
      title: Text(
        s.updateTransactionTitle,
        style: context.typo.subtitle.medium.copyWith(fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}
