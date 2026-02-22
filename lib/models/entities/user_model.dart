import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole { student, parent }

/// UserModel — map đúng với Firestore schema trong auth_repository_impl.dart
/// Fields: uid, email, full_name, phone, role, avatar_url, created_at, wallet, bank_account
class UserModel {
  final String userId;
  final String email;
  final String fullName;
  final String phone;
  final UserRole role;
  final String? avatarUrl;
  final String? linkedParentId;
  final String? linkedStudentId;
  final double? monthlyBudget;
  final double? walletBalance;
  final String? walletCurrency;
  final bool? walletLocked;
  final DateTime createdAt;

  const UserModel({
    required this.userId,
    required this.email,
    required this.fullName,
    this.phone = '',
    required this.role,
    this.avatarUrl,
    this.linkedParentId,
    this.linkedStudentId,
    this.monthlyBudget,
    this.walletBalance,
    this.walletCurrency,
    this.walletLocked,
    required this.createdAt,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    final wallet = d['wallet'] as Map<String, dynamic>?;

    return UserModel(
      userId: doc.id,
      email: d['email'] ?? '',
      fullName: d['full_name'] ?? d['displayName'] ?? '',
      phone: d['phone'] ?? '',
      role: d['role'] == 'parent' ? UserRole.parent : UserRole.student,
      avatarUrl: d['avatar_url'],
      linkedParentId: d['linkedParentId'],
      linkedStudentId: d['linkedStudentId'],
      monthlyBudget: (d['monthlyBudget'] as num?)?.toDouble(),
      walletBalance: (wallet?['balance'] as num?)?.toDouble(),
      walletCurrency: wallet?['currency'],
      walletLocked: wallet?['is_locked'],
      createdAt: d['created_at'] is Timestamp
          ? (d['created_at'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'email': email,
    'full_name': fullName,
    'phone': phone,
    'role': role.name,
    'avatar_url': avatarUrl,
    'linkedParentId': linkedParentId,
    'linkedStudentId': linkedStudentId,
    'monthlyBudget': monthlyBudget,
    'wallet': {
      'balance': walletBalance,
      'currency': walletCurrency ?? 'VND',
      'is_locked': walletLocked ?? false,
    },
    'created_at': Timestamp.fromDate(createdAt),
  };

  UserModel copyWith({
    String? fullName,
    String? phone,
    String? avatarUrl,
    String? linkedParentId,
    String? linkedStudentId,
    double? monthlyBudget,
    double? walletBalance,
  }) => UserModel(
    userId: userId,
    email: email,
    role: role,
    createdAt: createdAt,
    fullName: fullName ?? this.fullName,
    phone: phone ?? this.phone,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    linkedParentId: linkedParentId ?? this.linkedParentId,
    linkedStudentId: linkedStudentId ?? this.linkedStudentId,
    monthlyBudget: monthlyBudget ?? this.monthlyBudget,
    walletBalance: walletBalance ?? this.walletBalance,
    walletCurrency: walletCurrency,
    walletLocked: walletLocked,
  );

  bool get isStudent => role == UserRole.student;
  bool get isParent => role == UserRole.parent;
  bool get isLinked => linkedParentId != null || linkedStudentId != null;
}
