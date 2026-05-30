import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class SplashLoadingSection extends StatelessWidget {
  const SplashLoadingSection({
    super.key,
    required this.progress,
  });

  final int progress;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progressValue = progress / 100;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 200),
      padding: const EdgeInsets.only(bottom: 48, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween<double>(begin: 0, end: progress.toDouble()),
              builder: (context, value, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'LOADING',
                      style: context.typo.caption.large.copyWith(
                        color: isDark
                            ? AppTheme.primaryLight.withValues(alpha: 0.8)
                            : AppTheme.primary.withValues(alpha: 0.8),
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      '${value.toInt()}%',
                      style: context.typo.caption.large.copyWith(
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  isDark ? AppTheme.borderDark : AppTheme.borderLight,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                tween: Tween<double>(begin: 0, end: progressValue),
                builder: (context, value, _) {
                  return FractionallySizedBox(
                    widthFactor: value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withValues(alpha: 0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'PhiÃªn báº£n 1.0.2',
            style: context.typo.caption.small.copyWith(
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
