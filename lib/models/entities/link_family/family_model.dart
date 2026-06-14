import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_model.freezed.dart';
part 'family_model.g.dart';

@freezed
abstract class FamilyModel with _$FamilyModel {
  const factory FamilyModel({
    required String familyId,
    required String ownerUid,
    required String inviteCode,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _FamilyModel;

  factory FamilyModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyModelFromJson(json);

  factory FamilyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final now = DateTime.now();

    // ownerUid derived from embedded members array — no longer stored as top-level field
    final members = (data['members'] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>();
    final ownerMember = members.firstWhere(
      (m) => m['role'] == 'owner',
      orElse: () => <String, dynamic>{},
    );

    return FamilyModel(
      familyId: doc.id,
      ownerUid: ownerMember['user_id'] as String? ?? '',
      inviteCode: data['invite_code'] as String? ?? '',
      createdAt: data['created_at'] != null
          ? (data['created_at'] as Timestamp).toDate()
          : now,
      updatedAt: data['updated_at'] != null
          ? (data['updated_at'] as Timestamp).toDate()
          : null,
    );
  }
}
