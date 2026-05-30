import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/config/dev_config.dart';
import 'package:monikid/core/utils/app_transitions.dart';
import 'package:monikid/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:monikid/features/auth/login/login_screen.dart';
import 'package:monikid/features/auth/onboard/onboarding_screen.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_screen.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_screen.dart';
import 'package:monikid/features/auth/pin/pin_gateway/pin_gateway_screen.dart';
import 'package:monikid/features/auth/pin/re_enter_pin/re_enter_pin_screen.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/auth/register/register_screen.dart';
import 'package:monikid/features/change_profile/profile_edit_screen.dart';
import 'package:monikid/features/fqa/fqa_screen.dart';
import 'package:monikid/features/parent/bottom_nav_bar_par.dart';
import 'package:monikid/features/parent/family_management/family_management_screen.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_screen.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/parent_transaction_detail_screen.dart';
import 'package:monikid/features/parent/transaction_par/transaction_history_par_screen.dart';
import 'package:monikid/features/splash/splash_screen.dart';
import 'package:monikid/features/child/bottom_nav_bar.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_screen.dart';
import 'package:monikid/features/child/transaction/add_transaction/add_transaction_screen.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_screen.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_screen.dart';
import 'package:monikid/features/child/join_family/join_family_screen.dart';
import 'package:monikid/features/child/transaction/update_transaction/update_transaction_screen.dart';
import 'package:monikid/features/notification_settings/notification_settings_screen.dart';
import 'package:monikid/features/notification_settings/schedule_notification_screen.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboard1 = '/onboard-1';
  static const String createFamily = '/create-family';
  static const String joinFamily = '/join-family';
  static const String forgotPassword = '/forgot-password';
  static const String updatePassword = '/update-password';
  static const String fqa = '/fqa';
  static const String profileEdit = '/profile-edit';

  static const String pinGateway = '/pin-gateway';
  static const String createNewPin = '/create-new-pin';
  static const String reEnterPin = '/re-enter-pin';
  static const String enterPinCode = '/enter-pin-code';

  static const String notificationSettings = '/notification-settings';
  static const String scheduleNotification = '/schedule-notification';
  static const String parent = '/parent';
  static const String manageFamily = '/manage-family';
  static const String parentCategoryTransactions = '/parent/category-transactions';
  static const String parentTransactionHistory = '/parent/transaction-history';
  static const String parentTransactionDetail =
      '/parent/children/:childUid/transactions/:transactionId';
  static const String studentMain = '/student-main';
  static const String chooseAiModel = '/choose-ai-model';

  static const String addTransaction = '/add-transaction';
  static const String transactionHistory = '/transaction-history';
  static const String updateTransaction = '/update-transaction/:transactionId';
  static const String detailTransaction = '/detail-transaction/:transactionId';


  static String updateTransactionPath(String transactionId) {
    return '/update-transaction/$transactionId';
  }

  static String detailTransactionPath(String transactionId) {
    return '/detail-transaction/$transactionId';
  }

  static String parentTransactionDetailPath(
    String childUid,
    String transactionId,
  ) {
    return '/parent/children/$childUid/transactions/$transactionId';
  }
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

const authRoutes = [
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.forgotPassword,
  AppRoutes.updatePassword,
];

const pinRoutes = [
  AppRoutes.pinGateway,
  AppRoutes.createNewPin,
  AppRoutes.reEnterPin,
  AppRoutes.enterPinCode,
];

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: kDevAuthMode ? AppRoutes.login : AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(ref),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) => fadePage(state, const SplashScreen()),
      ),
      GoRoute(
        path: AppRoutes.fqa,
        pageBuilder: (context, state) => slidePage(state, const FQAScreen()),
      ),
      GoRoute(
        path: AppRoutes.profileEdit,
        pageBuilder: (context, state) =>
            slidePage(state, const ProfileEditScreen()),
      ),
      GoRoute(
        path: AppRoutes.joinFamily,
        pageBuilder: (context, state) =>
            slidePage(state, const JoinFamilyScreen()),
      ),
      GoRoute(
        path: AppRoutes.onboard1,
        pageBuilder: (context, state) =>
            fadePage(state, const OnboardingScreen()),
      ),
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => fadePage(state, const LoginScreen()),
      ),
      GoRoute(
        path: AppRoutes.register,
        pageBuilder: (context, state) =>
            slidePage(state, const RegisterScreen()),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        pageBuilder: (context, state) =>
            slidePage(state, const ForgotPasswordScreen()),
      ),
      GoRoute(
        path: AppRoutes.pinGateway,
        pageBuilder: (context, state) =>
            fadePage(state, const PinGatewayScreen()),
      ),
      GoRoute(
        path: AppRoutes.createNewPin,
        pageBuilder: (context, state) =>
            slidePage(state, const CreateNewPinScreen()),
      ),
      GoRoute(
        path: AppRoutes.reEnterPin,
        pageBuilder: (context, state) =>
            slidePage(state, const ReEnterPinScreen()),
      ),
      GoRoute(
        path: AppRoutes.enterPinCode,
        pageBuilder: (context, state) =>
            fadePage(state, const EnterPinCodeScreen()),
      ),
      GoRoute(
        path: AppRoutes.notificationSettings,
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.scheduleNotification,
        builder: (context, state) => const ScheduleNotificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.parent,
        builder: (context, state) => const ParentBottomNavBar(),
      ),
      GoRoute(
        path: AppRoutes.manageFamily,
        builder: (context, state) => const FamilyManagementScreen(),
      ),
      GoRoute(
        path: AppRoutes.parentCategoryTransactions,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is ParentCategoryTransactionsArgs) {
            return ParentCategoryTransactionsScreen(args: extra);
          }
          return const ParentBottomNavBar();
        },
      ),
      GoRoute(
        path: AppRoutes.parentTransactionHistory,
        builder: (context, state) => const TransactionHistoryParScreen(),
      ),
      GoRoute(
        path: AppRoutes.parentTransactionDetail,
        builder: (context, state) {
          final childUid = state.pathParameters['childUid'] ?? '';
          final transactionId = state.pathParameters['transactionId'] ?? '';
          return ParentTransactionDetailScreen(
            childUid: childUid,
            transactionId: transactionId,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.studentMain,
        builder: (context, state) => const StudentBottomNavBar(),
      ),
      GoRoute(
        path: AppRoutes.chooseAiModel,
        builder: (context, state) => const ChooseAiModelScreen(),
      ),
      GoRoute(
        path: AppRoutes.addTransaction,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is (TransactionAiResult?, TransactionImageSelection?)) {
            return AddTransactionScreen(
              aiPrefill: extra.$1,
              scannedImage: extra.$2,
            );
          }
          return const AddTransactionScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.transactionHistory,
        builder: (context, state) => const TransactionHistoryScreen(),
      ),
      GoRoute(
        path: AppRoutes.updateTransaction,
        builder: (context, state) {
          final transactionId = state.pathParameters['transactionId'] ?? '';
          return UpdateTransactionScreen(transactionId: transactionId);
        },
      ),
      GoRoute(
        path: AppRoutes.detailTransaction,
        builder: (context, state) {
          final transactionId = state.pathParameters['transactionId'] ?? '';
          return DetailTransactionScreen(transactionId: transactionId);
        },
      ),
    ],
    redirect: (context, state) {
      // ─── DEV MODE: only login / register / forgot-password are accessible ───
      // See lib/features/auth/DEV_MODE.md for what to restore when done.
      if (kDevAuthMode) {
        final path = state.uri.path;
        const devAllowed = {
          AppRoutes.login,
          AppRoutes.register,
          AppRoutes.forgotPassword,
        };
        if (devAllowed.contains(path)) return null;
        return AppRoutes.login;
      }
      // ────────────────────────────────────────────────────────────────────────

      // ── PRODUCTION REDIRECT LOGIC (restore when kDevAuthMode = false) ──────
      final authState = ref.read(authSessionProvider);
      final currentPath = state.uri.path;
      final isAuthenticated = authState.isAuthenticated;
      final isInitial = authState.isInitial;
      final accountRole = authState.account?.role;
      final requiresPinVerification = authState.requiresPinVerification;
      final isAuthRoute = authRoutes.contains(currentPath);
      final isPinRoute = pinRoutes.contains(currentPath);
      final homeRoute = _resolveHomeRoute(accountRole);

      if (isInitial) {
        return null;
      }

      if (authState.isLoading) {
        return null;
      }

      if (authState.isAccountIncomplete) {
        return AppRoutes.login;
      }

      if (currentPath == AppRoutes.splash) {
        return null;
      }

      if (currentPath == AppRoutes.onboard1) {
        if (isAuthenticated) {
          return requiresPinVerification ? AppRoutes.pinGateway : homeRoute;
        }
        return null;
      }

      if (!isAuthenticated) {
        if (isAuthRoute) {
          return null;
        }

        return AppRoutes.login;
      }

      if (requiresPinVerification) {
        if (isPinRoute) {
          return null;
        }

        return AppRoutes.pinGateway;
      }

      if (isAuthRoute || isPinRoute) {
        return homeRoute;
      }

      return null;
      // ────────────────────────────────────────────────────────────────────────
    },
  );
});

String _resolveHomeRoute(String? accountRole) {
  if (accountRole == 'parent') {
    return AppRoutes.parent;
  }

  if (accountRole == 'child') {
    return AppRoutes.studentMain;
  }

  return AppRoutes.login;
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(this._ref) {
    _ref.listen(authSessionProvider, (previous, next) {
      notifyListeners();
    });
  }

  final Ref _ref;
}
