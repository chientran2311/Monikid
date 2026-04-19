import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class SplashBrandSection extends StatelessWidget {
  const SplashBrandSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 800),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: child,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SplashLogo(isDark: isDark),
              Text(
                'SmartSpending',
                textAlign: TextAlign.center,
                style: context.typo.bigTitle.medium.copyWith(
                  letterSpacing: -0.5,
                  color: isDark ? AppTheme.primaryLight : AppTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Quáº£n lÃ½ thÃ´ng minh, tÆ°Æ¡ng lai vá»¯ng bá»n',
                textAlign: TextAlign.center,
                style: context.typo.label.large.copyWith(
                  letterSpacing: 0.25,
                  color:
                      isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    const rotationAngle = 3 * math.pi / 180;

    return Container(
      width: 112,
      height: 112,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppTheme.primary.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Transform.rotate(
        angle: rotationAngle,
        child: Center(
          child: Transform.rotate(
            angle: -rotationAngle,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  size: 64,
                  color: AppTheme.primary,
                ),
                Positioned(
                  top: -8,
                  right: -8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.backgroundDark : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.eco,
                      size: 34,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
