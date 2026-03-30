import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monikid/features/student/transaction/providers/category_provider.dart';
import 'package:monikid/models/entities/category_model.dart';
import 'package:monikid/models/entities/transaction_model.dart';

void main() {
  group('TransactionModel Firestore mapping', () {
    test('fromFirestore reads legacy date string', () {
      final transaction = TransactionModel.fromFirestore({
        'transactionId': 'tx-1',
        'userId': 'user-1',
        'amount': 15000,
        'type': 'expense',
        'category': 'Ăn uống',
        'date': '2026-03-29T10:30:00.000',
      });

      expect(transaction.transactionId, 'tx-1');
      expect(transaction.date, DateTime.parse('2026-03-29T10:30:00.000'));
    });

    test('toFirestore writes both date and dateTs', () {
      final transaction = TransactionModel(
        transactionId: 'tx-2',
        userId: 'user-1',
        amount: 25000,
        type: 'income',
        category: 'Thưởng',
        date: DateTime(2026, 3, 29, 12, 45),
      );

      final firestoreData = transaction.toFirestore();

      expect(
        firestoreData['date'],
        DateTime(2026, 3, 29, 12, 45).toIso8601String(),
      );
      expect(firestoreData['dateTs'], isA<Timestamp>());
    });
  });

  group('Category merge helpers', () {
    test('mergeTransactionCategories deduplicates by label and type', () {
      final merged = mergeTransactionCategories([
        const CategoryModel(
          id: 'custom-expense-an-uong',
          label: 'Ăn uống',
          icon: '🍲',
          type: 'expense',
        ),
        const CategoryModel(
          id: 'custom-income-thuong',
          label: 'Thưởng',
          icon: '🎉',
          type: 'income',
        ),
      ]);

      final expenseMatches = merged
          .where((category) => category.label == 'Ăn uống' && category.type == 'expense')
          .toList();
      final incomeMatches = merged
          .where((category) => category.label == 'Thưởng' && category.type == 'income')
          .toList();

      expect(expenseMatches, hasLength(1));
      expect(incomeMatches, hasLength(1));
      expect(expenseMatches.single.icon, '🍲');
      expect(incomeMatches.single.icon, '🎉');
    });

    test('getDefaultCategoryForType returns matching category', () {
      expect(getDefaultCategoryForType('income').type, 'income');
      expect(getDefaultCategoryForType('expense').type, 'expense');
    });
  });
}
