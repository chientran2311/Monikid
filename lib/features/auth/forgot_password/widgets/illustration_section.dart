import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class IllustrationSection extends StatelessWidget {
  const IllustrationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          constraints: BoxConstraints(minHeight: 152.h),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.74),
                Colors.white.withValues(alpha: 0.44),
              ],
            ),
            border: Border.all(
              color: Color.lerp(Colors.white, AppTheme.primary, 0.18)!,
            ),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -62.h,
                right: -52.w,
                child: Container(
                  width: 220.r,
                  height: 220.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color.lerp(Colors.white, AppTheme.primary, 0.14)!,
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.68],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -40.w,
                bottom: -48.h,
                child: Container(
                  width: 150.r,
                  height: 150.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Color.lerp(Colors.white, AppTheme.primary, 0.12)!,
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.70],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Center(child: _MailVisual(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MailVisual extends StatelessWidget {
  const _MailVisual(this.parentContext);
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    return SizedBox(
      width: 168.w,
      height: 114.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Center(child: _MailCard()),
          Positioned(left: 12.w, top: 20.h, child: const _FloatingDot('@')),
          Positioned(right: 16.w, top: 14.h, child: const _FloatingDot('✉')),
          Positioned(right: 8.w, bottom: 16.h, child: const _FloatingDot('✓')),
          Positioned(
            left: 0,
            right: 0,
            bottom: -4.h,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.lerp(Colors.white, AppTheme.primary, 0.18)!,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.10),
                      blurRadius: 28.r,
                      offset: Offset(0, 14.h),
                    ),
                  ],
                ),
                child: Text(
                  s.forgotPasswordChipLabel,
                  style: context.typo.label.small.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textBlack,
                    letterSpacing: -0.01,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MailCard extends StatelessWidget {
  const _MailCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.w,
      height: 68.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.lerp(Colors.white, AppTheme.primary, 0.14)!,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: Color.lerp(Colors.white, AppTheme.primary, 0.24)!,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.12),
            blurRadius: 40.r,
            offset: Offset(0, 24.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18.w),
            height: 2.h,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 18.w),
            height: 2.h,
            decoration: BoxDecoration(
              color: Color.lerp(Colors.white, AppTheme.primary, 0.28)!,
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingDot extends StatelessWidget {
  const _FloatingDot(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.r,
      height: 30.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Color.lerp(Colors.white, AppTheme.primary, 0.10)!,
          ],
        ),
        border: Border.all(
          color: Color.lerp(Colors.white, AppTheme.primary, 0.24)!,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.10),
            blurRadius: 24.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w900,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }
}
