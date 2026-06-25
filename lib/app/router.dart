import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/utils/app_transitions.dart';
import 'package:monikid/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:monikid/features/auth/login/login_screen.dart';
import 'package:monikid/features/auth/onboard/onboarding_screen.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_screen.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_screen.dart';
import 'package:monikid/features/auth/pin/re_enter_pin/re_enter_pin_screen.dart';
import 'package:monikid/features/auth/auth_session/auth_session_provider.dart';
import 'package:monikid/features/auth/register/register_screen.dart';
import 'package:monikid/features/change_profile/profile_edit_screen.dart';
import 'package:monikid/features/faq/faq_screen.dart';
import 'package:monikid/features/parent/bottom_nav_bar_par.dart';
import 'package:monikid/features/parent/family_management/family_management_screen.dart';
import 'package:monikid/features/child/statistic/category_transactions/category_transaction_list_screen.dart';
import 'package:monikid/features/child/statistic/category_transactions/category_transactions_args.dart';
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
import 'package:monikid/features/dev_tools/dev_tools_screen.dart';
import 'package:monikid/features/notification_settings/notification_settings_screen.dart';
import 'package:monikid/features/notification_settings/schedule_notification_screen.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';

class AppRoutes {
  AppRoutes._();

  // --- Splash ---
  static const String splash = '/';

  // --- Onboarding Flow ---
  static const String onboard1 = '/onboard-1';

  // --- Auth Flow ---
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // --- Pin Flow ---
  // PIN creation: entered after successful login/register (new session)
  static const String createNewPin = '/create-new-pin';
  static const String reEnterPin = '/re-enter-pin';
  // PIN entry: entered on app restart for returning authenticated users
  static const String enterPinCode = '/enter-pin-code';

  // --- App Routes ---
  static const String parent = '/parent';
  static const String studentMain = '/student-main';
  static const String joinFamily = '/join-family';
  static const String manageFamily = '/manage-family';
  static const String notificationSettings = '/notification-settings';
  static const String scheduleNotification = '/schedule-notification';
  static const String profileEdit = '/profile-edit';
  static const String faq = '/faq';
  static const String devTools = '/dev-tools';
  static const String chooseAiModel = '/choose-ai-model';
  static const String addTransaction = '/add-transaction';
  static const String transactionHistory = '/transaction-history';
  static const String updateTransaction = '/update-transaction/:transactionId';
  static const String detailTransaction = '/detail-transaction/:transactionId';
  static const String childCategoryTransactions = '/child/category-transactions';
  static const String parentCategoryTransactions = '/parent/category-transactions';
  static const String parentTransactionHistory = '/parent/transaction-history';
  static const String parentTransactionDetail =
      '/parent/children/:childUid/transactions/:transactionId';

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

// Flow membership sets used in redirect logic.
const _onboardingFlowPaths = {AppRoutes.onboard1};

const _authFlowPaths = {
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.forgotPassword,
};

// PIN creation flow: create-new-pin → re-enter-pin (after every new login).
const _pinCreationPaths = {
  AppRoutes.createNewPin,
  AppRoutes.reEnterPin,
};

// PIN entry flow: enter-pin-code (returning authenticated user).
const _pinEntryPaths = {AppRoutes.enterPinCode};

const _pinFlowPaths = {..._pinCreationPaths, ..._pinEntryPaths};

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(ref),
    routes: [
      // ── Splash ────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) => fadePage(state, const SplashScreen()),
      ),

      // ── Onboarding Flow ───────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.onboard1,
        pageBuilder: (context, state) =>
            fadePage(state, const OnboardingScreen()),
      ),

      // ── Auth Flow ─────────────────────────────────────────────────────────
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

      // ── Pin Flow ──────────────────────────────────────────────────────────
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

      // ── App Routes ────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.parent,
        builder: (context, state) => const ParentBottomNavBar(),
      ),
      GoRoute(
        path: AppRoutes.studentMain,
        builder: (context, state) => const StudentBottomNavBar(),
      ),
      GoRoute(
        path: AppRoutes.joinFamily,
        pageBuilder: (context, state) =>
            slidePage(state, const JoinFamilyScreen()),
      ),
      GoRoute(
        path: AppRoutes.manageFamily,
        builder: (context, state) => const FamilyManagementScreen(),
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
        path: AppRoutes.profileEdit,
        pageBuilder: (context, state) =>
            slidePage(state, const ProfileEditScreen()),
      ),
      GoRoute(
        path: AppRoutes.faq,
        pageBuilder: (context, state) => slidePage(state, const FAQScreen()),
      ),
      GoRoute(
        path: AppRoutes.devTools,
        pageBuilder: (context, state) =>
            slidePage(state, const DevToolsScreen()),
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
      GoRoute(
        path: AppRoutes.childCategoryTransactions,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is CategoryTransactionsArgs) {
            return CategoryTransactionListScreen(args: extra);
          }
          return const StudentBottomNavBar();
        },
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
        builder: (context, state) {
          final childUid = state.extra is String ? state.extra! as String : '';
          return TransactionHistoryParScreen(childUid: childUid);
        },
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
    ],
    redirect: (context, state) {
      final authState = ref.read(authSessionProvider);
      final path = state.uri.path;
      final isAuthenticated = authState.isAuthenticated;
      final homeRoute = _resolveHomeRoute(authState.account?.role);

      // 1. Wait for Firebase auth to resolve — splash handles routing during this window.
      if (authState.isInitial || authState.isLoading) return null;

      // 2. Splash manages its own navigation entirely.
      if (path == AppRoutes.splash) return null;

      // 3. Incomplete account — force back to auth flow.
      if (authState.isAccountIncomplete) {
        return _authFlowPaths.contains(path) ? null : AppRoutes.login;
      }

      // 4. Onboarding flow — only accessible before authentication.
      if (_onboardingFlowPaths.contains(path)) {
        return isAuthenticated ? homeRoute : null;
      }

      // 5. Unauthenticated — only the auth flow is open.
      if (!isAuthenticated) {
        return _authFlowPaths.contains(path) ? null : AppRoutes.login;
      }

      // ── Authenticated from here ──────────────────────────────────────────

      // 6. Pin flow — block exit until PIN is verified.
      if (_pinFlowPaths.contains(path)) {
        return authState.isPinVerified ? homeRoute : null;
      }

      // 7. Auth routes while authenticated — route to next required step.
      //    Use hasPinCode to distinguish a returning user (who ended up here due
      //    to an auth race condition) from a fresh login (no PIN stored yet).
      if (_authFlowPaths.contains(path)) {
        if (authState.isPinVerified) return homeRoute;
        return authState.hasPinCode
            ? AppRoutes.enterPinCode
            : AppRoutes.createNewPin;
      }

      return null;
    },
  );
});

String _resolveHomeRoute(String? accountRole) {
  if (accountRole == 'parent') return AppRoutes.parent;
  if (accountRole == 'child') return AppRoutes.studentMain;
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
