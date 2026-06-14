import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String email,
    required String displayName,
    String? avatarUrl,
    required String role,
    int? monthlyLimit,
    String? familyId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserModel;

  const UserModel._();

  bool get isParent => role == 'parent';
  bool get isChild => role == 'child';
  bool get isValid => validationIssues.isEmpty;

  List<String> get validationIssues {
    final issues = <String>[];

    if (uid.trim().isEmpty) {
      issues.add('uid is empty');
    }
    if (email.trim().isEmpty) {
      issues.add('email is empty');
    }
    if (displayName.trim().isEmpty) {
      issues.add('display_name is empty');
    }
    if (role != 'parent' && role != 'child') {
      issues.add('role must be parent or child');
    }

    return issues;
  }

  factory UserModel.fromFirestore(Map<String, dynamic> json) {
    final rawRole = (json['role'] as String?)?.trim().toLowerCase() ?? '';
    final normalizedRole = rawRole == 'student' ? 'child' : rawRole;

    return UserModel(
      uid: (json['user_id'] as String?)?.trim() ?? '',
      email: (json['email'] as String?)?.trim() ?? '',
      displayName: (json['display_name'] as String?)?.trim() ?? '',
      avatarUrl: (json['avatar_url'] as String?) ?? (json['photo_url'] as String?),
      role: normalizedRole,
      monthlyLimit: json['monthly_limit'] as int?,
      familyId: json['family_id'] as String?,
      createdAt: _parseTimestamp(json['created_at']) ?? DateTime.now(),
      updatedAt: _parseTimestamp(json['updated_at']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'user_id': uid,
      'email': email,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'role': role,
      'monthly_limit': monthlyLimit,
      'family_id': familyId,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}

DateTime? _parseTimestamp(Object? value) {
  if (value is Timestamp) {
    return value.toDate();
  }
  if (value is DateTime) {
    return value;
  }
  return null;
}
