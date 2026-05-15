import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:monikid/features/auth/login/login_screen.dart';
import 'package:monikid/features/auth/onboard/onboarding_screen.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_screen.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_screen.dart';
import 'package:monikid/features/auth/pin/pin_gateway/pin_gateway_screen.dart';
import 'package:monikid/features/auth/pin/re_enter_pin/re_enter_pin_screen.dart';
import 'package:monikid/features/auth/providers/auth_session_provider.dart';
import 'package:monikid/features/auth/register/register_screen.dart';
import 'package:monikid/features/change_profile/profile_edit_screen.dart';
import 'package:monikid/features/fqa/fqa_screen.dart';
import 'package:monikid/features/parent/bottom_nav_bar_par.dart';
import 'package:monikid/features/parent/family_management/family_management_screen.dart';
import 'package:monikid/features/child/notification/notification_screen.dart';
import 'package:monikid/features/parent/notification/parent_notification_screen.dart';
import 'package:monikid/features/parent/statistic/category_transactions/parent_category_transactions_screen.dart';
import 'package:monikid/features/parent/statistic/transaction_detail/parent_transaction_detail_screen.dart';
import 'package:monikid/features/parent/transaction_par/transaction_history_par_screen.dart';
import 'package:monikid/features/splash/splash_screen.dart';
import 'package:monikid/features/child/bottom_nav_bar.dart';
import 'package:monikid/features/child/request_money/add_new_request/add_request_money_screen.dart';
import 'package:monikid/features/child/request_money/request_money_history/request_money_history_screen.dart';
import 'package:monikid/features/child/choose_ai_model/choose_ai_model_screen.dart';
import 'package:monikid/features/child/request_money/update_request/update_request_screen.dart';
import 'package:monikid/features/child/transaction/add_transaction/add_transaction_screen.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_screen.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_screen.dart';
import 'package:monikid/features/child/join_family/join_family_screen.dart';
import 'package:monikid/features/child/transaction/update_transaction/update_transaction_screen.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/models/entities/request_money/request_money_model.dart';

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

  static const String childNotifications = '/child/notifications';
  static const String parentNotifications = '/parent/notifications';
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

  static const String requestMoneyHistory = '/request-money-history';
  static const String addRequestMoney = '/add-request-money';
  static const String updateRequest = '/update-request';

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
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(ref),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.childNotifications,
        builder: (context, state) => const ChildNotificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.parentNotifications,
        builder: (context, state) => const ParentNotificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.fqa,
        builder: (context, state) => const FQAScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileEdit,
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: AppRoutes.joinFamily,
        builder: (context, state) => const JoinFamilyScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboard1,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.pinGateway,
        builder: (context, state) => const PinGatewayScreen(),
      ),
      GoRoute(
        path: AppRoutes.createNewPin,
        builder: (context, state) => const CreateNewPinScreen(),
      ),
      GoRoute(
        path: AppRoutes.reEnterPin,
        builder: (context, state) => const ReEnterPinScreen(),
      ),
      GoRoute(
        path: AppRoutes.enterPinCode,
        builder: (context, state) => const EnterPinCodeScreen(),
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
      GoRoute(
        path: AppRoutes.addRequestMoney,
        builder: (context, state) => const AddRequestMoneyScreen(),
      ),
      GoRoute(
        path: AppRoutes.requestMoneyHistory,
        builder: (context, state) {
          final request = state.extra as RequestMoneyModel;
          return RequestMoneyHistoryScreen(request: request);
        },
      ),
      GoRoute(
        path: AppRoutes.updateRequest,
        builder: (context, state) {
          final request = state.extra as RequestMoneyModel;
          return UpdateRequestScreen(request: request);
        },
      ),
    ],
    redirect: (context, state) {
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
        if (!isAuthenticated) {
          return null;
        }

        return requiresPinVerification ? AppRoutes.pinGateway : homeRoute;
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
