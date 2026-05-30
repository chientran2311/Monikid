import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/l10n/app_localizations.dart';

/// Global localization accessor for legacy non-widget call sites.
AppLocalizations get s => rootNavigatorKey.l10n;

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
        return AppTypographyScope(
          typography: AppTypography(
            defaultColor: Theme.of(context).textTheme.bodyMedium?.color ??
                Theme.of(context).colorScheme.onSurface,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },

      // Localization
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localeState.localeCode),
    );
  }
}
