import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/entities/notification_model.dart';

part 'notification_repository.g.dart';

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return getIt<NotificationRepository>();
}

abstract class NotificationRepository {
  Stream<List<NotificationModel>> streamNotifications(String uid);
  Future<void> writeNotification(NotificationModel model);
  Future<void> markRead(String uid, String notifId);
  Future<void> markAllRead(String uid);
  Future<void> deleteNotification(String uid, String notifId);
  Future<bool> checkDedup(String uid, NotificationType type, String monthKey);
  Future<void> writeDedup(String uid, NotificationType type, String monthKey);
}

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(this._firestore, this._logger);

  final FirebaseFirestore _firestore;
  final Logger _logger;

  CollectionReference<Map<String, dynamic>> _notifCol(String uid) =>
      _firestore.collection('users').doc(uid).collection('notifications');

  DocumentReference<Map<String, dynamic>> _dedupDoc(
    String uid,
    NotificationType type,
    String monthKey,
  ) =>
      _firestore
          .collection('users')
          .doc(uid)
          .collection('notification_dedup')
          .doc('${type.toFirestoreValue()}_$monthKey');

  @override
  Stream<List<NotificationModel>> streamNotifications(String uid) {
    return _notifCol(uid)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(
          (snap) => snap.docs
              .map((doc) => NotificationModel.fromFirestore(doc))
              .toList(growable: false),
        );
  }

  @override
  Future<void> writeNotification(NotificationModel model) async {
    try {
      await _notifCol(model.recipientId)
          .doc(model.notificationId)
          .set(model.toFirestore());
      _logger.i(
        'Notification written. notifId=${model.notificationId} '
        'recipientId=${model.recipientId} type=${model.type.name}',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to write notification.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> markRead(String uid, String notifId) async {
    try {
      await _notifCol(uid).doc(notifId).update({'is_read': true});
      _logger.i('Notification marked read. uid=$uid notifId=$notifId');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to mark notification read.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> markAllRead(String uid) async {
    try {
      final snap = await _notifCol(uid)
          .where('is_read', isEqualTo: false)
          .get();
      if (snap.docs.isEmpty) return;

      final batch = _firestore.batch();
      for (final doc in snap.docs) {
        batch.update(doc.reference, {'is_read': true});
      }
      await batch.commit();
      _logger.i(
        'All notifications marked read. uid=$uid count=${snap.docs.length}',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to mark all notifications read.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> deleteNotification(String uid, String notifId) async {
    try {
      await _notifCol(uid).doc(notifId).delete();
      _logger.i('Notification deleted. uid=$uid notifId=$notifId');
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to delete notification.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<bool> checkDedup(
    String uid,
    NotificationType type,
    String monthKey,
  ) async {
    try {
      final doc = await _dedupDoc(uid, type, monthKey).get();
      return doc.exists;
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to check dedup. uid=$uid type=${type.name} monthKey=$monthKey',
        error: error,
        stackTrace: stackTrace,
      );
      // Fail-open: allow the write to proceed on transient errors
      return false;
    }
  }

  @override
  Future<void> writeDedup(
    String uid,
    NotificationType type,
    String monthKey,
  ) async {
    try {
      await _dedupDoc(uid, type, monthKey).set({
        'written_at': FieldValue.serverTimestamp(),
        'type': type.toFirestoreValue(),
        'month_key': monthKey,
      });
      _logger.i(
        'Dedup written. uid=$uid type=${type.name} monthKey=$monthKey',
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to write dedup doc.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
