import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class OnboardingBottomPanel extends StatelessWidget {
  const OnboardingBottomPanel({
    super.key,
    required this.title,
    required this.description,
    required this.currentPage,
    required this.totalPages,
    required this.isDark,
    required this.isLoading,
    required this.onContinue,
  });

  final String title;
  final String description;
  final int currentPage;
  final int totalPages;
  final bool isDark;
  final bool isLoading;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 32.h,
        bottom: 48.h,
        left: 32.w,
        right: 32.w,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.r),
          topRight: Radius.circular(40.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20.r,
            offset: Offset(0, -10.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.typo.bigTitle.medium.copyWith(
              color: isDark ? AppTheme.primaryLight : AppTheme.primary,
              height: 1.25,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: context.typo.text.large.copyWith(
              color: isDark
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
          SizedBox(height: 48.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: 6.h,
                width: currentPage == index ? 24.w : 6.w,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? AppTheme.primary
                      : (isDark
                            ? const Color(0xFF334155)
                            : const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          PrimaryButton(
            text: currentPage == totalPages - 1 ? 'Bắt đầu' : 'Tiếp tục',
            isLoading: isLoading,
            onPressed: onContinue,
          ),
        ],
      ),
    );
  }
}
