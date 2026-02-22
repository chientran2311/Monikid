import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth provider
import 'package:monikid/features/auth/providers/auth_provider.dart';

// Import screens
import 'package:monikid/features/auth/splash/splash_screen.dart';
import 'package:monikid/features/auth/login/login_screen.dart';
import 'package:monikid/features/auth/register/register.dart';
import 'package:monikid/features/auth/onboard/onboarding_screen.dart';
import 'package:monikid/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:monikid/features/auth/update_password/update_password_screen.dart';

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
      GoRoute(
        path: AppRoutes.updatePassword,
        builder: (context, state) => const UpdatePasswordScreen(),
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

      // Nếu đã đăng nhập mà đang ở trang auth (Login/Register...) -> redirect về splash,
      // Splash sẽ quyết định vào Home nào dựa trên Role
      if (isAuthenticated && isAuthRoute) {
        return AppRoutes.splash;
      }

      // Đang ở onboarding hoặc splash -> cho phép access để xử lý logic bên trong SplashScreen hoặc Onboarding
      if (currentPath == AppRoutes.splash ||
          currentPath == AppRoutes.onboard1) {
        // Tuy nhiên nếu người dùng đã đăng nhập mà vào Onboard thì cũng đá về Splash
        if (isAuthenticated && currentPath == AppRoutes.onboard1) {
          return AppRoutes.splash;
        }
        return null; // Trả về null để vào Splash
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
