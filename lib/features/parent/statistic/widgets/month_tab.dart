import 'package:flutter/material.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class MonthTab extends StatelessWidget {
  final String title;
  final bool isActive;
  final Color primaryColor;
  final Color unselectedColor;

  const MonthTab({
    super.key,
    required this.title,
    required this.isActive,
    required this.primaryColor,
    required this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: (isActive
              ? context.typo.subtitle.small.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                )
              : context.typo.body.medium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: unselectedColor,
                )),
        ),
        const SizedBox(height: 4),
        Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
