import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/app_constants.dart';

/// Supabase client singleton for database operations.
///
/// Initialize in main.dart before runApp:
/// ```dart
/// await SupabaseConfig.initialize();
/// ```
abstract class SupabaseConfig {
  SupabaseConfig._();

  /// Initialize Supabase client
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
  }

  /// Get the Supabase client instance
  static SupabaseClient get client => Supabase.instance.client;

  /// Get the current authenticated user
  static User? get currentUser => client.auth.currentUser;

  /// Get the current session
  static Session? get currentSession => client.auth.currentSession;

  /// Check if user is authenticated
  static bool get isAuthenticated => currentUser != null;

  /// Sign out the current user
  static Future<void> signOut() async {
    await client.auth.signOut();
  }
}

/// Extension for easy access to Supabase tables
extension SupabaseTableExtension on SupabaseClient {
  // Auth & Users
  SupabaseQueryBuilder get profiles => from('profiles');
  SupabaseQueryBuilder get families => from('families');
  SupabaseQueryBuilder get familyMembers => from('family_members');

  // Wallets & Bank
  SupabaseQueryBuilder get wallets => from('wallets');
  SupabaseQueryBuilder get mockBankAccounts => from('mock_bank_accounts');

  // Transactions
  SupabaseQueryBuilder get transactions => from('transactions');
  SupabaseQueryBuilder get moneyRequests => from('money_requests');
  SupabaseQueryBuilder get allowanceSchedules => from('allowance_schedules');

  // Features
  SupabaseQueryBuilder get receipts => from('receipts');
  SupabaseQueryBuilder get locationLogs => from('location_logs');
  SupabaseQueryBuilder get messages => from('messages');
}
