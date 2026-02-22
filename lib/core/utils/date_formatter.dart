import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String toDisplay(DateTime d) => DateFormat('dd/MM/yyyy').format(d);

  static String toMonthYear(DateTime d) => DateFormat('MM/yyyy').format(d);

  static String toMonthKey(DateTime d) => DateFormat('yyyy-MM').format(d);

  static String toRelative(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inDays == 0) return 'Hôm nay';
    if (diff.inDays == 1) return 'Hôm qua';
    if (diff.inDays < 7) return '${diff.inDays} ngày trước';
    return toDisplay(d);
  }
}
