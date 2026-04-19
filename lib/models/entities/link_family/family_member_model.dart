import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_member_model.freezed.dart';
part 'family_member_model.g.dart';
@freezed
abstract class FamilyMemberModel with _$FamilyMemberModel {
  const factory FamilyMemberModel({
    required String uid,
    required String familyId,
    required String role, // parent, child
    required String displayName,
    String? avatarUrl,
    required DateTime joinedAt,
    required String status, // active, removed
  }) = _FamilyMemberModel;

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberModelFromJson(json);
}