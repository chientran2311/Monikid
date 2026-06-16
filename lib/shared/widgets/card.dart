import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class Card extends StatelessWidget {
  const Card({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryGreen,
            AppTheme.surface,
            AppTheme.surface.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: context.typo.body.medium.copyWith(color: AppTheme.textGrey),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$12,450.00',
                style: context.typo.display.medium.copyWith(
                  color: AppTheme.textWhite,
                ),
              ),
              Icon(
                Icons.visibility_outlined,
                color: AppTheme.textGrey.withValues(alpha: 0.5),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(height: 1, color: Colors.white10),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppTheme.primaryGreen, size: 16),
              const SizedBox(width: 4),
              Text(
                '+ \$450.00 this month',
                style: context.typo.button.small.copyWith(
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
