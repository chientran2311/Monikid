import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/child/home/home_tab_provider.dart';
import 'package:monikid/features/child/home/widgets/home_tab_student_body.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_dialog.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_provider.dart';
import 'package:monikid/repositories/profile/profile_repository.dart';
import 'package:monikid/shared/widgets/app_background.dart';

class HomeTabStudent extends HookConsumerWidget {
  const HomeTabStudent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authState = ref.watch(authSessionProvider);
    final limitState = ref.watch(setMoneyLimitNotifierProvider);

    final userName = authState.account?.displayName ?? s.homeStudentDefaultName;
    final uid = authState.account?.uid ?? authState.user?.uid;
    final fallbackAvatarUrl =
        authState.account?.avatarUrl ?? authState.user?.photoURL;
    final profileImageUrl = uid == null
        ? null
        : ref.watch(profileImageProvider(uid)).maybeWhen(
              data: (avatarUrl) => avatarUrl,
              orElse: () => null,
            );
    final avatarUrl = profileImageUrl ?? fallbackAvatarUrl;
    final hasPromptedForMissingLimit = useRef(false);

    useEffect(() {
      if (uid == null) return null;
      Future.microtask(() async {
        final logger = getIt<Logger>();
        try {
          logger.d('HomeTabStudent: onInit start. uid=$uid');
          await ref.read(setMoneyLimitNotifierProvider.notifier).onInit();
          await ref.read(homeTabNotifierProvider.notifier).onInit();
        } catch (error, stackTrace) {
          logger.e(
            'HomeTabStudent: onInit failed.',
            error: error,
            stackTrace: stackTrace,
          );
        }
      });
      return null;
    }, [uid]);

    useEffect(() {
      if (!limitState.isReady ||
          limitState.hasStoredLimit ||
          hasPromptedForMissingLimit.value) {
        return null;
      }

      if (authState.account?.familyId != null) return null;

      hasPromptedForMissingLimit.value = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        showSetMoneyLimitDialog(context, ref);
      });
      return null;
    }, [limitState.status, limitState.hasStoredLimit]);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.surfaceLight,
      body: AppBackground(
        whiteBackground: true,
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              if (uid != null) ref.invalidate(profileImageProvider(uid));
              await ref
                  .read(setMoneyLimitNotifierProvider.notifier)
                  .loadCurrentLimit();
              await ref.read(homeTabNotifierProvider.notifier).refresh();
            },
            child: HomeTabStudentBody(
              uid: uid,
              userName: userName,
              avatarUrl: avatarUrl,
              isDark: isDark,
            ),
          ),
        ),
      ),
    );
  }
}
