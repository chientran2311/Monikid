import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/foundation.dart';

/// Dùng [compute] để chạy bcrypt trong Isolate, tránh block UI thread.
Future<String> bcryptPin(String text) async {
  return await compute(_bcryptIsolate, text);
}

String _bcryptIsolate(String text) {
  final salt = BCrypt.gensalt();
  return BCrypt.hashpw(text, salt);
}

/// Kiểm tra PIN plain text với hash đã lưu. Trả về true nếu khớp.
Future<bool> checkPinCode(String pinCodePlainText, String pinCodeHash) async {
  return await compute(_checkPinCodeIsolate, {
    'plain': pinCodePlainText,
    'hash': pinCodeHash,
  });
}

bool _checkPinCodeIsolate(Map<String, String> data) {
  return BCrypt.checkpw(data['plain']!, data['hash']!);
}
