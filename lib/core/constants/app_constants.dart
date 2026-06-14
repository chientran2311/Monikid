import 'package:monikid/models/entities/category_model.dart';

class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'MoniKid';
  static const String appVersion = '1.0.0';

  // Location Rules
  static const int locationIntervalMinutes = 15;

  // OTP & Invite Rules
  static const String demoOtpCode = '123456';
  static const int otpLength = 6;
  static const int inviteCodeLength = 6;

  // Transaction Limits
  static const double maxTransactionAmount = 100000000; // 100M VND
  static const double minTransactionAmount = 1000; // 1K VND

  // Currency Formatting
  static const String currencySymbol = '₫';
  static const String currencyCode = 'VND';
  static const String currencyLocale = 'vi_VN';

  // Default transaction categories.
  // These IDs are stored in Firestore as `category_id`.
  // When displaying or filtering transactions, map the stored ID back to the
  // matching entry in this list to retrieve the local label, icon, and color.
  static const List<CategoryModel> defaultTransactionCategories = [
    // --- Expense ---
    CategoryModel(
      id: 'expense-an-uong',
      label: 'Ăn uống',
      icon: '🍜',
      type: 'expense',
      colorHex: '0xFF4ADE80',
      isDefault: true,
    ),
    CategoryModel(
      id: 'expense-di-chuyen',
      label: 'Di chuyển',
      icon: '🚌',
      type: 'expense',
      colorHex: '0xFF60A5FA',
      isDefault: true,
    ),
    CategoryModel(
      id: 'expense-hoc-tap',
      label: 'Học tập',
      icon: '📚',
      type: 'expense',
      colorHex: '0xFFA78BFA',
      isDefault: true,
    ),
    CategoryModel(
      id: 'expense-giai-tri',
      label: 'Giải trí',
      icon: '🎮',
      type: 'expense',
      colorHex: '0xFFF472B6',
      isDefault: true,
    ),
    CategoryModel(
      id: 'expense-mua-sam',
      label: 'Mua sắm',
      icon: '🛍️',
      type: 'expense',
      colorHex: '0xFFFBBF24',
      isDefault: true,
    ),
    CategoryModel(
      id: 'expense-suc-khoe',
      label: 'Sức khỏe',
      icon: '💊',
      type: 'expense',
      colorHex: '0xFFF87171',
      isDefault: true,
    ),
    CategoryModel(
      id: 'expense-sinh-hoat',
      label: 'Sinh hoạt',
      icon: '🏠',
      type: 'expense',
      colorHex: '0xFFFB923C',
      isDefault: true,
    ),
    CategoryModel(
      id: 'expense-khac',
      label: 'Khác',
      icon: '📦',
      type: 'expense',
      colorHex: '0xFF94A3B8',
      isDefault: true,
    ),
    // --- Income ---
    CategoryModel(
      id: 'income-luong',
      label: 'Tiền lương',
      icon: '💵',
      type: 'income',
      colorHex: '0xFF22C55E',
      isDefault: true,
    ),
    CategoryModel(
      id: 'income-khac',
      label: 'Khác',
      icon: '✨',
      type: 'income',
      colorHex: '0xFF64748B',
      isDefault: true,
    ),
  ];
}