import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/features/auth/login/login_page.dart';
import 'package:monikid/features/auth/register/register_page.dart';
import 'package:monikid/features/home/home_page.dart';
import 'package:monikid/features/post/post_page.dart';
import 'package:monikid/features/setting/setting_page.dart';

/// Định nghĩa các route paths
abstract class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String posts = '/posts';
  static const String comments = '/comments';
  static const String albums = '/albums';
  static const String photos = '/photos';
  static const String todos = '/todos';
  static const String users = '/users';
}

/// Cấu hình GoRouter cho ứng dụng
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'setting',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.posts,
      name: 'posts',
      builder: (context, state) => const PostsListScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'Page not found: ${state.uri.path}',
        style: const TextStyle(color: Colors.white),
      ),
    ),
  ),
);
