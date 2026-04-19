import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';

const _defaultChildSpendingAlert = SpendingAlertModel(
  enabled: true,
  dailyLimitMinor: 100000,
  monthlyLimitMinor: 1500000,
);

@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    required String uid,
    required String email,
    required String displayName,
    String? photoUrl,
    required String role,
    String? familyId,
    required String memberStatus,
    required DateTime createdAt,
    required DateTime updatedAt,
    SpendingAlertModel? spendingAlert,
  }) = _AccountModel;

  const AccountModel._();

  bool get isParent => role == 'parent';
  bool get isChild => role == 'child';
  bool get isActive => memberStatus == 'active';
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
    if (memberStatus != 'active' && memberStatus != 'inactive') {
      issues.add('member_status must be active or inactive');
    }
    if (role == 'child' && spendingAlert == null) {
      issues.add('spending_alert is required for child accounts');
    }

    return issues;
  }

  factory AccountModel.fromFirestore(Map<String, dynamic> json) {
    final rawRole = (json['role'] as String?)?.trim().toLowerCase() ?? '';
    final normalizedRole = rawRole == 'student' ? 'child' : rawRole;
    final spendingAlertJson = json['spending_alert'];
    final memberStatus =
        (json['member_status'] as String?)?.trim().toLowerCase() ?? 'active';

    return AccountModel(
      uid: (json['uid'] as String?)?.trim() ?? '',
      email: (json['email'] as String?)?.trim() ?? '',
      displayName: (json['display_name'] as String?)?.trim() ?? '',
      photoUrl: json['photo_url'] as String?,
      role: normalizedRole,
      familyId: json['family_id'] as String?,
      memberStatus: memberStatus,
      createdAt: _parseTimestamp(json['created_at']) ?? DateTime.now(),
      updatedAt: _parseTimestamp(json['updated_at']) ?? DateTime.now(),
      spendingAlert: normalizedRole == 'child'
          ? spendingAlertJson is Map<String, dynamic>
              ? SpendingAlertModel.fromFirestore(spendingAlertJson)
              : _defaultChildSpendingAlert
          : null,
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
      'member_status': memberStatus,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
      if (role == 'child' && spendingAlert != null)
        'spending_alert': spendingAlert!.toFirestore(),
    };
  }
}

@freezed
abstract class SpendingAlertModel with _$SpendingAlertModel {
  const factory SpendingAlertModel({
    required bool enabled,
    required int dailyLimitMinor,
    required int monthlyLimitMinor,
  }) = _SpendingAlertModel;

  const SpendingAlertModel._();

  factory SpendingAlertModel.fromFirestore(Map<String, dynamic> json) {
    return SpendingAlertModel(
      enabled: json['enabled'] as bool? ?? true,
      dailyLimitMinor: (json['daily_limit_minor'] as num?)?.toInt() ?? 100000,
      monthlyLimitMinor:
          (json['monthly_limit_minor'] as num?)?.toInt() ?? 1500000,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'enabled': enabled,
      'daily_limit_minor': dailyLimitMinor,
      'monthly_limit_minor': monthlyLimitMinor,
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
