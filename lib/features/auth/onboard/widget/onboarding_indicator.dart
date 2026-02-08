import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
class OnboardingIndicator extends StatelessWidget {
  final int activeIndex;
  final int totalCount;

  const OnboardingIndicator({
    Key? key, 
    required this.activeIndex, 
    this.totalCount = 3
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalCount, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: isActive ? 30 : 8, // Active thì dài ra
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primaryGreen : Colors.white24,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}