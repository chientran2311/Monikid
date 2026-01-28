import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import screens from feature folders
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/parent/presentation/screens/parent_home_screen.dart';
import '../features/child/presentation/screens/child_home_screen.dart';
import '../features/wallet/presentation/screens/wallet_detail_screen.dart';

/// MoniKid App Router Configuration
///
/// Route structure:
/// - /                    → Splash
/// - /welcome             → Welcome screen
/// - /login               → Login
/// - /register            → Register
/// - /create-family       → Create family (parent)
/// - /join-family         → Join family with code
///
/// Parent routes:
/// - /parent              → Parent shell (with bottom nav)
/// - /parent/home         → Dashboard
/// - /parent/bank         → Mock bank
/// - /parent/children     → Children list
/// - /parent/children/:id → Child detail
/// - /parent/chat         → Family chat
/// - /parent/settings     → Settings
///
/// Child routes:
/// - /child               → Child shell (with bottom nav)
/// - /child/home          → Dashboard
/// - /child/pay           → QR Payment
/// - /child/receipts      → Receipts
/// - /child/request       → Request money
/// - /child/chat          → Family chat
/// - /child/settings      → Settings

// Route names for type-safe navigation
abstract class AppRoutes {
  AppRoutes._();

  // Auth routes
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String createFamily = '/create-family';
  static const String joinFamily = '/join-family';
  static const String forgotPassword = '/forgot-password';

  // Parent routes
  static const String parent = '/parent';
  static const String parentHome = '/parent/home';
  static const String parentBank = '/parent/bank';
  static const String parentChildren = '/parent/children';
  static const String parentChildDetail = '/parent/children/:id';
  static const String parentChat = '/parent/chat';
  static const String parentSettings = '/parent/settings';
  static const String parentAllowance = '/parent/allowance';
  static const String parentReports = '/parent/reports';

  // Child routes
  static const String child = '/child';
  static const String childHome = '/child/home';
  static const String childPay = '/child/pay';
  static const String childReceipts = '/child/receipts';
  static const String childRequest = '/child/request';
  static const String childChat = '/child/chat';
  static const String childSettings = '/child/settings';
  static const String childSpending = '/child/spending';
}

/// Router provider using Riverpod
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // ======================================================================
      // AUTH ROUTES
      // ======================================================================
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.createFamily,
        name: 'createFamily',
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Tạo gia đình'),
      ),
      GoRoute(
        path: AppRoutes.joinFamily,
        name: 'joinFamily',
        builder: (context, state) =>
            const _PlaceholderScreen(title: 'Tham gia gia đình'),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // ======================================================================
      // PARENT ROUTES (with shell for bottom navigation)
      // ======================================================================
      ShellRoute(
        builder: (context, state, child) {
          return _ParentShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.parentHome,
            name: 'parentHome',
            builder: (context, state) => const ParentHomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.parentBank,
            name: 'parentBank',
            builder: (context, state) => const WalletDetailScreen(isParent: true),
          ),
          GoRoute(
            path: AppRoutes.parentChildren,
            name: 'parentChildren',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Con cái'),
            routes: [
              GoRoute(
                path: ':id',
                name: 'parentChildDetail',
                builder: (context, state) {
                  final childId = state.pathParameters['id']!;
                  return _PlaceholderScreen(title: 'Chi tiết: $childId');
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.parentChat,
            name: 'parentChat',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Chat gia đình'),
          ),
          GoRoute(
            path: AppRoutes.parentSettings,
            name: 'parentSettings',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Cài đặt'),
          ),
          GoRoute(
            path: AppRoutes.parentAllowance,
            name: 'parentAllowance',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Tiền tiêu vặt'),
          ),
          GoRoute(
            path: AppRoutes.parentReports,
            name: 'parentReports',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Báo cáo'),
          ),
        ],
      ),

      // ======================================================================
      // CHILD ROUTES (with shell for bottom navigation)
      // ======================================================================
      ShellRoute(
        builder: (context, state, child) {
          return _ChildShell(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.childHome,
            name: 'childHome',
            builder: (context, state) => const ChildHomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.childPay,
            name: 'childPay',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Thanh toán QR'),
          ),
          GoRoute(
            path: AppRoutes.childReceipts,
            name: 'childReceipts',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Hóa đơn'),
          ),
          GoRoute(
            path: AppRoutes.childRequest,
            name: 'childRequest',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Xin tiền'),
          ),
          GoRoute(
            path: AppRoutes.childChat,
            name: 'childChat',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Chat gia đình'),
          ),
          GoRoute(
            path: AppRoutes.childSettings,
            name: 'childSettings',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Cài đặt'),
          ),
          GoRoute(
            path: AppRoutes.childSpending,
            name: 'childSpending',
            builder: (context, state) =>
                const _PlaceholderScreen(title: 'Chi tiêu của tôi'),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => _PlaceholderScreen(
      title: 'Lỗi: ${state.error?.message ?? 'Không tìm thấy trang'}',
    ),
  );
});

// =============================================================================
// PLACEHOLDER WIDGETS (to be replaced with actual screens)
// =============================================================================

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Màn hình đang phát triển',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParentShell extends StatelessWidget {
  final Widget child;

  const _ParentShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _getSelectedIndex(context),
        onDestinationSelected: (index) => _onDestinationSelected(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_outlined),
            selectedIcon: Icon(Icons.account_balance),
            label: 'Ngân hàng',
          ),
          NavigationDestination(
            icon: Icon(Icons.child_care_outlined),
            selectedIcon: Icon(Icons.child_care),
            label: 'Con cái',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.parentBank)) return 1;
    if (location.startsWith(AppRoutes.parentChildren)) return 2;
    if (location.startsWith(AppRoutes.parentChat)) return 3;
    if (location.startsWith(AppRoutes.parentSettings)) return 4;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.parentHome);
        break;
      case 1:
        context.go(AppRoutes.parentBank);
        break;
      case 2:
        context.go(AppRoutes.parentChildren);
        break;
      case 3:
        context.go(AppRoutes.parentChat);
        break;
      case 4:
        context.go(AppRoutes.parentSettings);
        break;
    }
  }
}

class _ChildShell extends StatelessWidget {
  final Widget child;

  const _ChildShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _getSelectedIndex(context),
        onDestinationSelected: (index) => _onDestinationSelected(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner_outlined),
            selectedIcon: Icon(Icons.qr_code_scanner),
            label: 'Thanh toán',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Hóa đơn',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.childPay)) return 1;
    if (location.startsWith(AppRoutes.childReceipts)) return 2;
    if (location.startsWith(AppRoutes.childChat)) return 3;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppRoutes.childHome);
        break;
      case 1:
        context.go(AppRoutes.childPay);
        break;
      case 2:
        context.go(AppRoutes.childReceipts);
        break;
      case 3:
        context.go(AppRoutes.childChat);
        break;
    }
  }
}
