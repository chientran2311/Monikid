import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._(); // Private constructor để không khởi tạo

  // --- API URL (Render) ---
  static String get baseUrl {
    final url = dotenv.env['API_BASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('Missing API_BASE_URL in .env');
    }
    return url;
  }

  // --- Supabase ---
  static String get supabaseUrl {
    final url = dotenv.env['SUPABASE_URL'];
    if (url == null || url.isEmpty) throw Exception('Missing SUPABASE_URL');
    return url;
  }

  static String get supabaseAnonKey {
    final key = dotenv.env['SUPABASE_ANON_KEY'];
    if (key == null || key.isEmpty) throw Exception('Missing SUPABASE_ANON_KEY');
    return key;
  }

  // --- Mock Bank (Có thể đưa vào env nếu cần đổi IP động) ---
  static String get mockBankApiKey => dotenv.env['MOCK_BANK_API_KEY'] ?? 'monikid-mockbank-secret-2024';
}