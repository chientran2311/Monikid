import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/child/join_family/join_family_provider.dart';
import 'package:monikid/features/child/join_family/widgets/join_family_form_body.dart';
import 'package:monikid/features/child/join_family/widgets/leave_family_form_body.dart';

class JoinFamilyScreen extends HookConsumerWidget {
  const JoinFamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    final focusNode = useFocusNode();

    final hasFamily = ref.watch(
      authSessionProvider.select((a) => a.account?.familyId != null),
    );

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

    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.r),
          onPressed: () {
            notifier.reset();
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => focusNode.unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: hasFamily
                ? LeaveFamilyFormBody(
                    isDark: isDark,
                    state: state,
                    notifier: notifier,
                  )
                : JoinFamilyFormBody(
                    isDark: isDark,
                    state: state,
                    notifier: notifier,
                  ),
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
