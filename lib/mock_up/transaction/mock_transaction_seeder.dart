import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/mock_up/transaction/mock_transactions.dart';
import 'package:monikid/models/entities/transaction_model.dart';

/// Seeds [mockTransactions] vào Firestore dưới path
/// `users/{userId}/transactions/{transactionId}`.
///
/// Gọi hàm này CHỈ trong môi trường dev/debug.
///
/// Logic:
///  1. Fetch user doc để lấy `family_id` thực → bắt buộc theo Firestore rule
///     (`data.family_id == requesterDoc().data.family_id`).
///  2. Ghi từng transaction riêng lẻ (không dùng batch) để lỗi từng doc
///     không làm rollback toàn bộ, và dễ debug hơn.
class MockTransactionSeeder {
  const MockTransactionSeeder._();

  /// Seed 30 mock transactions lên Firestore.
  ///
  /// [forceOverwrite] = true (default): overwrite doc đã tồn tại với data mới.
  /// [forceOverwrite] = false: skip doc đã tồn tại.
  static Future<SeedResult> seedToFirestore({
    required String userId,
    bool forceOverwrite = true,
  }) async {
    final db = FirebaseFirestore.instance;
    final logger = getIt<Logger>();
    logger.i('Start seeding mock transactions for userId=$userId.');

    // ── Bước 1: Lấy family_id thực từ user doc ────────────────────────────
    final userSnap = await db.collection('users').doc(userId).get();
    if (!userSnap.exists) {
      logger.e(
        'Cannot seed mock transactions because user document is missing. userId=$userId',
      );
      throw StateError('User document does not exist: $userId');
    }
    final userData = userSnap.data()!;
    final String? realFamilyId =
        userData['family_id'] as String? ?? userData['familyId'] as String?;
    logger.i(
      'Resolved mock transaction seed context. userId=$userId '
      'familyId=$realFamilyId role=${userData['role']} '
      'memberStatus=${userData['member_status']}',
    );

    // ── Bước 2: Ghi từng transaction ─────────────────────────────────────
    int success = 0;
    int skipped = 0;
    final List<String> failed = [];

    for (final tx in mockTransactions) {
      final realTx = tx.copyWith(userId: userId, familyId: realFamilyId);
      final ref = db
          .collection('users')
          .doc(userId)
          .collection('transactions')
          .doc(realTx.transactionId);

      try {
        final payload = _toFirestoreMap(realTx);

        final existing = await ref.get();
        if (existing.exists) {
          if (!forceOverwrite) {
            logger.d('Skip existing mock transaction ${realTx.transactionId}.');
            skipped++;
            continue;
          } else {
            // Rule: Khong duoc doi created_at trong update
            // Do đó phải giữ nguyên created_at cũ để bypass security rules
            final oldData = existing.data();
            if (oldData != null && oldData.containsKey('created_at')) {
              payload['created_at'] = oldData['created_at'];
            }
          }
        }

        await ref.set(payload); // set() overwrites
        logger.d(
          'Seeded mock transaction ${realTx.transactionId}. '
          'type=${realTx.type} amountMinor=${realTx.amountMinor} '
          'date=${realTx.dateTs.toIso8601String()}',
        );
        success++;
      } catch (error, stackTrace) {
        failed.add(_formatSeedFailure(realTx, error));
        logger.e(
          'Failed to seed mock transaction ${realTx.transactionId}.',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    logger.i(
      'Finished seeding mock transactions. userId=$userId '
      'success=$success skipped=$skipped failed=${failed.length}',
    );
    return SeedResult(success: success, skipped: skipped, failed: failed);
  }

  static Map<String, dynamic> _toFirestoreMap(TransactionModel tx) {
    // Chỉ gửi đúng các trường được rule cho phép.
    // Trường optional null được gửi tường minh để rule không báo thiếu.
    // ocr_meta keys chỉ được là ['used', 'confidence'] theo isValidOcrMeta.
    final map = <String, dynamic>{
      'transaction_id': tx.transactionId,
      'user_id': tx.userId,
      'family_id': tx.familyId, // phải khớp user's family_id
      'type': tx.type, // 'expense' | 'income'
      'amount_minor': tx.amountMinor, // int > 0
      'currency': tx.currency, // 'VND'
      'category_key': tx.categoryKey,
      'category_label': tx.categoryLabel,
      'date_ts': Timestamp.fromDate(tx.dateTs),
      'created_at': Timestamp.fromDate(tx.createdAt ?? tx.dateTs),
      'updated_at': Timestamp.fromDate(tx.updatedAt ?? tx.dateTs),
      'ocr_meta': {
        'used': tx.ocrUsed ?? false,
        'confidence': tx.ocrConfidence, // null | double — rule cho phép
      },
    };

    // Optional fields: chỉ thêm nếu không null để tránh rule reject
    if (tx.categoryIcon != null) map['category_icon'] = tx.categoryIcon;
    if (tx.note != null) map['note'] = tx.note;
    if (tx.source != null) map['source'] = tx.source;
    if (tx.merchantName != null) map['merchant_name'] = tx.merchantName;
    // evidence_image bị bỏ qua theo yêu cầu

    return map;
  }

  static String _formatSeedFailure(TransactionModel tx, Object error) {
    if (error is FirebaseException) {
      return '${tx.transactionId}: Firebase ${error.code} - ${error.message ?? error.plugin}';
    }
    return '${tx.transactionId}: $error';
  }
}

class SeedResult {
  const SeedResult({
    required this.success,
    required this.skipped,
    required this.failed,
  });

  final int success;
  final int skipped;
  final List<String> failed;

  bool get hasErrors => failed.isNotEmpty;

  @override
  String toString() =>
      'SeedResult(success: $success, skipped: $skipped, failed: ${failed.length})';
}
