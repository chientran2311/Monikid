import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/dev_tools/dev_tools_state.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class FaqMockCard extends StatelessWidget {
  const FaqMockCard({
    super.key,
    required this.status,
    this.message,
    required this.onSeed,
  });

  final DevToolsOpStatus status;
  final String? message;
  final VoidCallback onSeed;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;
    final isLoading = status == DevToolsOpStatus.loading;

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.quiz_outlined, color: AppTheme.primary, size: 20.r),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FAQ Mock',
                    style: context.typo.subtitle.small.copyWith(
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Text(
                    '10 items (vi + en)',
                    style: context.typo.caption.medium.copyWith(color: mutedColor),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          PrimaryButton(
            title: 'Seed Mock FAQ',
            isLoading: isLoading,
            onTap: isLoading ? null : onSeed,
          ),
          if (message != null) ...[
            SizedBox(height: 8.h),
            Text(
              message!,
              style: context.typo.caption.medium.copyWith(
                color: status == DevToolsOpStatus.error
                    ? Colors.redAccent
                    : AppTheme.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
