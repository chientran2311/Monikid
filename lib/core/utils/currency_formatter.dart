import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _vnd = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'đ',
    decimalDigits: 0,
  );

  /// 1500000 → "1.500.000đ"
  static String format(num amount) => _vnd.format(amount);

  /// income 1500000 → "+1.500.000đ" | expense → "-1.500.000đ"
  static String formatWithSign(num amount, String type) {
    final f = _vnd.format(amount.abs());
    return type == 'income' ? '+$f' : '-$f';
  }

  /// "1.500.000" → 1500000.0
  static double parse(String value) {
    final clean = value
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll('đ', '')
        .trim();
    return double.tryParse(clean) ?? 0;
  }

  /// 1500000 → "1,5Tr đ" | 500000 → "500k đ"
  static String formatCompact(num amount) {
    if (amount >= 1e9) {
      return '${(amount / 1e9).toStringAsFixed(1)}T đ'; // Tỷ
    } else if (amount >= 1e6) {
      return '${(amount / 1e6).toStringAsFixed(1)}Tr đ'; // Triệu
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}k đ'; // Nghìn
    }
    return format(amount);
  }
}
