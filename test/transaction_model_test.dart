import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monikid/features/child/transaction/providers/category_provider.dart';
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
        'category': 'Food',
        'date': '2026-03-29T10:30:00.000',
      });

      expect(transaction.transactionId, 'tx-1');
      expect(transaction.date, DateTime.parse('2026-03-29T10:30:00.000'));
    });

    test('toFirestore writes schema transaction fields', () {
      final transaction = TransactionModel(
        transactionId: 'tx-2',
        userId: 'user-1',
        amountMinor: 25000,
        type: 'income',
        categoryKey: 'reward',
        categoryLabel: 'Reward',
        dateTs: DateTime(2026, 3, 29, 12, 45),
      );

      final firestoreData = transaction.toFirestore();

      expect(firestoreData['transaction_id'], 'tx-2');
      expect(firestoreData['amount_minor'], 25000);
      expect(firestoreData['category_label'], 'Reward');
      expect(firestoreData['date_ts'], isA<Timestamp>());
    });

    test('fromFirestore reads evidence image metadata', () {
      final uploadedAt = Timestamp.fromDate(DateTime(2026, 4, 19, 9, 30));
      final transaction = TransactionModel.fromFirestore({
        'transaction_id': 'tx-3',
        'user_id': 'user-1',
        'amount_minor': 42000,
        'type': 'expense',
        'category_key': 'snacks',
        'category_label': 'Snacks',
        'date_ts': Timestamp.fromDate(DateTime(2026, 4, 19, 10, 0)),
        'evidence_image': {
          'storage_path': 'transactions/user-1/tx-3/evidence.jpg',
          'file_name': 'evidence.jpg',
          'mime_type': 'image/jpeg',
          'uploaded_at': uploadedAt,
        },
      });

      expect(transaction.evidenceImage, isNotNull);
      expect(
        transaction.evidenceImage?.storagePath,
        'transactions/user-1/tx-3/evidence.jpg',
      );
      expect(transaction.evidenceImage?.fileName, 'evidence.jpg');
      expect(transaction.evidenceImage?.mimeType, 'image/jpeg');
      expect(
        transaction.evidenceImage?.uploadedAt,
        DateTime(2026, 4, 19, 9, 30),
      );
    });

    test('toFirestore writes evidence image metadata without download url', () {
      final transaction = TransactionModel(
        transactionId: 'tx-4',
        userId: 'user-1',
        amountMinor: 18000,
        type: 'expense',
        categoryKey: 'books',
        categoryLabel: 'Books',
        dateTs: DateTime(2026, 4, 19, 14, 30),
        evidenceImage: const TransactionEvidenceImage(
          storagePath: 'transactions/user-1/tx-4/evidence.png',
          fileName: 'evidence.png',
          mimeType: 'image/png',
        ),
      );

      final firestoreData = transaction.toFirestore();
      final evidenceImage =
          firestoreData['evidence_image'] as Map<String, dynamic>?;

      expect(evidenceImage, isNotNull);
      expect(
        evidenceImage?['storage_path'],
        'transactions/user-1/tx-4/evidence.png',
      );
      expect(evidenceImage?['file_name'], 'evidence.png');
      expect(evidenceImage?['mime_type'], 'image/png');
      expect(evidenceImage?.containsKey('download_url'), isFalse);
    });
  });

  group('Category merge helpers', () {
    test('mergeTransactionCategories deduplicates by label and type', () {
      final merged = mergeTransactionCategories([
        const CategoryModel(
          id: 'custom-expense-food',
          label: 'Food',
          icon: '🍲',
          type: 'expense',
        ),
        const CategoryModel(
          id: 'custom-income-reward',
          label: 'Reward',
          icon: '🎉',
          type: 'income',
        ),
      ]);

      final expenseMatches = merged
          .where(
            (category) => category.label == 'Food' && category.type == 'expense',
          )
          .toList();
      final incomeMatches = merged
          .where(
            (category) => category.label == 'Reward' && category.type == 'income',
          )
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

    test('transactionCategoryKeyForCategory slugifies category label', () {
      const category = CategoryModel(
        id: 'expense-an-uong',
        label: 'Ăn uống',
        icon: '🍜',
        type: 'expense',
      );

      expect(transactionCategoryKeyForCategory(category), 'n_u_ng');
    });
  });
}
