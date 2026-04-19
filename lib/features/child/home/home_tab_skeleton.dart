import 'package:flutter/material.dart';
import '../../../shared/widgets/skeleton.dart';

class HomeTabSkeleton extends StatelessWidget {
  const HomeTabSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              left: 24.0,
              right: 24.0,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(height: 16, width: 100),
                    SizedBox(height: 8),
                    Skeleton(height: 24, width: 150),
                  ],
                ),
                Skeleton(height: 48, width: 48, borderRadius: 24),
              ],
            ),
          ),

          // Summary Card
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Skeleton(
              height: 200,
              width: double.infinity,
              borderRadius: 24,
            ),
          ),

          // Quick actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => const Column(
                  children: [
                    Skeleton(height: 60, width: 60, borderRadius: 20),
                    SizedBox(height: 8),
                    Skeleton(height: 14, width: 60),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Recent text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Skeleton(height: 24, width: 180),
          ),

          const SizedBox(height: 16),

          // Transaction items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: List.generate(
                4,
                (index) => const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    children: [
                      Skeleton(height: 50, width: 50, borderRadius: 16),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Skeleton(height: 16, width: 120),
                            SizedBox(height: 8),
                            Skeleton(height: 14, width: 80),
                          ],
                        ),
                      ),
                      Skeleton(height: 16, width: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
