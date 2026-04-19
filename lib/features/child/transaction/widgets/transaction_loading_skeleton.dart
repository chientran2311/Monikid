import 'package:flutter/material.dart';
import 'package:monikid/shared/widgets/skeleton.dart';

class TransactionEditorLoadingSkeleton extends StatelessWidget {
  const TransactionEditorLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 140),
        child: _TransactionEditorSkeletonContent(),
      ),
    );
  }
}

class TransactionEditorLoadingOverlay extends StatelessWidget {
  const TransactionEditorLoadingOverlay({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Container(
        color: (isDark ? Colors.black : Colors.white).withValues(alpha:  0.32),
        child: const  SafeArea(
          child: SingleChildScrollView(
            padding:  EdgeInsets.fromLTRB(24, 24, 24, 140),
            child:  _TransactionEditorSkeletonContent(),
          ),
        ),
      ),
    );
  }
}

class _TransactionEditorSkeletonContent extends StatelessWidget {
  const _TransactionEditorSkeletonContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Skeleton(height: 48, width: double.infinity, borderRadius: 12),
        SizedBox(height: 32),
        Skeleton(height: 20, width: 120),
        SizedBox(height: 16),
        Skeleton(height: 64, width: 220, borderRadius: 16),
        SizedBox(height: 32),
        Skeleton(height: 72, width: double.infinity, borderRadius: 16),
        SizedBox(height: 16),
        Skeleton(height: 72, width: double.infinity, borderRadius: 16),
        SizedBox(height: 16),
        Skeleton(height: 120, width: double.infinity, borderRadius: 16),
      ],
    );
  }
}

class TransactionDetailLoadingOverlay extends StatelessWidget {
  const TransactionDetailLoadingOverlay({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Container(
        color: (isDark ? Colors.black : Colors.white).withValues(alpha:  0.32),
        child: const SafeArea(
          child: Padding(
            padding:  EdgeInsets.all(20),
            child: Column(
              children:  [
                SizedBox(height: 24),
                Skeleton(height: 80, width: 80, borderRadius: 40),
                SizedBox(height: 16),
                Skeleton(height: 18, width: 120),
                SizedBox(height: 12),
                Skeleton(height: 40, width: 180),
                SizedBox(height: 24),
                Skeleton(height: 220, width: double.infinity, borderRadius: 24),
                SizedBox(height: 24),
                Skeleton(height: 128, width: double.infinity, borderRadius: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionDetailLoadingSkeleton extends StatelessWidget {
  const TransactionDetailLoadingSkeleton({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? Colors.black : Colors.white;
    final surfaceColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final borderColor = isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9);

    return Container(
      color: bgColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            // Avatar circle
            const Skeleton(height: 80, width: 80, borderRadius: 40),
            const SizedBox(height: 16),
            // Category name skeleton
            const Skeleton(height: 16, width: 120),
            const SizedBox(height: 8),
            // Amount skeleton
            const Skeleton(height: 40, width: 180),
            const SizedBox(height: 24),
            // Detail card skeleton
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: borderColor),
              ),
              child: const Column(
                children: [
                  _DetailRowSkeleton(),
                  SizedBox(height: 16),
                  _DetailRowSkeleton(),
                  SizedBox(height: 16),
                  _DetailRowSkeleton(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Map placeholder skeleton
            Skeleton(
              height: 128,
              width: double.infinity,
              borderRadius: 16,
              color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRowSkeleton extends StatelessWidget {
  const _DetailRowSkeleton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1E293B)
                : const Color(0xFFF8FAFC),
            shape: BoxShape.circle,
          ),
          child: const Skeleton(height: 40, width: 40, borderRadius: 20),
        ),
        const SizedBox(width: 16),
       const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Skeleton(height: 10, width: 80),
              SizedBox(height: 8),
              Skeleton(height: 16, width: double.infinity),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryDialogLoadingSkeleton extends StatelessWidget {
  const CategoryDialogLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Skeleton(height: 56, width: 56, borderRadius: 28),
              SizedBox(height: 8),
              Skeleton(height: 12, width: 68),
            ],
          );
        },
      ),
    );
  }
}
