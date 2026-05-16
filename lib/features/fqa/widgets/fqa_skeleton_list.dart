import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:monikid/core/theme/theme.dart';

class FQASkeletonList extends StatelessWidget {
  const FQASkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 12),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLightGrey,
          highlightColor: isDark ? AppTheme.borderDark : AppTheme.surfaceVeryLight,
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }
}
