import 'package:flutter/material.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class SummaryMiniCard extends StatelessWidget {
  const SummaryMiniCard({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final String amount;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTight = constraints.maxHeight < 88.h;
        final iconSize = isTight ? 18.r : 22.r;
        final titleFontSize = isTight ? 13.r : 16.r;
        final amountFontSize = isTight ? 16.r : 20.r;
        final textGap = isTight ? 6.w : 10.w;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon, size: iconSize, color: iconColor),
                  SizedBox(width: textGap),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  amount,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: amountFontSize,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
