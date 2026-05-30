class CalendarUtils {
  CalendarUtils._();

  /// Days in a given month/year — handles leap years automatically.
  static int daysInMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }

  /// 4 most recent years up to and including the current year.
  static List<int> recentYears() {
    final current = DateTime.now().year;
    return List.generate(4, (i) => current - 3 + i);
  }
}
