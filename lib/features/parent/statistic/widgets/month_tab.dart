import 'package:flutter/material.dart';

class MonthTab extends StatelessWidget {
  final String title;
  final bool isActive;
  final Color primaryColor;
  final Color unselectedColor;

  const MonthTab({
    Key? key,
    required this.title,
    required this.isActive,
    required this.primaryColor,
    required this.unselectedColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isActive ? 16 : 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? primaryColor : unselectedColor,
          ),
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
