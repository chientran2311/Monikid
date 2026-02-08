import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_model.freezed.dart';
part 'family_model.g.dart';

@freezed
abstract class FamilyMemberWallet with _$FamilyMemberWallet {
  const factory FamilyMemberWallet({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    // Đổi fullName thành optional hoặc có Default để tránh crash khi join profiles lỗi
    @JsonKey(name: 'full_name') @Default('Thành viên') String fullName, 
    String? avatarUrl,
    @Default('child') String role,
    @JsonKey(name: 'wallet_id') String? walletId,
    @Default(0.0) double balance, // Dùng Default thay vì double? để UI dễ hiển thị
  }) = _FamilyMemberWallet;

  factory FamilyMemberWallet.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberWalletFromJson(json);
}