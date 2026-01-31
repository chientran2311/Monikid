import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router.dart';
import 'package:monikid/core/theme/theme.dart';

/// Main App Widget
class MoniKidApp extends ConsumerWidget {
  const MoniKidApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'MoniKid',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Router
      routerConfig: router,

      // Localization (will be configured with flutter_localization)
      // locale: const Locale('vi', 'VN'),
      // supportedLocales: const [
      //   Locale('vi', 'VN'),
      //   Locale('en', 'US'),
      // ],
    );
  }
}
