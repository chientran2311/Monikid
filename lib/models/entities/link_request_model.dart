import 'package:cloud_firestore/cloud_firestore.dart';

enum LinkStatus { pending, accepted, expired }

class LinkRequestModel {
  final String requestId;
  final String code;
  final String studentId;
  final DateTime expiresAt;
  final LinkStatus status;

  const LinkRequestModel({
    required this.requestId,
    required this.code,
    required this.studentId,
    required this.expiresAt,
    required this.status,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isValid => status == LinkStatus.pending && !isExpired;

  factory LinkRequestModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return LinkRequestModel(
      requestId: doc.id,
      code: d['code'] ?? '',
      studentId: d['studentId'] ?? '',
      expiresAt: (d['expiresAt'] as Timestamp).toDate(),
      status: LinkStatus.values.firstWhere(
        (e) => e.name == d['status'],
        orElse: () => LinkStatus.expired,
      ),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'code': code,
    'studentId': studentId,
    'expiresAt': Timestamp.fromDate(expiresAt),
    'status': status.name,
  };
}
