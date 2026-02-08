-- ============================================
-- ADD MISSING updated_at COLUMNS
-- Run this to add updated_at to existing tables
-- ============================================

-- Add updated_at column to wallets table if not exists
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'wallets' 
        AND column_name = 'updated_at'
    ) THEN
        ALTER TABLE wallets ADD COLUMN updated_at TIMESTAMPTZ DEFAULT NOW();
        RAISE NOTICE '✅ Added updated_at column to wallets table';
    ELSE
        RAISE NOTICE 'ℹ️ Column updated_at already exists in wallets table';
    END IF;
END $$;

-- Add updated_at column to mock_bank_accounts if not exists
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'mock_bank_accounts' 
        AND column_name = 'updated_at'
    ) THEN
        ALTER TABLE mock_bank_accounts ADD COLUMN updated_at TIMESTAMPTZ DEFAULT NOW();
        RAISE NOTICE '✅ Added updated_at column to mock_bank_accounts table';
    ELSE
        RAISE NOTICE 'ℹ️ Column updated_at already exists in mock_bank_accounts table';
    END IF;
END $$;

-- Add updated_at column to profiles if not exists
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'profiles' 
        AND column_name = 'updated_at'
    ) THEN
        ALTER TABLE profiles ADD COLUMN updated_at TIMESTAMPTZ DEFAULT NOW();
        RAISE NOTICE '✅ Added updated_at column to profiles table';
    ELSE
        RAISE NOTICE 'ℹ️ Column updated_at already exists in profiles table';
    END IF;
END $$;

-- Create or replace the update_updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for profiles
DROP TRIGGER IF EXISTS update_profiles_updated_at ON profiles;
CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON profiles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Create trigger for wallets
DROP TRIGGER IF EXISTS update_wallets_updated_at ON wallets;
CREATE TRIGGER update_wallets_updated_at
    BEFORE UPDATE ON wallets
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Create trigger for mock_bank_accounts
DROP TRIGGER IF EXISTS update_mock_bank_accounts_updated_at ON mock_bank_accounts;
CREATE TRIGGER update_mock_bank_accounts_updated_at
    BEFORE UPDATE ON mock_bank_accounts
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Verify columns exist
SELECT 
    '✅ VERIFICATION' as status,
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
    AND table_name IN ('profiles', 'wallets', 'mock_bank_accounts')
    AND column_name = 'updated_at'
ORDER BY table_name;
