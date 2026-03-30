import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response.freezed.dart';

@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({required User user, String? role}) =
      _AuthResponse;
}
