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
import 'package:monikid/shared/widgets/glass_app_bar.dart';

enum JoinFamilyPhase { phase1, phase2 }

class JoinFamilyScreen extends HookConsumerWidget {
  const JoinFamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;

    final familyId = ref.watch(
      authSessionProvider.select((a) => a.account?.familyId),
    );
    final isParent = ref.watch(
      authSessionProvider.select((a) => a.account?.isParent ?? false),
    );
    final uid = ref.watch(
      authSessionProvider.select((a) => a.account?.uid),
    );
    final hasFamily = familyId != null;

    // Host status only matters for a parent that already has a family. The
    // members stream is the only carrier of family_role. While it resolves,
    // fall back to "host" so a real host never briefly sees the phase2
    // "Leave family" button.
    final membersAsync =
        (isParent && hasFamily) ? ref.watch(familyMembersProvider) : null;
    final isHost = membersAsync?.maybeWhen(
          data: (members) => members.any((m) => m.uid == uid && m.isHost),
          orElse: () => true,
        ) ??
        false;

    // Host already owns a family -> a join would be rejected by the
    // isValidMemberJoin rule; show the join form but disabled. Every other
    // case keeps the original phase rule unchanged.
    final JoinFamilyPhase phase;
    final bool joinDisabled;
    if (isHost) {
      phase = JoinFamilyPhase.phase1;
      joinDisabled = true;
    } else {
      phase = hasFamily ? JoinFamilyPhase.phase2 : JoinFamilyPhase.phase1;
      joinDisabled = false;
    }

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
      appBar: GlassAppBar(
        title: appBarTitle,
        onBackTap: () {
          notifier.reset();
          context.pop();
        },
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
                    disabled: joinDisabled,
                  ),
                ),
            },
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
