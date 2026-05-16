import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

/// Animated shimmer helper used by all skeleton widgets
class _Shimmer extends StatefulWidget {
  final Widget child;
  const _Shimmer({required this.child});

  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: widget.child);
  }
}

Widget _shimmerBox({
  required bool isDark,
  double? width,
  double height = 14,
  double radius = 8,
}) {
  return _Shimmer(
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(radius),
      ),
    ),
  );
}

// =============================================================================
// TRANSACTION ITEM SKELETON
// =============================================================================

/// Skeleton per single transaction item row
class TransactionItemSkeleton extends StatelessWidget {
  final bool isDark;
  const TransactionItemSkeleton({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Circle icon placeholder
          _Shimmer(
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Text placeholders
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(isDark: isDark, width: double.infinity),
                const SizedBox(height: 8),
                _shimmerBox(isDark: isDark, width: 100, height: 10),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Amount placeholder
          _shimmerBox(isDark: isDark, width: 72, height: 14),
        ],
      ),
    );
  }
}

// =============================================================================
// FULL PAGE SKELETON
// =============================================================================

/// Full-page skeleton shown on initial load
class TransactionHistorySkeleton extends StatelessWidget {
  final bool isDark;
  const TransactionHistorySkeleton({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final shimmerCardColor = isDark
        ? const Color(0xFF1E3A2F)
        : AppTheme.primary.withValues(alpha: 0.12);

    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        // Summary card skeleton
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: _Shimmer(
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: shimmerCardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        // Date group + 5 item skeletons × 2 groups
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, groupIndex) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _shimmerBox(isDark: isDark, width: 96, height: 10),
                      _shimmerBox(isDark: isDark, width: 64, height: 10),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 3 transaction item skeletons per group
                  ...List.generate(
                    3,
                    (_) => TransactionItemSkeleton(isDark: isDark),
                  ),
                ],
              ),
            ),
            childCount: 2,
          ),
        ),
      ],
    );
  }
}
