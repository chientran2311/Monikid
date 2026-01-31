// class AppUser {
//     final String id;
//     final String email;
//     final String? full_name;
//     final String? avatar_url;
//     final String role;
    
//     AppUser({
//         required this.id,
//         required this.email,
//         this.full_name,
//         this.avatar_url,
//         required this.role,
//     });

//     factory AppUser.fromSupabase(Map<String,dynamic> data){
//         return AppUser(
//             id: data['id'],
//             email: data['email'],
//             full_name: data['full_name'],
//             avatar_url: data['avatar_url'],
//             role: data['role'],
//         );
//     }
// }    normal model

// use freezed model

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'app_user.freezed.dart';
// part  'app_user.g.dart';

// @freezed
// class AppUser with _$AppUser{
//     const AppUser._();

//     const factory AppUser({
//         required String id,
//         required String email,
//         @JsonKey(name: 'full_name') String ? fullname,
//         String? phone,
//         @Default('parent') String role,
//         @JsonKey(name: 'avatar_url') String ? avatarUrl,

//     }) = _AppUser;

//     factory AppUser.fromJson(Map<String,dynamic> json) => _$AppUserFromJson(json);

// }

class AppUser {
  final String id;
  final String email;
  final String? fullname;
  final String? phone;
  final String role;
  final String? avatarUrl;

  AppUser({
    required this.id,
    required this.email,
    this.fullname,
    this.phone,
    this.role = 'parent',
    this.avatarUrl,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      fullname: json['full_name'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String? ?? 'parent',
      avatarUrl: json['avatar_url'] as String?,
    );
  }
}