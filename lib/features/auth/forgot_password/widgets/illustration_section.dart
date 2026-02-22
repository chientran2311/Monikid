import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

/// Widget minh họa cho màn hình Forgot Password
/// Hiển thị icon lock_reset trong circle với gradient background
class IllustrationSection extends StatelessWidget {
  const IllustrationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    // Kích thước illustration responsive theo màn hình
    final illustrationSize = screenWidth * 0.55;

    return Center(
      child: Container(
        width: illustrationSize,
        height: illustrationSize,
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.primary.withOpacity(0.1)
              : AppTheme.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            // Gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primary.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Icon + dots
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Main icon circle
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.lock_reset_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Decorative dots
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildDot(0.4),
                      const SizedBox(width: 8),
                      _buildDot(0.2),
                      const SizedBox(width: 8),
                      _buildDot(0.1),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(double opacity) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}
