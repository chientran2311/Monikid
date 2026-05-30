import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    required String uid,
    required String email,
    required String displayName,
    String? photoUrl,
    required String role,
    String? familyId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AccountModel;

  const AccountModel._();

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

  factory AccountModel.fromFirestore(Map<String, dynamic> json) {
    final rawRole = (json['role'] as String?)?.trim().toLowerCase() ?? '';
    final normalizedRole = rawRole == 'student' ? 'child' : rawRole;

    return AccountModel(
      uid: (json['uid'] as String?)?.trim() ?? '',
      email: (json['email'] as String?)?.trim() ?? '',
      displayName: (json['display_name'] as String?)?.trim() ?? '',
      photoUrl: json['photo_url'] as String?,
      role: normalizedRole,
      familyId: json['family_id'] as String?,
      createdAt: _parseTimestamp(json['created_at']) ?? DateTime.now(),
      updatedAt: _parseTimestamp(json['updated_at']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'role': role,
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
