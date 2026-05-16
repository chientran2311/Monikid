import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_model.freezed.dart';
part 'family_model.g.dart';

@freezed
abstract class FamilyModel with _$FamilyModel {
  const factory FamilyModel({
    required String familyId,
    required String parentId,
    required String parentName,
    required String inviteCode,
    required DateTime inviteCodeExpiresAt,
    required int childCount,
    required String status,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _FamilyModel;

  factory FamilyModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyModelFromJson(json);

  factory FamilyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final now = DateTime.now();

    return FamilyModel(
      familyId: doc.id,
      parentId: data['parent_id'] as String? ?? '',
      parentName: data['parent_name'] as String? ?? '',
      inviteCode: data['invite_code'] as String? ?? '',
      inviteCodeExpiresAt: data['invite_code_expires_at'] != null
          ? (data['invite_code_expires_at'] as Timestamp).toDate()
          : now.add(const Duration(days: 365)),
      childCount: (data['child_count'] as num?)?.toInt() ?? 0,
      status: data['status'] as String? ?? 'active',
      createdAt: data['created_at'] != null
          ? (data['created_at'] as Timestamp).toDate()
          : now,
      updatedAt: data['updated_at'] != null
          ? (data['updated_at'] as Timestamp).toDate()
          : null,
    );
  }
}
