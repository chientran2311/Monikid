import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import 'package:monikid/models/entities/notification_model.dart';
import 'package:monikid/repositories/notification/notification_repository.dart';

class NotificationService {
  NotificationService(this._notifRepo, this._firestore, this._logger);

  final NotificationRepository _notifRepo;
  final FirebaseFirestore _firestore;
  final Logger _logger;

  static const _uuid = Uuid();

  Future<void> checkAndNotify({
    required String uid,
    required String role,
    required int monthlyLimitMinor,
    required int currentExpenseMinor,
    required String? familyId,
    required String? parentUid,
    required String childDisplayName,
  }) async {
    if (role != 'child') return;

    if (monthlyLimitMinor <= 0) {
      _logger.d('checkAndNotify skipped: no limit set for uid=$uid.');
      return;
    }

    final monthKey = DateFormat('yyyy-MM').format(DateTime.now());

    await _check80Threshold(
      uid: uid,
      monthKey: monthKey,
      monthlyLimitMinor: monthlyLimitMinor,
      currentExpenseMinor: currentExpenseMinor,
      parentUid: parentUid,
      childDisplayName: childDisplayName,
    );

    await _check100Threshold(
      uid: uid,
      monthKey: monthKey,
      monthlyLimitMinor: monthlyLimitMinor,
      currentExpenseMinor: currentExpenseMinor,
      parentUid: parentUid,
      childDisplayName: childDisplayName,
    );

    await _checkWeeklyOverspend(
      uid: uid,
      monthKey: monthKey,
      parentUid: parentUid,
      childDisplayName: childDisplayName,
    );
  }

  Future<void> _check80Threshold({
    required String uid,
    required String monthKey,
    required int monthlyLimitMinor,
    required int currentExpenseMinor,
    required String? parentUid,
    required String childDisplayName,
  }) async {
    if (currentExpenseMinor < monthlyLimitMinor * 0.8) return;
    if (currentExpenseMinor >= monthlyLimitMinor) return;

    final alreadySent = await _notifRepo.checkDedup(
      uid,
      NotificationType.overspend80,
      monthKey,
    );
    if (alreadySent) return;

    final notifId = _uuid.v4();
    final now = DateTime.now();

    await _notifRepo.writeNotification(NotificationModel(
      notificationId: notifId,
      recipientId: uid,
      studentId: uid,
      type: NotificationType.overspend80,
      title: 'Sắp đạt hạn mức chi tiêu',
      message: 'Bạn đã chi tiêu 80% hạn mức tháng này. Hãy kiểm soát chi tiêu!',
      createdAt: now,
    ));
    await _notifRepo.writeDedup(uid, NotificationType.overspend80, monthKey);

    if (parentUid != null) {
      await _notifRepo.writeNotification(NotificationModel(
        notificationId: _uuid.v4(),
        recipientId: parentUid,
        studentId: uid,
        type: NotificationType.overspend80,
        title: 'Con sắp đạt hạn mức chi tiêu',
        message: '$childDisplayName đã chi tiêu 80% hạn mức tháng này.',
        createdAt: now,
      ));
      await _notifRepo.writeDedup(parentUid, NotificationType.overspend80, monthKey);
    }

    _logger.i('overspend80 notification written. uid=$uid monthKey=$monthKey');
  }

  Future<void> _check100Threshold({
    required String uid,
    required String monthKey,
    required int monthlyLimitMinor,
    required int currentExpenseMinor,
    required String? parentUid,
    required String childDisplayName,
  }) async {
    if (currentExpenseMinor < monthlyLimitMinor) return;

    final alreadySent = await _notifRepo.checkDedup(
      uid,
      NotificationType.overspend100,
      monthKey,
    );
    if (alreadySent) return;

    final notifId = _uuid.v4();
    final now = DateTime.now();

    await _notifRepo.writeNotification(NotificationModel(
      notificationId: notifId,
      recipientId: uid,
      studentId: uid,
      type: NotificationType.overspend100,
      title: 'Đã vượt hạn mức chi tiêu',
      message: 'Bạn đã chi tiêu vượt quá hạn mức tháng này!',
      createdAt: now,
    ));
    await _notifRepo.writeDedup(uid, NotificationType.overspend100, monthKey);

    if (parentUid != null) {
      await _notifRepo.writeNotification(NotificationModel(
        notificationId: _uuid.v4(),
        recipientId: parentUid,
        studentId: uid,
        type: NotificationType.overspend100,
        title: 'Con đã vượt hạn mức chi tiêu',
        message: '$childDisplayName đã vượt quá hạn mức chi tiêu tháng này!',
        createdAt: now,
      ));
      await _notifRepo.writeDedup(parentUid, NotificationType.overspend100, monthKey);
    }

    _logger.i('overspend100 notification written. uid=$uid monthKey=$monthKey');
  }

  Future<void> _checkWeeklyOverspend({
    required String uid,
    required String monthKey,
    required String? parentUid,
    required String childDisplayName,
  }) async {
    final alreadySent = await _notifRepo.checkDedup(
      uid,
      NotificationType.weeklyOverspend,
      monthKey,
    );
    if (alreadySent) return;

    final now = DateTime.now();
    final thisWeekStart = now.subtract(Duration(days: now.weekday - 1));
    final thisWeekStartTs = DateTime(
      thisWeekStart.year,
      thisWeekStart.month,
      thisWeekStart.day,
    );
    final lastWeekStart = thisWeekStartTs.subtract(const Duration(days: 7));

    final txCol = _firestore
        .collection('users')
        .doc(uid)
        .collection('transactions');

    try {
      final thisWeekSnap = await txCol
          .where('type', isEqualTo: 'expense')
          .where('date_ts',
              isGreaterThanOrEqualTo: Timestamp.fromDate(thisWeekStartTs))
          .get();
      final thisWeekTotal = thisWeekSnap.docs.fold<int>(
        0,
        (sum, doc) =>
            sum + ((doc.data()['amount_minor'] as num?)?.toInt() ?? 0),
      );

      final lastWeekSnap = await txCol
          .where('type', isEqualTo: 'expense')
          .where('date_ts',
              isGreaterThanOrEqualTo: Timestamp.fromDate(lastWeekStart))
          .where('date_ts',
              isLessThan: Timestamp.fromDate(thisWeekStartTs))
          .get();
      final lastWeekTotal = lastWeekSnap.docs.fold<int>(
        0,
        (sum, doc) =>
            sum + ((doc.data()['amount_minor'] as num?)?.toInt() ?? 0),
      );

      _logger.d(
        'weeklyOverspend check: uid=$uid '
        'thisWeek=$thisWeekTotal lastWeek=$lastWeekTotal',
      );

      if (lastWeekTotal <= 0) return;
      if (thisWeekTotal <= lastWeekTotal * 1.3) return;

      final notifId = _uuid.v4();

      await _notifRepo.writeNotification(NotificationModel(
        notificationId: notifId,
        recipientId: uid,
        studentId: uid,
        type: NotificationType.weeklyOverspend,
        title: 'Chi tiêu tuần tăng bất thường',
        message: 'Chi tiêu tuần này của bạn cao hơn 30% so với tuần trước.',
        createdAt: now,
      ));
      await _notifRepo.writeDedup(uid, NotificationType.weeklyOverspend, monthKey);

      if (parentUid != null) {
        await _notifRepo.writeNotification(NotificationModel(
          notificationId: _uuid.v4(),
          recipientId: parentUid,
          studentId: uid,
          type: NotificationType.weeklyOverspend,
          title: 'Chi tiêu tuần của con tăng bất thường',
          message:
              'Chi tiêu tuần này của $childDisplayName cao hơn 30% so với tuần trước.',
          createdAt: now,
        ));
        await _notifRepo.writeDedup(parentUid, NotificationType.weeklyOverspend, monthKey);
      }

      _logger.i(
        'weeklyOverspend notification written. uid=$uid monthKey=$monthKey',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Weekly overspend check failed — skipping.',
        error: error,
        stackTrace: stackTrace,
      );
      // Non-fatal: weekly check failure must not crash home tab init.
    }
  }
}
