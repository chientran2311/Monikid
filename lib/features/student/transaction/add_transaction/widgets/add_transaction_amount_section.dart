import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monikid/core/theme/theme.dart';

class AddTransactionAmountSection extends StatelessWidget {
  const AddTransactionAmountSection({
    super.key,
    required this.controller,
    required this.enabled,
    required this.textColor,
  });

  final TextEditingController controller;
  final bool enabled;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Số tiền',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            IntrinsicWidth(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                enabled: enabled,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                decoration: const InputDecoration(
                  hintText: '0',
                  hintStyle: TextStyle(color: Color(0xFFCBD5E1)),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'đ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
        Container(
          width: 100,
          height: 4,
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
