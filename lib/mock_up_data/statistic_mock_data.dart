const String kMockStatTitle = 'Thống kê';
const String kMockInsightText =
    'Tháng này bạn chi tiêu ít hơn 15% so với tháng trước. Tiếp tục duy trì!';
const String kMockBudgetLabel = 'Ngân sách tháng';
const String kMockBudgetAmount = '3.000.000 VND';
const String kMockBudgetRemaining = '1.250.000 VND';
const String kMockBudgetUsed = '58%';

const List<MockCategory> kMockCategories = [
  MockCategory('Ăn uống', '850.000 VND', '12 giao dịch'),
  MockCategory('Mua sắm', '420.000 VND', '6 giao dịch'),
  MockCategory('Di chuyển', '230.000 VND', '8 giao dịch'),
];

class MockCategory {
  const MockCategory(this.name, this.amount, this.count);
  final String name;
  final String amount;
  final String count;
}
