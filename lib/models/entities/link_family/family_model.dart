import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_model.freezed.dart';
part 'family_model.g.dart';

@freezed
abstract class FamilyModel with _$FamilyModel {
  const factory FamilyModel({
    required String familyId,
    required String inviteCode, // '' if code not yet created
    required String hostDisplayName, // denormalized host name (child reads)
    String? hostAvatarUrl, // denormalized host avatar (child reads)
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
      inviteCode: data['invite_code'] as String? ?? '',
      hostDisplayName: data['host_display_name'] as String? ?? '',
      hostAvatarUrl: data['host_avatar_url'] as String?,
      createdAt: data['created_at'] != null
          ? (data['created_at'] as Timestamp).toDate()
          : now,
      updatedAt: data['updated_at'] != null
          ? (data['updated_at'] as Timestamp).toDate()
          : null,
    );
  }
}
