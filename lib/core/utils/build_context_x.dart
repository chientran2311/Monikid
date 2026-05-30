import 'package:flutter/widgets.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/l10n/app_localizations.dart';
import 'package:monikid/shared/widgets/app_snackbar.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  AppTypography get typo => AppTypographyScope.of(this);

  void showErrorSnackBar(String message) =>
      AppSnackBar.error(this, message);

  void showSuccessSnackBar(String message) =>
      AppSnackBar.success(this, message);
}

extension NavigatorKeyX on GlobalKey<NavigatorState> {
  AppLocalizations get l10n => currentContext!.l10n;
}
