const String kMockStatTitle = 'Thống kê';
const String kMockInsightText =
    'Tháng này bạn chi tiêu ít hơn 15% so với tháng trước. Tiếp tục duy trì!';

// Budget overview card
const String kMockBudgetLabel = 'Giới hạn chi tiêu';
const String kMockBudgetSpentStr = '1.750K';
const String kMockBudgetLimitStr = '/ 3.000.000 đ';
const String kMockBudgetStatusLabel = 'Đúng hướng';
const String kMockUsageLabel = 'Mức sử dụng';
const String kMockBudgetAmount = '3.000.000 VND';
const String kMockBudgetRemaining = 'Còn lại: 1.250.000 đ';
const String kMockBudgetAdjustHint = 'Điều chỉnh bất cứ lúc nào';
const String kMockBudgetUsed = '58%';

// Spending trend section (bar chart)
const String kMockChartEyebrow = 'CHI TIÊU';
const String kMockChartTitle = 'So sánh theo ngày';
const String kMockPeriodLabel = 'Tuần này';

const List<double> kMockBarHeights = [0.4, 0.7, 0.3, 1.0, 0.5, 0.6, 0.2];
const List<String> kMockBarAmounts = [
  '420kđ',
  '730kđ',
  '310kđ',
  '1Mđ',
  '520kđ',
  '630kđ',
  '210kđ',
];
const List<String> kMockBarDayLabels = [
  'T2',
  'T3',
  'T4',
  'T5',
  'T6',
  'T7',
  'CN',
];

// Top categories section
const String kMockTopCatTitle = 'Top danh mục';
const String kMockViewAllLabel = 'Xem tất cả';

// Spending allocation section
const String kMockAllocTitle = 'Phân bổ chi tiêu';
const String kMockTotalSpentLabel = 'Tổng chi';
const String kMockTotalSpentStr = '1.5Mđ';

const List<MockCategory> kMockCategories = [
  MockCategory('Ăn uống', '850.000 đ', '12 giao dịch', '57%', '🍜'),
  MockCategory('Mua sắm', '420.000 đ', '6 giao dịch', '28%', '🛍️'),
  MockCategory('Di chuyển', '230.000 đ', '8 giao dịch', '15%', '🚌'),
];

class MockCategory {
  const MockCategory(
    this.name,
    this.amount,
    this.count,
    this.percent,
    this.emoji,
  );
  final String name;
  final String amount;
  final String count;
  final String percent;
  final String emoji;
}
