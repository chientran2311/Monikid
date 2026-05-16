import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/models/entities/fqa/fqa_model.dart';

class FQAItem extends StatelessWidget {
  const FQAItem({
    required this.item,
    required this.isExpanded,
    required this.onTap,
    super.key,
  });

  final FQAModel item;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLight;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.surfaceVeryDark;
    final textSubColor = isDark ? AppTheme.textMuted : AppTheme.textDark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isExpanded
                ? AppTheme.primary.withValues(alpha: 0.2)
                : AppTheme.primary.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: isExpanded
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.question,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.expand_more,
                      color: AppTheme.primary,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: isExpanded
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        left: 12,
                        right: 12,
                        bottom: 12,
                        top: 4,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: isDark
                                  ? AppTheme.borderDark
                                  : AppTheme.surfaceLightGrey,
                            ),
                          ),
                        ),
                        child: Text(
                          item.answer,
                          style: TextStyle(
                            color: textSubColor,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
