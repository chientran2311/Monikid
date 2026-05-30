import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class ParentStatisticErrorCard extends StatelessWidget {
  const ParentStatisticErrorCard({
    required this.isDark,
    required this.message,
    required this.onRetry,
    super.key,
  });

  final bool isDark;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.0 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.typo.body.medium.copyWith(
              color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
            ),
          ),
          SizedBox(height: 12.h),
          TextButton(onPressed: onRetry, child: Text(s.parentStatisticRetry)),
        ],
      ),
    );
  }
}
