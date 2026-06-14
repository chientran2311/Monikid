import 'package:monikid/core/utils/currency_formatter.dart';

mixin AmountFormatterMixin {
  String formatAmount(int minor) => CurrencyFormatter.format(minor);

  int computeRemainingPct(int expenseMinor, int limitMinor) {
    if (limitMinor <= 0) return 100;
    return ((limitMinor - expenseMinor) / limitMinor * 100)
        .clamp(0.0, 100.0)
        .round();
  }
}
