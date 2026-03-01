import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth provider
import 'package:monikid/features/auth/providers/auth_provider.dart';

// Import screens
import 'package:monikid/features/splash/splash_screen.dart';
import 'package:monikid/features/auth/login/login_screen.dart';
import 'package:monikid/features/auth/register/register.dart';
import 'package:monikid/features/auth/onboard/onboarding_screen.dart';
import 'package:monikid/features/auth/forgot_password/forgot_password_screen.dart';

import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_screen.dart';
import 'package:monikid/features/auth/pin/re_enter_pin/re_enter_pin_screen.dart';
import 'package:monikid/features/auth/pin/enter_pin_code/enter_pin_code_screen.dart';
import 'package:monikid/features/auth/pin/enum/enter_pin_code_enum.dart';

// Main screens (Bottom Nav)
import 'package:monikid/features/parent/bottom_nav_bar_par.dart';
import 'package:monikid/features/student/bottom_nav_bar.dart';

// Student transaction screens
import 'package:monikid/features/student/transaction/add_transaction/add_transaction_screen.dart';
import 'package:monikid/features/student/transaction/update_transaction/update_transaction_screen.dart';
import 'package:monikid/features/student/transaction/detail_transaction/detail_transaction_screen.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class AppRoutes {
  AppRoutes._();

  // Auth routes
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboard1 = '/onboard-1';
  static const String createFamily = '/create-family';
  static const String joinFamily = '/join-family';
  static const String forgotPassword = '/forgot-password';
  static const String updatePassword = '/update-password';

  // PIN routes
  static const String createNewPin = '/create-new-pin';
  static const String reEnterPin = '/re-enter-pin';
  static const String enterPinCode = '/enter-pin-code';

  // Parent routes
  static const String parent = '/parent';
  static const String parentHome = '/home';

  // Student routes
  static const String studentMain = '/student-main';

  // Transaction routes
  static const String addTransaction = '/add-transaction';
  static const String updateTransaction = '/update-transaction';
  static const String detailTransaction = '/detail-transaction';
}

/// Global Key để quản lý Navigator
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

const authRoutes = [
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.forgotPassword,
  AppRoutes.updatePassword,
];

/// 🟢 ROUTER PROVIDER
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(ref),

    routes: [
      // --- AUTH GROUP ---
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
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

      // --- PIN GROUP ---
      GoRoute(
        path: AppRoutes.createNewPin,
        builder: (context, state) {
          return const CreateNewPinScreen(type: EnterPINCodeEnum.createdNew);
        },
      ),
      GoRoute(
        path: AppRoutes.reEnterPin,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final pinCodeHash = extra['pinCodeHash'] as String;
          return ReEnterPinScreen(pinCodeHash: pinCodeHash);
        },
      ),
      GoRoute(
        path: AppRoutes.enterPinCode,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final expectedPinHash = extra['expectedPinHash'] as String;
          return EnterPinCodeScreen(expectedPinHash: expectedPinHash);
        },
      ),

      // --- PARENT GROUP ---
      GoRoute(
        path: AppRoutes.parentHome,
        builder: (context, state) => const ParentBottomNavBar(),
      ),
      GoRoute(
        path: AppRoutes.parent,
        builder: (context, state) => const ParentBottomNavBar(),
      ),

      // --- STUDENT GROUP ---
      GoRoute(
        path: AppRoutes.studentMain,
        builder: (context, state) => const StudentBottomNavBar(),
      ),

      // --- TRANSACTION GROUP ---
      GoRoute(
        path: AppRoutes.addTransaction,
        builder: (context, state) => const AddTransactionScreen(),
      ),
      GoRoute(
        path: AppRoutes.updateTransaction,
        builder: (context, state) {
          final transaction = state.extra as TransactionModel;
          return UpdateTransactionScreen(transaction: transaction);
        },
      ),
      GoRoute(
        path: AppRoutes.detailTransaction,
        builder: (context, state) {
          final transaction = state.extra as TransactionModel;
          return DetailTransactionScreen(transaction: transaction);
        },
      ),
    ],

    // Xử lý chuyển hướng (Redirect)
    redirect: (context, state) {
      final currentPath = state.uri.path;
      final isAuthenticated = authState.isAuthenticated;
      final isInitial = authState.isInitial;

      // Auth chưa khởi tạo xong -> đợi
      if (isInitial) {
        return null;
      }

      final isAuthRoute = authRoutes.contains(currentPath);

      // Nếu đã đăng nhập mà đang ở trang auth (Login/Register...) -> redirect thẳng vào màn hình tương ứng
      if (isAuthenticated && isAuthRoute) {
        final role = authState.userRole;
        if (role == 'parent') {
          return AppRoutes.parent;
        } else if (role == 'student') {
          return AppRoutes.studentMain;
        } else {
          return AppRoutes.parent; // Tạm thời fallback nếu role chưa set
        }
      }

      // Đang ở onboarding hoặc splash -> cho phép access để xử lý logic bên trong SplashScreen hoặc Onboarding
      if (currentPath == AppRoutes.splash ||
          currentPath == AppRoutes.onboard1) {
        if (isAuthenticated && currentPath == AppRoutes.onboard1) {
          // Ngăn Onboarding nếu đã login
          final role = authState.userRole;
          return role == 'parent' ? AppRoutes.parent : AppRoutes.studentMain;
        }
        return null;
      }

      // Chưa đăng nhập và đang ở trang private -> redirect về login
      if (!isAuthenticated && !isAuthRoute) {
        return AppRoutes.login;
      }

      return null;
    },
  );
});

/// Helper class để refresh GoRouter khi Riverpod state thay đổi
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(this._ref) {
    _ref.listen(authProvider, (previous, next) {
      notifyListeners();
    });
  }

  final Ref _ref;
}
