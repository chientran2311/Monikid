import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_member_model.freezed.dart';
part 'family_member_model.g.dart';

@freezed
abstract class FamilyMemberModel with _$FamilyMemberModel {
  const factory FamilyMemberModel({
    required String uid,
    @Default('member') String role,
    @Default('child') String userRole,
    @Default('') String displayName,
    String? avatarUrl,
  }) = _FamilyMemberModel;

  const FamilyMemberModel._();

  factory FamilyMemberModel.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberModelFromJson(json);

  factory FamilyMemberModel.fromMap(Map<String, dynamic> map) {
    return FamilyMemberModel(
      uid: map['user_id'] as String? ?? '',
      role: map['role'] as String? ?? 'member',
      userRole: map['user_role'] as String? ?? 'child',
      displayName: map['display_name'] as String? ?? '',
      avatarUrl: map['avatar_url'] as String?,
    );
  }

  Map<String, dynamic> toFirestoreMap() => {
        'user_id': uid,
        'role': role,
        'user_role': userRole,
        'display_name': displayName,
        'avatar_url': avatarUrl,
      };
}
