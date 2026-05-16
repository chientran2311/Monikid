import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/service/notification_service.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/child/home/home_tab_provider.dart';
import 'package:monikid/features/child/home/widgets/home_tab_student_body.dart';
import 'package:monikid/features/child/notification/notification_provider.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_dialog.dart';
import 'package:monikid/features/child/set_money_limit/set_money_limit_provider.dart';
import 'package:monikid/repositories/profile/profile_repository.dart';
import 'package:monikid/shared/widgets/notification_badge.dart';

class HomeTabStudent extends HookConsumerWidget {
  const HomeTabStudent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);
    final s = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authState = ref.watch(authSessionProvider);
    final limitState = ref.watch(setMoneyLimitNotifierProvider);

    final userName = authState.account?.displayName ?? s.homeStudentDefaultName;
    final uid = authState.account?.uid ?? authState.user?.uid;
    final fallbackAvatarUrl =
        authState.account?.photoUrl ?? authState.user?.photoURL;
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
        await ref.read(setMoneyLimitNotifierProvider.notifier).onInit();
        await ref.read(homeTabNotifierProvider.notifier).onInit();

        final authState = ref.read(authSessionProvider);
        final familyId = authState.account?.familyId;
        String? parentUid;
        if (familyId != null) {
          try {
            final familyDoc = await getIt<FirebaseFirestore>()
                .collection('families')
                .doc(familyId)
                .get();
            parentUid = familyDoc.data()?['parent_id'] as String?;
          } catch (_) {
            // Non-fatal — proceed without parentUid
          }
        }

        final limitState = ref.read(setMoneyLimitNotifierProvider);
        final homeState = ref.read(homeTabNotifierProvider);
        // monthlyExpense and storedLimitMinor are both in full VND
        final currentExpenseMinor = homeState.monthlyExpense.toInt();

        await getIt<NotificationService>().checkAndNotify(
          uid: uid,
          role: authState.account?.role ?? 'child',
          monthlyLimitMinor: limitState.storedLimitMinor ?? 0,
          currentExpenseMinor: currentExpenseMinor,
          familyId: familyId,
          parentUid: parentUid,
          childDisplayName: authState.account?.displayName ?? '',
        );
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
      backgroundColor: isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          NotificationBadge(
            count: ref.watch(unreadNotificationCountProvider),
            child: IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
                size: 24.r,
              ),
              onPressed: () => context.push(AppRoutes.childNotifications),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
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
    );
  }
}
