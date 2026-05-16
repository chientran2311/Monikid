import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();

  static String get baseUrl {
    final url = dotenv.env['API_BASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('Missing API_BASE_URL in .env');
    }
    return url;
  }

  static String get supabaseUrl {
    final url = dotenv.env['SUPABASE_URL'];
    if (url == null || url.isEmpty) throw Exception('Missing SUPABASE_URL');
    return url;
  }

  static String get supabaseAnonKey {
    final key = dotenv.env['SUPABASE_ANON_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception('Missing SUPABASE_ANON_KEY');
    }
    return key;
  }

  static String get cloudinaryCloudName {
    final directCloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
    if (directCloudName != null && directCloudName.isNotEmpty) {
      return directCloudName;
    }

    final cloudinaryUrl = dotenv.env['CLOUDINARY_URL'];
    if (cloudinaryUrl != null && cloudinaryUrl.isNotEmpty) {
      final match = RegExp(
        r'cloudinary://[^:]+:[^@]+@([^/?#\s]+)',
      ).firstMatch(cloudinaryUrl.trim());
      final matchedCloudName = match?.group(1)?.trim();
      if (matchedCloudName != null && matchedCloudName.isNotEmpty) {
        return matchedCloudName;
      }

      final uri = Uri.tryParse(cloudinaryUrl.trim());
      final host = uri?.host.trim();
      if (host != null && host.isNotEmpty) {
        return host;
      }
    }

    throw Exception('Missing CLOUDINARY_CLOUD_NAME or CLOUDINARY_URL in .env');
  }

  static String get cloudinaryUnsignedUploadPreset {
    final preset = dotenv.env['CLOUDINARY_UNSIGNED_UPLOAD_PRESET'];
    if (preset == null || preset.isEmpty) {
      throw Exception('Missing CLOUDINARY_UNSIGNED_UPLOAD_PRESET in .env');
    }
    return preset;
  }

  static String get cloudinaryProfileAvatarUploadPreset {
    final preset = dotenv.env['CLOUDINARY_PROFILE_AVATAR_UPLOAD_PRESET'];
    if (preset == null || preset.isEmpty) {
      throw Exception('Missing CLOUDINARY_PROFILE_AVATAR_UPLOAD_PRESET in .env');
    }
    return preset;
  }

  static String get mockBankApiKey =>
      dotenv.env['MOCK_BANK_API_KEY'] ?? 'monikid-mockbank-secret-2024';
}
