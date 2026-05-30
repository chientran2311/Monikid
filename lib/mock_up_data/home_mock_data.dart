const String kMockUserName = 'Nguyễn Văn An';
const String kMockGreeting = 'Xin chào,';
const String kMockRemainingBudget = '1.250.000 VND';
const String kMockMonthlyIncome = '3.000.000';
const String kMockMonthlyExpense = '1.750.000';
const String kMockIncomeLbl = 'Thu nhập';
const String kMockExpenseLbl = 'Chi tiêu';
const String kMockScanBillLbl = 'Quét hóa đơn';
const String kMockSetLimitLbl = 'Đặt hạn mức';
const String kMockRecentTitle = 'Giao dịch gần đây';
const String kMockViewAll = 'Xem tất cả';

// Summary card
const String kMockEyebrow = 'TỔNG QUAN';
const String kMockSummaryTitle = 'Tháng 5, 2025';
const String kMockMonthPill = 'T5 · 2025';
const String kMockExpenseAmount = '1.250.000';
const String kMockRemainingBadge = 'Còn 750.000';

// Stat cards
const String kMockLimitStatLabel = 'HẠN MỨC';
const String kMockLimitStatValue = '2.000.000';
const String kMockLimitStatSub = 'Đã dùng 62%';
const String kMockTxStatLabel = 'GIAO DỊCH';
const String kMockTxStatValue = '8 GD';
const String kMockTxStatSub = '2 hôm nay';
const String kMockTopCatStatLabel = 'CHI NHIỀU NHẤT';
const String kMockTopCatStatValue = 'Ăn uống';
const String kMockTopCatStatSub = '450.000';

// Quick actions
const String kMockQuickActionsTitle = 'Thao tác nhanh';
const String kMockScanBillTitle = 'Quét hóa đơn';
const String kMockScanBillSubtitle = 'Tự động ghi nhận';
const String kMockSetLimitTitle = 'Đặt hạn mức';
const String kMockSetLimitSubtitle = 'Quản lý chi tiêu';

// Legacy — kept for backward compat
const List<MockTransaction> kMockTransactions = [
  MockTransaction('Siêu thị VinMart', 'Hôm nay, 09:15', '-120.000 VND'),
  MockTransaction('Shopee', '23/05, 14:30', '-85.000 VND'),
  MockTransaction('Bố chuyển tiền', '22/05, 08:00', '+500.000 VND'),
  MockTransaction('Grab Food', '21/05, 19:45', '-65.000 VND'),
  MockTransaction('Highlands Coffee', '21/05, 11:00', '-55.000 VND'),
];

class MockTransaction {
  const MockTransaction(this.title, this.subtitle, this.amount);
  final String title;
  final String subtitle;
  final String amount;
}

// Rich mock transactions — mirrors TransactionItem layout
const List<MockTransactionFull> kMockTransactionsFull = [
  MockTransactionFull(
    emoji: '🍜',
    title: 'Cơm trưa văn phòng',
    timeStr: '12:30 · Hôm nay',
    categoryLabel: 'Ăn uống',
    amountStr: '-45.000',
    isExpense: true,
  ),
  MockTransactionFull(
    emoji: '💸',
    title: 'Bố chuyển tiền',
    timeStr: '08:00 · Hôm qua',
    categoryLabel: 'Thu nhập',
    amountStr: '+500.000',
    isExpense: false,
  ),
  MockTransactionFull(
    emoji: '📚',
    title: 'Sách giáo khoa',
    timeStr: '15:20 · 25 Th5',
    categoryLabel: 'Học tập',
    amountStr: '-120.000',
    isExpense: true,
  ),
  MockTransactionFull(
    emoji: '🛍️',
    title: 'Shopee',
    timeStr: '14:30 · 23 Th5',
    categoryLabel: 'Mua sắm',
    amountStr: '-85.000',
    isExpense: true,
  ),
];

class MockTransactionFull {
  const MockTransactionFull({
    required this.emoji,
    required this.title,
    required this.timeStr,
    required this.categoryLabel,
    required this.amountStr,
    required this.isExpense,
  });

  final String emoji;
  final String title;
  final String timeStr;
  final String categoryLabel;
  final String amountStr;
  final bool isExpense;
}
