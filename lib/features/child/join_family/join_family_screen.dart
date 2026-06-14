import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/join_family/join_family_provider.dart';
import 'package:monikid/features/child/join_family/widgets/family_members_form_body.dart';
import 'package:monikid/features/child/join_family/widgets/join_family_form_body.dart';
import 'package:monikid/shared/widgets/app_background.dart';

enum JoinFamilyPhase { phase1, phase2 }

class JoinFamilyScreen extends HookConsumerWidget {
  const JoinFamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;

    final hasFamily = ref.watch(
      authSessionProvider.select((a) => a.account?.familyId != null),
    );

    final phase = hasFamily ? JoinFamilyPhase.phase2 : JoinFamilyPhase.phase1;

    useEffect(() {
      if (phase == JoinFamilyPhase.phase2) {
        ref.invalidate(linkedFamilyProvider);
        ref.invalidate(familyMembersProvider);
      }
      return null;
    }, [phase]);

    final notifier = ref.read(joinFamilyNotifierProvider.notifier);
    final state = ref.watch(joinFamilyNotifierProvider);

    ref.listen(joinFamilyNotifierProvider, (_, next) {
      if (!context.mounted) return;
      if (next.isSuccess) {
        final newFamilyId = ref.read(authSessionProvider).account?.familyId;
        if (newFamilyId == null) {
          context.showSuccessSnackBar(s.unlinkFamilySuccess);
          context.pop();
        } else {
          context.showSuccessSnackBar(s.joinFamilySuccess);
        }
      } else if (next.isError) {
        final msg = next.errorMessage == 'leave_failed'
            ? s.unlinkFamilyErrorFailed
            : _joinErrorText(next.errorMessage, s);
        context.showErrorSnackBar(msg);
      }
    });

    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.homeParBg1;
    final appBarTitle = phase == JoinFamilyPhase.phase2
        ? s.familyMembersTitle
        : s.joinFamilyTitle;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          appBarTitle,
          style: context.typo.title.small.copyWith(
            color: isDark ? Colors.white : AppTheme.textBlack,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
        leading: _CircleIconButton(
          isDark: isDark,
          icon: Icons.arrow_back_ios_new_rounded,
          onPressed: () {
            notifier.reset();
            context.pop();
          },
        ),
        actions: const [],
      ),
      body: AppBackground(
        child: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: switch (phase) {
              JoinFamilyPhase.phase2 => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: FamilyMembersFormBody(
                    isDark: isDark,
                    state: state,
                    notifier: notifier,
                  ),
                ),
              JoinFamilyPhase.phase1 => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: JoinFamilyFormBody(
                    isDark: isDark,
                    state: state,
                    notifier: notifier,
                  ),
                ),
            },
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.isDark,
    required this.icon,
    required this.onPressed,
  });

  final bool isDark;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 42.r,
          height: 42.r,
          decoration: BoxDecoration(
            color: isDark
                ? AppTheme.surfaceDark
                : Colors.white.withValues(alpha: 0.72),
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark
                  ? AppTheme.borderDark
                  : Colors.white.withValues(alpha: 0.86),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 8.h),
                blurRadius: 18.r,
                color: const Color(0xFF4D5F7C).withValues(alpha: 0.06),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 18.r,
            color: isDark ? Colors.white : AppTheme.textBlack,
          ),
        ),
      ),
    );
  }
}

String _joinErrorText(String? key, dynamic s) {
  return switch (key) {
    'already_member' => s.joinFamilyErrorAlreadyMember,
    'unknown' => s.joinFamilyErrorUnknown,
    _ => s.joinFamilyErrorInvalidCode,
  };
}
