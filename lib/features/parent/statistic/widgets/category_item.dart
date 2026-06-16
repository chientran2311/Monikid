import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final String percentage;
  final double value;
  final Color color;
  final Color bgColor;
  final Color surfaceColor;
  final Color borderColor;
  final Color textColor;
  final Color textSubColor;
  final bool isDark;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.percentage,
    required this.value,
    required this.color,
    required this.bgColor,
    required this.surfaceColor,
    required this.borderColor,
    required this.textColor,
    required this.textSubColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: context.typo.body.medium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    Text(
                      amount,
                      style: context.typo.body.medium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: value,
                          backgroundColor: isDark
                              ? AppTheme.textGreyDarker
                              : AppTheme.surfaceGrey,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 32,
                      child: Text(
                        percentage,
                        textAlign: TextAlign.right,
                        style: context.typo.caption.big.copyWith(
                          fontWeight: FontWeight.w500,
                          color: textSubColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
