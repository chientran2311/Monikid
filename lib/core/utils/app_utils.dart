import 'dart:math';
import 'package:intl/intl.dart';
import '../config/app_constants.dart';

/// Utility functions for MoniKid app.


// =============================================================================
// CURRENCY FORMATTING
// =============================================================================

abstract class CurrencyUtils {
  CurrencyUtils._();

  static final _formatter = NumberFormat.currency(
    locale: AppConstants.currencyLocale,
    symbol: AppConstants.currencySymbol,
    decimalDigits: 0,
  );

  static final _compactFormatter = NumberFormat.compactCurrency(
    locale: AppConstants.currencyLocale,
    symbol: AppConstants.currencySymbol,
    decimalDigits: 0,
  );

  /// Format amount as currency (e.g., "1.000.000 ₫")
  static String format(double amount) {
    return _formatter.format(amount);
  }

  /// Format amount as compact currency (e.g., "1M ₫")
  static String formatCompact(double amount) {
    return _compactFormatter.format(amount);
  }

  /// Parse currency string back to double
  static double? parse(String value) {
    try {
      final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
      return double.tryParse(cleaned);
    } catch (_) {
      return null;
    }
  }
}

// =============================================================================
// DATE/TIME FORMATTING
// =============================================================================

abstract class DateTimeUtils {
  DateTimeUtils._();

  static final _dateFormatter = DateFormat('dd/MM/yyyy');
  static final _timeFormatter = DateFormat('HH:mm');
  static final _dateTimeFormatter = DateFormat('dd/MM/yyyy HH:mm');
  static final _relativeDateFormatter = DateFormat('dd MMM', 'vi');

  /// Format date only (e.g., "27/01/2026")
  static String formatDate(DateTime date) {
    return _dateFormatter.format(date);
  }

  /// Format time only (e.g., "14:30")
  static String formatTime(DateTime date) {
    return _timeFormatter.format(date);
  }

  /// Format date and time (e.g., "27/01/2026 14:30")
  static String formatDateTime(DateTime date) {
    return _dateTimeFormatter.format(date);
  }

  /// Format relative date (e.g., "Hôm nay", "Hôm qua", "27 Th01")
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);

    final difference = today.difference(dateOnly).inDays;

    if (difference == 0) {
      return 'Hôm nay';
    } else if (difference == 1) {
      return 'Hôm qua';
    } else if (difference < 7) {
      return '$difference ngày trước';
    } else {
      return _relativeDateFormatter.format(date);
    }
  }

  /// Get greeting based on time of day
  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Chào buổi sáng';
    } else if (hour < 18) {
      return 'Chào buổi chiều';
    } else {
      return 'Chào buổi tối';
    }
  }
}

// =============================================================================
// STRING UTILITIES
// =============================================================================

abstract class StringUtils {
  StringUtils._();

  /// Generate random invite code (6 uppercase alphanumeric)
  static String generateInviteCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    return List.generate(
      AppConstants.inviteCodeLength,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
  }

  /// Generate mock bank account number
  static String generateAccountNumber() {
    final random = Random.secure();
    return List.generate(12, (_) => random.nextInt(10)).join();
  }

  /// Mask phone number (e.g., "0901***567")
  static String maskPhone(String phone) {
    if (phone.length < 7) return phone;
    return '${phone.substring(0, 4)}***${phone.substring(phone.length - 3)}';
  }

  /// Mask email (e.g., "exa***@email.com")
  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts[0];
    if (name.length <= 3) return email;
    return '${name.substring(0, 3)}***@${parts[1]}';
  }

  /// Get initials from name (e.g., "Nguyễn Văn A" → "NA")
  static String getInitials(String name) {
    final words = name.trim().split(' ');
    if (words.isEmpty) return '';
    if (words.length == 1) return words[0][0].toUpperCase();
    return '${words.first[0]}${words.last[0]}'.toUpperCase();
  }

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1)}';
  }
}

// =============================================================================
// VALIDATION UTILITIES
// =============================================================================

abstract class ValidationUtils {
  ValidationUtils._();

  /// Validate email format
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Validate Vietnamese phone number
  static bool isValidPhone(String phone) {
    // Vietnamese phone: starts with 0, 10 digits
    return RegExp(r'^0[3-9]\d{8}$').hasMatch(phone);
  }

  /// Validate password strength (min 6 chars)
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  /// Validate invite code format
  static bool isValidInviteCode(String code) {
    return RegExp(r'^[A-Z0-9]{6}$').hasMatch(code.toUpperCase());
  }

  /// Validate amount range
  static bool isValidAmount(double amount) {
    return amount >= AppConstants.minTransactionAmount &&
        amount <= AppConstants.maxTransactionAmount;
  }
}
