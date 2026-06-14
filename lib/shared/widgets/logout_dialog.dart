import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class LogoutDialog extends HookConsumerWidget {
  const LogoutDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );
    final anim = CurvedAnimation(
      parent: ctrl,
      curve: const Cubic(0.175, 0.885, 0.32, 1.275),
    );
    useEffect(() {
      ctrl.forward();
      return null;
    }, const []);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: AnimatedBuilder(
        animation: anim,
        builder: (_, child) => Transform.scale(
          scale: 0.9 + 0.1 * anim.value,
          child: Transform.translate(
            offset: Offset(0, 10.h * (1 - anim.value)),
            child: child,
          ),
        ),
        child: _DialogCard(
          title: title,
          message: message,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
        ),
      ),
    );
  }
}

class _DialogCard extends StatelessWidget {
  const _DialogCard({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.all(28.w),
          decoration: BoxDecoration(
            color: isDark
                ? AppTheme.surfaceDark.withValues(alpha: 0.94)
                : Colors.white.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(
              color: isDark
                  ? AppTheme.darkBorder
                  : Colors.white.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 30.h),
                blurRadius: 60.r,
                color: Colors.black.withValues(alpha: 0.15),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  color: AppTheme.dangerSurface,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: AppTheme.redDark,
                  size: 32.w,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.typo.headline.small.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.typo.body.medium.copyWith(
                    fontSize: 15.sp,
                    height: 1.5,
                    color: AppTheme.textGrey,
                  ),
                ),
              ),
              SizedBox(height: 28.h),
              PrimaryButton.danger(
                title: confirmLabel,
                onTap: () => context.pop(true),
                height: 56.h,
              ),
              SizedBox(height: 12.h),
              PrimaryButton.secondary(
                title: cancelLabel,
                onTap: () => context.pop(false),
                height: 56.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
