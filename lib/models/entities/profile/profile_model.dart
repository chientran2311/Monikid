import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    String? avatarUrl,
    required String fullName,
    required String email,
    @Default('') String phone,
    @Default('') String dob,
    @Default('') String gender,
    required String role,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  factory ProfileModel.fromFirestore(Map<String, dynamic> json) {
    final fullName = (json['full_name'] as String? ?? json['display_name'] as String?)?.trim() ?? '';
    final avatarUrl = json['avatar_url'] as String? ?? json['photo_url'] as String?;
    return ProfileModel(
      id: (json['uid'] as String?)?.trim() ?? '',
      avatarUrl: avatarUrl,
      fullName: fullName,
      email: (json['email'] as String?)?.trim() ?? '',
      phone: (json['phone'] as String?) ?? '',
      dob: (json['dob'] as String?) ?? '',
      gender: (json['gender'] as String?) ?? '',
      role: (json['role'] as String?)?.trim() ?? '',
    );
  }
}
