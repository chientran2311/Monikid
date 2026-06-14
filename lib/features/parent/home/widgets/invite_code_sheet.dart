import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class InviteCodeDialog extends HookConsumerWidget {
  const InviteCodeDialog({
    super.key,
    required this.inviteCode,
  });

  final String inviteCode;

  String get _formattedCode {
    if (inviteCode.length == 6) {
      return '${inviteCode.substring(0, 3)} ${inviteCode.substring(3)}';
    }
    return inviteCode;
  }

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
        child: _InviteCard(
          inviteCode: inviteCode,
          formattedCode: _formattedCode,
        ),
      ),
    );
  }
}

class _InviteCard extends StatelessWidget {
  const _InviteCard({
    required this.inviteCode,
    required this.formattedCode,
  });

  final String inviteCode;
  final String formattedCode;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.all(28.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
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
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Icon(
                  Icons.person_add_rounded,
                  color: AppTheme.primary,
                  size: 32.w,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                s.homeParInviteTitle,
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
                  s.homeParInviteDesc,
                  textAlign: TextAlign.center,
                  style: context.typo.body.medium.copyWith(
                    fontSize: 15.sp,
                    height: 1.5,
                    color: AppTheme.textGrey,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkBorder : AppTheme.surfaceGrey,
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(
                    color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    formattedCode,
                    style: context.typo.display.big.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 10,
                      color: isDark ? AppTheme.darkTextPrimary : AppTheme.textBlack,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 28.h),
              PrimaryButton(
                title: s.actionDone,
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: inviteCode));
                  if (!context.mounted) return;
                  context.showSuccessSnackBar(s.homeParCodeCopied);
                  context.pop();
                },
                height: 56.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
