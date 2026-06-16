import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/child/join_family/join_family_provider.dart';
import 'package:monikid/features/child/join_family/join_family_state.dart';
import 'package:monikid/models/entities/link_family/family_model.dart';
import 'package:monikid/shared/widgets/confirm_dialog.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

class FamilyMembersFormBody extends ConsumerWidget {
  const FamilyMembersFormBody({
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

    final family = ref.watch(linkedFamilyProvider).valueOrNull;

    final textColor = isDark ? Colors.white : AppTheme.textBlack;
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 8.h),
        _HeroCard(
          isDark: isDark,
          family: family,
          ownerDisplayName: family?.hostDisplayName ?? '',
          ownerAvatarUrl: family?.hostAvatarUrl,
          textColor: textColor,
          mutedColor: mutedColor,
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
          child: PrimaryButton.danger(
            title: s.unlinkFamilyButtonFull,
            isLoading: state.isBusy,
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (_) => ConfirmDialog(
                  title: s.unlinkFamilyConfirmTitle,
                  subtitle: s.unlinkFamilyConfirmBody,
                  confirmLabel: s.unlinkFamilyButton,
                  cancelLabel: s.customCategoryCancel,
                  isDestructive: true,
                  onConfirm: notifier.leaveFamily,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.isDark,
    required this.family,
    required this.ownerDisplayName,
    required this.ownerAvatarUrl,
    required this.textColor,
    required this.mutedColor,
  });

  final bool isDark;
  final FamilyModel? family;
  final String ownerDisplayName;
  final String? ownerAvatarUrl;
  final Color textColor;
  final Color mutedColor;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final hasAvatar = ownerAvatarUrl != null && ownerAvatarUrl!.isNotEmpty;
    final initial =
        ownerDisplayName.isNotEmpty ? ownerDisplayName[0].toUpperCase() : '?';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.primaryLight,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4.h),
            blurRadius: 16.r,
            color: AppTheme.primary.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.r,
                height: 8.r,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                s.familyStatusJoined,
                style: context.typo.label.small.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                width: 52.r,
                height: 52.r,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(14.r),
                  image: hasAvatar
                      ? DecorationImage(
                          image: NetworkImage(ownerAvatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                alignment: Alignment.center,
                child: hasAvatar
                    ? null
                    : Text(
                        initial,
                        style: context.typo.title.medium.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  ownerDisplayName,
                  style: context.typo.title.big.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 16.r,
                color: AppTheme.primary,
              ),
              SizedBox(width: 6.w),
              Text(
                s.familyLinkedSuccess,
                style: context.typo.label.small.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
