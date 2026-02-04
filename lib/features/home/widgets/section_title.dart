import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.textWhite,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
