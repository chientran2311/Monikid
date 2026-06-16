import 'package:flutter/material.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final Color textSubColor;

  const LegendItem({
    super.key,
    required this.label,
    required this.color,
    required this.textSubColor,
  });

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
          style: context.typo.caption.big.copyWith(
          fontWeight: FontWeight.w500,
          color: textSubColor,
        ),
        ),
      ],
    );
  }
}
