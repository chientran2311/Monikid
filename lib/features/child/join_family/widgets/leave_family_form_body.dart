import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/join_family/join_family_provider.dart';
import 'package:monikid/features/child/join_family/join_family_state.dart';
import 'package:monikid/shared/widgets/common_buttons.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';

class LeaveFamilyFormBody extends ConsumerWidget {
  const LeaveFamilyFormBody({
    required this.isDark,
    required this.state,
    required this.notifier,
    super.key,
  });

  final bool isDark;
  final JoinFamilyState state;
  final JoinFamilyNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? const Color(0xFF94A3B8) : AppTheme.textGrey;
    final surfaceColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    final familyName =
        ref.watch(linkedFamilyProvider).valueOrNull?.parentName ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32.h),
        Container(
          width: 64.r,
          height: 64.r,
          decoration: const BoxDecoration(
            color: AppTheme.primaryLight,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.family_restroom_rounded,
            size: 32.r,
            color: AppTheme.primary,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          s.unlinkFamilyTitle,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          s.unlinkFamilySubtitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp, color: mutedColor, height: 1.5),
        ),
        if (familyName.isNotEmpty) ...[
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: 20.r,
                  color: mutedColor,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    familyName,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        SizedBox(height: 40.h),
        AppDangerButton(
          label: s.unlinkFamilyButton,
          isLoading: state.isBusy,
          onPressed: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (_) => ConfirmDialog(
                title: s.unlinkFamilyConfirmTitle,
                message: s.unlinkFamilyConfirmBody,
                confirmLabel: s.unlinkFamilyButton,
                cancelLabel: s.customCategoryCancel,
                confirmColor: AppTheme.redAlert,
              ),
            );
            if (confirmed != true || !context.mounted) return;
            notifier.leaveFamily();
          },
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
