import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_member_model.freezed.dart';
part 'family_member_model.g.dart';

@freezed
abstract class FamilyMemberModel with _$FamilyMemberModel {
  const factory FamilyMemberModel({
    required String uid,
    @Default('member') String familyRole, // 'host' | 'member'
    @Default('child') String userRole, // 'parent' | 'child'
    @Default('') String displayName, // runtime-enriched (parent only)
    String? avatarUrl, // runtime-enriched (parent only)
  }) = _FamilyMemberModel;

  const FamilyMemberModel._();

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberModelFromJson(json);

  /// Builds a lean member from the embedded families.members array.
  /// display_name/avatar_url are NOT stored in the array — they are enriched
  /// at runtime from users/{uid} for the parent app only.
  factory FamilyMemberModel.fromMap(Map<String, dynamic> map) {
    return FamilyMemberModel(
      uid: map['user_id'] as String? ?? '',
      familyRole: map['family_role'] as String? ?? 'member',
      userRole: map['user_role'] as String? ?? 'child',
    );
  }

  Map<String, dynamic> toFirestoreMap() => {
        'user_id': uid,
        'family_role': familyRole,
        'user_role': userRole,
      };

  bool get isHost => familyRole == 'host';
  bool get isChild => userRole == 'child';
}
