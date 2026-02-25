import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final Color textSubColor;

  const LegendItem({
    Key? key,
    required this.label,
    required this.color,
    required this.textSubColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textSubColor,
          ),
        ),
      ],
    );
  }
}
