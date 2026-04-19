import 'package:flutter/widgets.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/l10n/app_localizations.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  AppTypography get typo => AppTypography(this);
}

extension NavigatorKeyX on GlobalKey<NavigatorState> {
  AppLocalizations get l10n => currentContext!.l10n;
}
