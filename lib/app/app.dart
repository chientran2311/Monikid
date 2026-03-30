import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/l10n/app_localizations.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';

/// Global S accessor so S can be accessed anywhere
S get s => S.of(rootNavigatorKey.currentContext!)!;

/// Main App Widget
class MoniKidApp extends ConsumerWidget {
  const MoniKidApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final localeState = ref.watch(changeLanguageProvider);

    return MaterialApp.router(
      title: 'MoniKid',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Router
      routerConfig: router,
      builder: (context, child) {
        ScreenUtils.init(context);
        return child ?? const SizedBox.shrink();
      },

      // Localization
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
      locale: Locale(localeState.localeCode),
    );
  }
}
