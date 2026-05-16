import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';

enum NotificationType {
  overspend80,
  overspend100,
  weeklyOverspend;

  String toFirestoreValue() => name;
}

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String notificationId,
    required String recipientId,
    required String studentId,
    required NotificationType type,
    required String title,
    required String message,
    required DateTime createdAt,
    @Default(false) bool isRead,
  }) = _NotificationModel;

  const NotificationModel._();

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      notificationId: doc.id,
      recipientId: (d['recipient_id'] as String?) ?? '',
      studentId: (d['student_id'] as String?) ?? '',
      type: NotificationType.values.byName(
        (d['type'] as String?) ?? 'overspend80',
      ),
      title: (d['title'] as String?) ?? '',
      message: (d['message'] as String?) ?? '',
      createdAt: ((d['created_at'] as Timestamp?)?.toDate()) ?? DateTime.now(),
      isRead: (d['is_read'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'notification_id': notificationId,
        'recipient_id': recipientId,
        'student_id': studentId,
        'type': type.toFirestoreValue(),
        'title': title,
        'message': message,
        'created_at': Timestamp.fromDate(createdAt),
        'is_read': isRead,
      };
}
