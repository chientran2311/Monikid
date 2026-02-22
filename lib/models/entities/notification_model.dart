import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String notificationId;
  final String recipientId;
  final String studentId;
  final String? transactionId;
  final String message;
  final DateTime createdAt;
  final bool isRead;

  const NotificationModel({
    required this.notificationId,
    required this.recipientId,
    required this.studentId,
    this.transactionId,
    required this.message,
    required this.createdAt,
    required this.isRead,
  });

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      notificationId: doc.id,
      recipientId: d['recipientId'] ?? '',
      studentId: d['studentId'] ?? '',
      transactionId: d['transactionId'],
      message: d['message'] ?? '',
      createdAt: (d['createdAt'] as Timestamp).toDate(),
      isRead: d['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'recipientId': recipientId,
    'studentId': studentId,
    'transactionId': transactionId,
    'message': message,
    'createdAt': Timestamp.fromDate(createdAt),
    'isRead': isRead,
  };

  NotificationModel markAsRead() => NotificationModel(
    notificationId: notificationId,
    recipientId: recipientId,
    studentId: studentId,
    transactionId: transactionId,
    message: message,
    createdAt: createdAt,
    isRead: true,
  );
}
