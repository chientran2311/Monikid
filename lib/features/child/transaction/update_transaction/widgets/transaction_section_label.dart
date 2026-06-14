import 'package:flutter/material.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';

class TransactionSectionLabel extends StatelessWidget {
  const TransactionSectionLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTextStyleFactory.style(
        size: AppFontSizes.bodySmall,
        weight: FontWeight.w700,
        color: AppTheme.textGrey,
        letterSpacing: 0.5,
      ),
    );
  }
}
