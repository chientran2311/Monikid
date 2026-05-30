import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class TransactionDetailRow extends StatelessWidget {
  const TransactionDetailRow({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    required this.isDark,
  });

  final String icon;
  final String label;
  final String? value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final labelColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final valueColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final bgColor = isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLightGrey;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: Text(icon, style: TextStyle(fontSize: 18.sp)),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: labelColor,
                    ),
                  ),
                  if (value != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      value!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: valueColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
