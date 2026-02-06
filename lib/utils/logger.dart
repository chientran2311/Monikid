import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryLoggerWrapper {
  final Logger _logger;

  SentryLoggerWrapper() : _logger = Logger();

  void v(dynamic message, {StackTrace? stackTrace}) {
    _logger.t(message, stackTrace: stackTrace);
  }

  void d(dynamic message, {StackTrace? stackTrace}) {
    _logger.d(message, stackTrace: stackTrace);
  }

  void i(dynamic message, {StackTrace? stackTrace}) {
    _logger.i(message, stackTrace: stackTrace);
  }

  void w(dynamic message, {StackTrace? stackTrace}) {
    _logger.w(message, stackTrace: stackTrace);
  }

  void e(dynamic message, {StackTrace? stackTrace}) {
    _logger.e(message, stackTrace: stackTrace);

    if (message is Exception) {
      // Capture exception to Sentry
      // Note: Sensitive data should be filtered in beforeSend callback in main.dart
      Sentry.captureException(message, stackTrace: stackTrace);
    }
  }
}

var logger = SentryLoggerWrapper();
