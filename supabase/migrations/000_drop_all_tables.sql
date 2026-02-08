-- ============================================
-- DROP ALL TABLES AND RECREATE DATABASE
-- ⚠️ WARNING: This will DELETE ALL DATA!
-- Only run this if you want to completely reset the database
-- ============================================

-- Step 1: Drop all triggers first
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
DROP TRIGGER IF EXISTS on_profile_created ON profiles;
DROP TRIGGER IF EXISTS update_profiles_updated_at ON profiles;
DROP TRIGGER IF EXISTS update_wallets_updated_at ON wallets;
DROP TRIGGER IF EXISTS update_mock_bank_accounts_updated_at ON mock_bank_accounts;

-- Step 2: Drop all functions
DROP FUNCTION IF EXISTS handle_new_user() CASCADE;
DROP FUNCTION IF EXISTS initialize_user_wallet() CASCADE;
DROP FUNCTION IF EXISTS update_updated_at_column() CASCADE;
DROP FUNCTION IF EXISTS deposit_from_bank(UUID, NUMERIC, TEXT) CASCADE;
DROP FUNCTION IF EXISTS withdraw_to_bank(UUID, NUMERIC, TEXT) CASCADE;
DROP FUNCTION IF EXISTS transfer_between_wallets(UUID, UUID, NUMERIC, TEXT) CASCADE;

-- Step 3: Drop all tables in correct order (respect foreign keys)
-- Drop tables that depend on others first
DROP TABLE IF EXISTS messages CASCADE;
DROP TABLE IF EXISTS location_logs CASCADE;
DROP TABLE IF EXISTS receipts CASCADE;
DROP TABLE IF EXISTS allowance_schedules CASCADE;
DROP TABLE IF EXISTS money_requests CASCADE;
DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS mock_bank_accounts CASCADE;
DROP TABLE IF EXISTS wallets CASCADE;
DROP TABLE IF EXISTS family_members CASCADE;
DROP TABLE IF EXISTS families CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;

-- Step 4: Drop indexes (if any remain)
DROP INDEX IF EXISTS idx_families_invite_code;
DROP INDEX IF EXISTS idx_family_members_family_id;
DROP INDEX IF EXISTS idx_family_members_user_id;
DROP INDEX IF EXISTS idx_wallets_family_id;
DROP INDEX IF EXISTS idx_mock_bank_accounts_user_id;
DROP INDEX IF EXISTS idx_mock_bank_accounts_account_number;
DROP INDEX IF EXISTS idx_transactions_family_id;
DROP INDEX IF EXISTS idx_transactions_from_wallet;
DROP INDEX IF EXISTS idx_transactions_to_wallet;
DROP INDEX IF EXISTS idx_transactions_created_at;
DROP INDEX IF EXISTS idx_money_requests_from_wallet;
DROP INDEX IF EXISTS idx_money_requests_to_wallet;
DROP INDEX IF EXISTS idx_receipts_user_id;
DROP INDEX IF EXISTS idx_location_logs_user_id;
DROP INDEX IF EXISTS idx_messages_family_id;

-- Step 5: Verify cleanup
DO $$
DECLARE
    table_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO table_count
    FROM information_schema.tables
    WHERE table_schema = 'public'
      AND table_type = 'BASE TABLE';
    
    RAISE NOTICE '✅ Cleanup complete. Remaining public tables: %', table_count;
END $$;

-- ============================================
-- Now run the main schema.sql file to recreate everything
-- Or copy-paste the schema here if you want one-file reset
-- ============================================


