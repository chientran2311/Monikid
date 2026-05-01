import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_member_model.freezed.dart';
part 'family_member_model.g.dart';

@freezed
abstract class FamilyMemberModel with _$FamilyMemberModel {
  const factory FamilyMemberModel({
    required String uid,
    required String familyId,
    required String role,
    required String displayName,
    String? avatarUrl,
    required DateTime joinedAt,
    required String status,
  }) = _FamilyMemberModel;

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberModelFromJson(json);

  factory FamilyMemberModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FamilyMemberModel(
      uid: data['uid'] as String? ?? doc.id,
      familyId: data['family_id'] as String? ?? '',
      role: data['role'] as String? ?? 'child',
      displayName: data['display_name'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
      joinedAt: data['joined_at'] != null
          ? (data['joined_at'] as Timestamp).toDate()
          : DateTime.now(),
      status: data['status'] as String? ?? 'active',
    );
  }
}
