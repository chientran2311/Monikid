const String kMockSummaryIncome = '3.000.000 VND';
const String kMockSummaryExpense = '1.750.000 VND';
const String kMockTabExpense = 'Chi tiêu';
const String kMockTabIncome = 'Thu nhập';

const List<MockTxGroup> kMockTxGroups = [
  MockTxGroup('23 tháng 5, 2025', '- 205.000 VND', [
    MockTxItem('Siêu thị VinMart', 'Ăn uống', '-120.000 VND'),
    MockTxItem('Shopee', 'Mua sắm', '-85.000 VND'),
    MockTxItem('Grab Food', 'Ăn uống', '-65.000 VND'),
  ]),
  MockTxGroup('22 tháng 5, 2025', '+ 500.000 VND', [
    MockTxItem('Bố chuyển tiền', 'Thu nhập', '+500.000 VND'),
    MockTxItem('Highlands Coffee', 'Ăn uống', '-55.000 VND'),
    MockTxItem('Xe buýt', 'Di chuyển', '-25.000 VND'),
  ]),
];

class MockTxGroup {
  const MockTxGroup(this.date, this.sum, this.items);
  final String date;
  final String sum;
  final List<MockTxItem> items;
}

class MockTxItem {
  const MockTxItem(this.title, this.category, this.amount);
  final String title;
  final String category;
  final String amount;
}
