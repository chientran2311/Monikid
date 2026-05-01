import 'dart:math';

class FamilyCodeUtil {
  FamilyCodeUtil._();

  static String generate() {
    final random = Random.secure();
    return List.generate(6, (_) => random.nextInt(10)).join();
  }
}
