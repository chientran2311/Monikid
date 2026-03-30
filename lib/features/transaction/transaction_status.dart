enum TransactionStatus {
  initial,
  loading,
  ready,
  submitting,
  success,
  error,
}

enum TransactionType {
  expense,
  income,
}

extension TransactionTypeX on TransactionType {
  String get value => this == TransactionType.income ? 'income' : 'expense';
}

TransactionType transactionTypeFromValue(String value) {
  return value == 'income' ? TransactionType.income : TransactionType.expense;
}