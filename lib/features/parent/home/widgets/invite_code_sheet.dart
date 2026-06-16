import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/parent/home/invite_code_provider.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/skeleton.dart';

class InviteCodeDialog extends HookConsumerWidget {
  const InviteCodeDialog({super.key, required this.familyId});

  final String familyId;

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

    final codeAsync = ref.watch(familyInviteCodeProvider(familyId));

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
          familyId: familyId,
          codeAsync: codeAsync,
        ),
      ),
    );
  }
}

class _InviteCard extends ConsumerWidget {
  const _InviteCard({required this.familyId, required this.codeAsync});

  final String familyId;
  final AsyncValue<String> codeAsync;

  String _formatCode(String code) {
    if (code.length == 6) {
      return '${code.substring(0, 3)} ${code.substring(3)}';
    }
    return code;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              _CodeBox(
                isDark: isDark,
                codeAsync: codeAsync,
                familyId: familyId,
                formatCode: _formatCode,
              ),
              SizedBox(height: 28.h),
              PrimaryButton(
                title: s.actionDone,
                onTap: codeAsync.isLoading
                    ? null
                    : () async {
                        final code = codeAsync.valueOrNull;
                        if (code != null && code.isNotEmpty) {
                          await Clipboard.setData(ClipboardData(text: code));
                          if (!context.mounted) return;
                          context.showSuccessSnackBar(s.homeParCodeCopied);
                        }
                        if (!context.mounted) return;
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

class _CodeBox extends ConsumerWidget {
  const _CodeBox({
    required this.isDark,
    required this.codeAsync,
    required this.familyId,
    required this.formatCode,
  });

  final bool isDark;
  final AsyncValue<String> codeAsync;
  final String familyId;
  final String Function(String) formatCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkBorder : AppTheme.surfaceGrey,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
      ),
      child: codeAsync.when(
        loading: () => Skeleton(
          height: 48.h,
          width: double.infinity,
          borderRadius: 12.r,
        ),
        error: (_, __) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              s.homeParInviteCodeLoadError,
              textAlign: TextAlign.center,
              style: context.typo.body.medium.copyWith(
                color: AppTheme.redAlert,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: () =>
                  ref.invalidate(familyInviteCodeProvider(familyId)),
              child: Text(s.actionRetry),
            ),
          ],
        ),
        data: (code) => GestureDetector(
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: code));
            if (!context.mounted) return;
            context.showSuccessSnackBar(s.homeParCodeCopied);
            context.pop();
          },
          child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            formatCode(code),
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
      ),
    );
  }
}
