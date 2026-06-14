import 'dart:math';

class FamilyCodeUtil {
  FamilyCodeUtil._();

  static const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  static String generate() {
    final random = Random.secure();
    return List.generate(6, (_) => _chars[random.nextInt(_chars.length)]).join();
  }
}
