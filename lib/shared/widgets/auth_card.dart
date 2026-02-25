import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15, // shadow-lg equivalent
            spreadRadius: -3,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            spreadRadius: -2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
