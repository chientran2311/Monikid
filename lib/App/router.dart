import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth provider
import 'package:monikid/features/auth/providers/auth_provider.dart';

// Import screens
// (Đảm bảo các đường dẫn import này đúng với cấu trúc thư mục thực tế của bạn)
import 'package:monikid/features/auth/splash/splash_screen.dart';
import 'package:monikid/features/auth/login/login_screen.dart';
import 'package:monikid/features/auth/register/register.dart';
import 'package:monikid/features/auth/onboard/onboard_1.dart';
import 'package:monikid/features/auth/onboard/onboard_2.dart';
import 'package:monikid/features/auth/onboard/onboard_3.dart';

import 'package:monikid/features/home/home_screen.dart'; 
import 'package:monikid/features/wallet/wallet_screen.dart';
import 'package:monikid/features/wallet/transfer_money_screen.dart';
import 'package:monikid/features/wallet/withdraw_deposit.dart';

class AppRoutes {
  AppRoutes._();

  // Auth routes
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String onboard1 = '/onboard-1';
  static const String onboard2 = '/onboard-2';
  static const String onboard3 = '/onboard-3';
  static const String createFamily = '/create-family';
  static const String joinFamily = '/join-family';
  static const String forgotPassword = '/forgot-password';

  // Parent routes
  static const String parent = '/parent';
  // Note: Các route con thường dùng trong ShellRoute (BottomNav), 
  // tạm thời định nghĩa dạng flat URL để chạy được ngay.
  static const String parentHome = '/home';
  static const String parentWallet = '/wallet';
  static const String parentTransfer = '/transfer';
  static const String parentWithdrawDeposit = '/withdraw-deposit';
  static const String parentChildren = '/children';
  static const String parentChildDetail = '/children/:id'; // Dynamic param

  // Child routes
  static const String child = '/child';
  static const String childHome = '/child/home';
}

/// Global Key để quản lý Navigator (hữu ích khi cần show dialog/snackbar từ logic)
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// Danh sách các route công khai (không cần đăng nhập)
const publicRoutes = [
  AppRoutes.splash,
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.onboard1,
  AppRoutes.onboard2,
  AppRoutes.onboard3,
  AppRoutes.forgotPassword,
];

/// 🟢 ROUTER PROVIDER
/// Đây là biến mà MoniKidApp đang thiếu
final routerProvider = Provider<GoRouter>((ref) {
  // Lắng nghe auth state changes để refresh router
  final authState = ref.watch(authProvider);
  
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.onboard1, // Màn hình đầu tiên khi mở app
    debugLogDiagnostics: true, // In log chuyển trang để dễ debug
    
    // Refresh router khi auth state thay đổi
    refreshListenable: GoRouterRefreshStream(ref),

    // Định nghĩa danh sách các màn hình
    routes: [
      // --- AUTH GROUP ---
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboard1,
        builder: (context, state) => const Onboard1Screen(),
      ),
      GoRoute(
        path: AppRoutes.onboard2,
        builder: (context, state) => const Onboard2Screen(),
      ),
      GoRoute(
        path: AppRoutes.onboard3,
        builder: (context, state) => const Onboard3Screen(),
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
        path: AppRoutes.parentHome,
        builder: (context, state) => const ParentHomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.parentWallet,
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        path: AppRoutes.parentTransfer,
        builder: (context, state) => const TransferMoneyScreen(),
      ),
      GoRoute(
        path: AppRoutes.parentWithdrawDeposit,
        builder: (context, state) => const WithdrawDepositScreen(),
      ),  
      // GoRoute(
      //   path: AppRoutes.forgotPassword,
      //   builder: (context, state) => const ForgotPasswordScreen(),
      // ),
      
      // Placeholder cho các màn hình chưa import (Bỏ comment khi bạn đã tạo file)
      /*
      GoRoute(
        path: AppRoutes.createFamily,
        builder: (context, state) => const CreateFamilyScreen(),
      ),
      GoRoute(
        path: AppRoutes.joinFamily,
        builder: (context, state) => const JoinFamilyScreen(),
      ),
      */

      // --- PARENT GROUP ---
      // Nếu sau này bạn làm BottomNavigationBar, bạn sẽ cần đổi thành ShellRoute
      GoRoute(
        path: AppRoutes.parent,
        builder: (context, state) => const ParentHomeScreen(),
        routes: [
          // Định nghĩa các sub-routes: /parent/children/:id
          GoRoute(
            path: AppRoutes.parentChildDetail,
            builder: (context, state) {
              // Lấy ID từ URL
              final childId = state.pathParameters['id'];
              // Trả về màn hình chi tiết (Ví dụ)
              // return ChildDetailScreen(id: childId);
              return Scaffold(body: Center(child: Text("Detail for $childId"))); 
            },
          ),
        ],
      ),

      // --- CHILD GROUP ---
      // GoRoute(
      //   path: AppRoutes.child,
      //   builder: (context, state) => const ChildHomeScreen(),
      // ),
    ],

    // Xử lý chuyển hướng (Redirect)
    // Kiểm tra auth state và redirect phù hợp
    redirect: (context, state) {
      final currentPath = state.uri.path;
      final isPublicRoute = publicRoutes.contains(currentPath);
      final isAuthenticated = authState.isAuthenticated;
      final isInitial = authState.isInitial;
      
      // Đang ở onboarding hoặc splash -> cho phép access
      if (currentPath == AppRoutes.splash || 
          currentPath == AppRoutes.onboard1 ||
          currentPath == AppRoutes.onboard2 ||
          currentPath == AppRoutes.onboard3) {
        return null;
      }
      
      // Auth chưa khởi tạo xong -> đợi
      if (isInitial) {
        return null;
      }
      
      // Đã đăng nhập nhưng đang ở trang auth -> redirect về home
      if (isAuthenticated && isPublicRoute) {
        return AppRoutes.parentHome;
      }
      
      // Chưa đăng nhập và đang ở trang private -> redirect về login
      if (!isAuthenticated && !isPublicRoute) {
        return AppRoutes.login;
      }
      
      // Các trường hợp khác -> cho phép truy cập
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