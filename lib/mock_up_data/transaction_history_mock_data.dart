// Mock data for [TransactionHistorySkeleton] — mirrors the real transaction
// history UI (summary card + 3-item switch tab + grouped transaction list).
// Text values are placeholders only; Skeletonizer paints shimmer bones over
// them, so the exact strings are never visible to the user.

// ── Summary card ─────────────────────────────────────────────────────────────
const String kMockSummaryEyebrow = 'Tổng quan giao dịch';
const String kMockSummaryMonth = 'Tháng 5 / 2025';
const String kMockSummaryBadge = 'Đã chi tháng này';
const String kMockSummaryMainAmount = '1.750.000 VND';

const String kMockStatIncomeLabel = 'Thu tiền';
const String kMockStatIncomeValue = '3,0M';
const String kMockStatExpenseLabel = 'Chi tiền';
const String kMockStatExpenseValue = '1,75M';
const String kMockStatLimitLabel = 'Hạn mức còn lại';
const String kMockStatLimitValue = '1,25M';

// ── Switch tabs ──────────────────────────────────────────────────────────────
const String kMockTabAll = 'Tất cả';
const String kMockTabIncome = 'Thu tiền';
const String kMockTabExpense = 'Chi tiền';

// ── Grouped transaction list ─────────────────────────────────────────────────
const List<MockTxGroup> kMockTxGroups = [
  MockTxGroup('23 THÁNG 5, 2025', '- 270.000 VND', [
    MockTxItem('Siêu thị VinMart', 'Ăn uống', '-120.000 VND', '🛒', '14:30 · Hôm nay'),
    MockTxItem('Shopee', 'Mua sắm', '-85.000 VND', '🛍️', '10:12 · Hôm nay'),
    MockTxItem('Grab Food', 'Ăn uống', '-65.000 VND', '🍜', '08:45 · Hôm nay'),
  ]),
  MockTxGroup('22 THÁNG 5, 2025', '+ 420.000 VND', [
    MockTxItem('Bố chuyển tiền', 'Thu nhập', '+500.000 VND', '💸', '19:00 · Hôm qua'),
    MockTxItem('Highlands Coffee', 'Ăn uống', '-55.000 VND', '☕', '15:20 · Hôm qua'),
    MockTxItem('Xe buýt', 'Di chuyển', '-25.000 VND', '🚌', '07:30 · Hôm qua'),
  ]),
];

class MockTxGroup {
  const MockTxGroup(this.date, this.sum, this.items);
  final String date;
  final String sum;
  final List<MockTxItem> items;
}

class MockTxItem {
  const MockTxItem(
    this.title,
    this.category,
    this.amount,
    this.emoji,
    this.meta,
  );
  final String title;
  final String category;
  final String amount;
  final String emoji;
  final String meta;

  bool get isExpense => amount.startsWith('-');
}
