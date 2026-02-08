-- ============================================
-- MONIKID COMPLETE DATABASE SETUP
-- Version: 2.0 - Production Ready
-- Run this file once to set up everything
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- STEP 1: DROP EXISTING OBJECTS (Clean slate)
-- ============================================

-- Drop triggers
-- ============================================
-- MONIKID COMPLETE DATABASE SETUP - FIXED VERSION
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- STEP 1: DROP EXISTING OBJECTS
-- ============================================

-- Drop RLS policies first (có thể đang chặn INSERT)
DO $$
DECLARE
    pol RECORD;
BEGIN
    FOR pol IN 
        SELECT policyname, tablename 
        FROM pg_policies 
        WHERE schemaname = 'public'
    LOOP
        EXECUTE format('DROP POLICY IF EXISTS %I ON public.%I', pol.policyname, pol.tablename);
    END LOOP;
END $$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users CASCADE;
DROP TRIGGER IF EXISTS on_profile_created ON public.profiles CASCADE;
DROP TRIGGER IF EXISTS update_profiles_updated_at ON public.profiles CASCADE;
DROP TRIGGER IF EXISTS update_wallets_updated_at ON public.wallets CASCADE;
DROP TRIGGER IF EXISTS update_mock_bank_accounts_updated_at ON public.mock_bank_accounts CASCADE;

DROP FUNCTION IF EXISTS public.handle_new_user() CASCADE;
DROP FUNCTION IF EXISTS public.initialize_user_wallet() CASCADE;
DROP FUNCTION IF EXISTS public.update_updated_at_column() CASCADE;
DROP FUNCTION IF EXISTS public.deposit_from_bank(UUID, NUMERIC, TEXT) CASCADE;
DROP FUNCTION IF EXISTS public.withdraw_to_bank(UUID, NUMERIC, TEXT) CASCADE;
DROP FUNCTION IF EXISTS public.transfer_between_wallets(UUID, UUID, NUMERIC, TEXT) CASCADE;

-- Drop tables
DROP TABLE IF EXISTS public.location_logs CASCADE;
DROP TABLE IF EXISTS public.messages CASCADE;
DROP TABLE IF EXISTS public.receipts CASCADE;
DROP TABLE IF EXISTS public.allowance_schedules CASCADE;
DROP TABLE IF EXISTS public.money_requests CASCADE;
DROP TABLE IF EXISTS public.transactions CASCADE;
DROP TABLE IF EXISTS public.mock_bank_accounts CASCADE;
DROP TABLE IF EXISTS public.wallets CASCADE;
DROP TABLE IF EXISTS public.family_members CASCADE;
DROP TABLE IF EXISTS public.families CASCADE;
DROP TABLE IF EXISTS public.profiles CASCADE;

-- ============================================
-- STEP 2: CREATE CORE TABLES (Dùng public. đầy đủ)
-- ============================================

CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    full_name TEXT NOT NULL,
    phone TEXT NOT NULL,
    phone_verified BOOLEAN DEFAULT FALSE,
    avatar_url TEXT,
    role TEXT NOT NULL CHECK (role IN ('parent', 'child')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.families (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    invite_code TEXT UNIQUE NOT NULL,
    created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.family_members (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    family_id UUID REFERENCES public.families(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    role TEXT NOT NULL CHECK (role IN ('owner', 'parent', 'child')),
    added_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(family_id, user_id)
);

CREATE TABLE public.wallets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    owner_id UUID UNIQUE REFERENCES public.profiles(id) ON DELETE CASCADE,
    family_id UUID REFERENCES public.families(id) ON DELETE CASCADE,
    wallet_type TEXT NOT NULL CHECK (wallet_type IN ('parent', 'child')),
    balance DECIMAL(12,2) DEFAULT 1000000 CHECK (balance >= 0),
    is_locked BOOLEAN DEFAULT FALSE,
    locked_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    locked_at TIMESTAMPTZ,
    spending_limit_daily DECIMAL(12,2),
    created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.mock_bank_accounts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE REFERENCES public.profiles(id) ON DELETE CASCADE,
    account_number TEXT UNIQUE NOT NULL,
    balance DECIMAL(12,2) DEFAULT 1000000 CHECK (balance >= 0),
    is_verified BOOLEAN DEFAULT FALSE,
    linked_wallet_id UUID REFERENCES public.wallets(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE public.transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    family_id UUID REFERENCES public.families(id) ON DELETE CASCADE,
    from_wallet_id UUID REFERENCES public.wallets(id) ON DELETE SET NULL,
    to_wallet_id UUID REFERENCES public.wallets(id) ON DELETE SET NULL,
    type TEXT NOT NULL CHECK (type IN ('bank_deposit', 'bank_withdraw', 'allowance', 'payment', 'request_transfer')),
    amount DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    description TEXT,
    merchant_name TEXT,
    location_lat DECIMAL(10,8),
    location_lng DECIMAL(11,8),
    created_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    status TEXT DEFAULT 'completed' CHECK (status IN ('pending', 'completed', 'failed', 'cancelled')),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Các bảng phụ khác cũng dùng public. tương tự...
CREATE TABLE public.money_requests (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    from_wallet_id UUID REFERENCES public.wallets(id) ON DELETE CASCADE,
    to_wallet_id UUID REFERENCES public.wallets(id) ON DELETE CASCADE,
    amount DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    reason TEXT,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'denied')),
    responded_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- STEP 3: CREATE FUNCTIONS & TRIGGERS (With explicit search_path)
-- ============================================

CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Profile update trigger
CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Auth sync function - Tạo profile khi user đăng ký
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER 
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    INSERT INTO public.profiles (id, email, full_name, phone, role, avatar_url)
    VALUES (
        NEW.id,
        COALESCE(NEW.email, ''),
        COALESCE(NEW.raw_user_meta_data->>'full_name', 'User'),
        COALESCE(NEW.raw_user_meta_data->>'phone', '0000000000'),
        COALESCE(NEW.raw_user_meta_data->>'role', 'parent'),
        NEW.raw_user_meta_data->>'avatar_url'
    )
    ON CONFLICT (id) DO UPDATE SET
        email = EXCLUDED.email,
        full_name = COALESCE(NULLIF(EXCLUDED.full_name, ''), public.profiles.full_name),
        phone = COALESCE(NULLIF(EXCLUDED.phone, ''), public.profiles.phone),
        role = COALESCE(NULLIF(EXCLUDED.role, ''), public.profiles.role),
        updated_at = NOW();
    
    RETURN NEW;
EXCEPTION
    WHEN OTHERS THEN
        -- Log lỗi nhưng vẫn cho phép user được tạo
        RAISE LOG 'handle_new_user error for %: %', NEW.id, SQLERRM;
        RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Initialize wallet function - Tạo wallet sau khi profile được tạo
CREATE OR REPLACE FUNCTION public.initialize_user_wallet()
RETURNS TRIGGER 
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
    account_num TEXT;
    v_wallet_id UUID;
BEGIN
    -- Tạo số tài khoản ngẫu nhiên
    account_num := '9704' || LPAD(FLOOR(RANDOM() * 1000000000000)::TEXT, 12, '0');
    
    -- Tạo wallet
    INSERT INTO public.wallets (owner_id, wallet_type, balance, created_by)
    VALUES (NEW.id, NEW.role, 1000000, NEW.id)
    ON CONFLICT (owner_id) DO NOTHING
    RETURNING id INTO v_wallet_id;
    
    -- Tạo mock bank account cho parent
    IF NEW.role = 'parent' AND v_wallet_id IS NOT NULL THEN
        INSERT INTO public.mock_bank_accounts (user_id, account_number, balance, is_verified, linked_wallet_id)
        VALUES (NEW.id, account_num, 1000000, TRUE, v_wallet_id)
        ON CONFLICT (user_id) DO NOTHING;
    END IF;
    
    RETURN NEW;
EXCEPTION
    WHEN OTHERS THEN
        RAISE LOG 'initialize_user_wallet error for %: %', NEW.id, SQLERRM;
        RETURN NEW;
END;
$$;

CREATE TRIGGER on_profile_created
    AFTER INSERT ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.initialize_user_wallet();

-- ============================================
-- STEP 5: WALLET OPERATION RPC FUNCTIONS
-- ============================================

-- DEPOSIT FROM BANK TO WALLET
CREATE OR REPLACE FUNCTION deposit_from_bank(
    p_user_id UUID,
    p_amount NUMERIC,
    p_description TEXT DEFAULT 'Deposit from bank'
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_wallet_id UUID;
    v_transaction_id UUID;
    v_new_balance NUMERIC;
BEGIN
    -- Get wallet
    SELECT id, balance INTO v_wallet_id, v_new_balance
    FROM wallets
    WHERE owner_id = p_user_id;

    IF v_wallet_id IS NULL THEN
        RAISE EXCEPTION 'Wallet not found for user';
    END IF;

    -- Update wallet balance
    v_new_balance := v_new_balance + p_amount;
    UPDATE wallets
    SET balance = v_new_balance,
        updated_at = NOW()
    WHERE id = v_wallet_id;

    -- Update bank account balance (decrease)
    UPDATE mock_bank_accounts
    SET balance = balance - p_amount,
        updated_at = NOW()
    WHERE user_id = p_user_id;

    -- Create transaction record
    INSERT INTO transactions (
        family_id,
        to_wallet_id,
        type,
        amount,
        status,
        description,
        created_by
    )
    SELECT 
        w.family_id,
        v_wallet_id,
        'bank_deposit',
        p_amount,
        'completed',
        p_description,
        p_user_id
    FROM wallets w
    WHERE w.id = v_wallet_id
    RETURNING id INTO v_transaction_id;

    RETURN jsonb_build_object(
        'success', true,
        'transaction_id', v_transaction_id,
        'new_balance', v_new_balance
    );
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Deposit failed: %', SQLERRM;
END;
$$;

-- WITHDRAW FROM WALLET TO BANK
CREATE OR REPLACE FUNCTION withdraw_to_bank(
    p_user_id UUID,
    p_amount NUMERIC,
    p_description TEXT DEFAULT 'Withdraw to bank'
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_wallet_id UUID;
    v_transaction_id UUID;
    v_current_balance NUMERIC;
    v_new_balance NUMERIC;
BEGIN
    -- Get wallet and check balance
    SELECT id, balance INTO v_wallet_id, v_current_balance
    FROM wallets
    WHERE owner_id = p_user_id;

    IF v_wallet_id IS NULL THEN
        RAISE EXCEPTION 'Wallet not found for user';
    END IF;

    IF v_current_balance < p_amount THEN
        RAISE EXCEPTION 'Insufficient balance';
    END IF;

    -- Update wallet balance
    v_new_balance := v_current_balance - p_amount;
    UPDATE wallets
    SET balance = v_new_balance,
        updated_at = NOW()
    WHERE id = v_wallet_id;

    -- Update bank account balance (increase)
    UPDATE mock_bank_accounts
    SET balance = balance + p_amount,
        updated_at = NOW()
    WHERE user_id = p_user_id;

    -- Create transaction record
    INSERT INTO transactions (
        family_id,
        from_wallet_id,
        type,
        amount,
        status,
        description,
        created_by
    )
    SELECT 
        w.family_id,
        v_wallet_id,
        'bank_withdraw',
        p_amount,
        'completed',
        p_description,
        p_user_id
    FROM wallets w
    WHERE w.id = v_wallet_id
    RETURNING id INTO v_transaction_id;

    RETURN jsonb_build_object(
        'success', true,
        'transaction_id', v_transaction_id,
        'new_balance', v_new_balance
    );
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Withdraw failed: %', SQLERRM;
END;
$$;

-- TRANSFER BETWEEN WALLETS
CREATE OR REPLACE FUNCTION transfer_between_wallets(
    p_from_user_id UUID,
    p_to_wallet_id UUID,
    p_amount NUMERIC,
    p_description TEXT DEFAULT 'Transfer'
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_from_wallet_id UUID;
    v_transaction_id UUID;
    v_current_balance NUMERIC;
    v_new_balance NUMERIC;
BEGIN
    -- Get source wallet and check balance
    SELECT id, balance INTO v_from_wallet_id, v_current_balance
    FROM wallets
    WHERE owner_id = p_from_user_id;

    IF v_from_wallet_id IS NULL THEN
        RAISE EXCEPTION 'Source wallet not found';
    END IF;

    IF v_current_balance < p_amount THEN
        RAISE EXCEPTION 'Insufficient balance';
    END IF;

    -- Check target wallet exists
    IF NOT EXISTS (SELECT 1 FROM wallets WHERE id = p_to_wallet_id) THEN
        RAISE EXCEPTION 'Target wallet not found';
    END IF;

    -- Update source wallet balance (decrease)
    v_new_balance := v_current_balance - p_amount;
    UPDATE wallets
    SET balance = v_new_balance,
        updated_at = NOW()
    WHERE id = v_from_wallet_id;

    -- Update target wallet balance (increase)
    UPDATE wallets
    SET balance = balance + p_amount,
        updated_at = NOW()
    WHERE id = p_to_wallet_id;

    -- Create transaction record
    INSERT INTO transactions (
        family_id,
        from_wallet_id,
        to_wallet_id,
        type,
        amount,
        status,
        description,
        created_by
    )
    SELECT 
        w.family_id,
        v_from_wallet_id,
        p_to_wallet_id,
        'allowance',
        p_amount,
        'completed',
        p_description,
        p_from_user_id
    FROM wallets w
    WHERE w.id = v_from_wallet_id
    RETURNING id INTO v_transaction_id;

    RETURN jsonb_build_object(
        'success', true,
        'transaction_id', v_transaction_id,
        'new_balance', v_new_balance
    );
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Transfer failed: %', SQLERRM;
END;
$$;

-- Grant execute permissions
GRANT EXECUTE ON FUNCTION deposit_from_bank TO authenticated;
GRANT EXECUTE ON FUNCTION withdraw_to_bank TO authenticated;
GRANT EXECUTE ON FUNCTION transfer_between_wallets TO authenticated;

-- ============================================
-- STEP 6: DISABLE RLS (FOR DEVELOPMENT)
-- Re-enable with proper policies in production
-- ============================================

ALTER TABLE profiles DISABLE ROW LEVEL SECURITY;
ALTER TABLE families DISABLE ROW LEVEL SECURITY;
ALTER TABLE family_members DISABLE ROW LEVEL SECURITY;
ALTER TABLE wallets DISABLE ROW LEVEL SECURITY;
ALTER TABLE mock_bank_accounts DISABLE ROW LEVEL SECURITY;
ALTER TABLE transactions DISABLE ROW LEVEL SECURITY;
ALTER TABLE money_requests DISABLE ROW LEVEL SECURITY;
ALTER TABLE allowance_schedules DISABLE ROW LEVEL SECURITY;
ALTER TABLE receipts DISABLE ROW LEVEL SECURITY;
ALTER TABLE location_logs DISABLE ROW LEVEL SECURITY;
ALTER TABLE messages DISABLE ROW LEVEL SECURITY;

-- Grant access to authenticated users
GRANT ALL ON ALL TABLES IN SCHEMA public TO authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO authenticated;

-- ============================================
-- STEP 7: SYNC EXISTING AUTH USERS
-- ============================================

-- Create profiles for existing auth users
INSERT INTO profiles (id, email, full_name, phone, role)
SELECT 
    au.id,
    au.email,
    COALESCE(au.raw_user_meta_data->>'full_name', 'User'),
    COALESCE(au.raw_user_meta_data->>'phone', ''),
    COALESCE(au.raw_user_meta_data->>'role', 'parent')
FROM auth.users au
WHERE NOT EXISTS (SELECT 1 FROM profiles WHERE id = au.id)
ON CONFLICT (id) DO NOTHING;

-- Create wallets for existing profiles
DO $$
DECLARE
    profile_rec RECORD;
    new_wallet_id UUID;
    account_num TEXT;
BEGIN
    FOR profile_rec IN
        SELECT * FROM profiles
        WHERE id NOT IN (SELECT owner_id FROM wallets WHERE owner_id IS NOT NULL)
    LOOP
        account_num := '9704' || LPAD(FLOOR(RANDOM() * 1000000000000)::TEXT, 12, '0');

        INSERT INTO wallets (owner_id, wallet_type, balance, created_by)
        VALUES (profile_rec.id, profile_rec.role, 1000000, profile_rec.id)
        RETURNING id INTO new_wallet_id;

        RAISE NOTICE 'Created wallet % for user %', new_wallet_id, profile_rec.email;

        IF profile_rec.role = 'parent' THEN
            IF NOT EXISTS (SELECT 1 FROM mock_bank_accounts WHERE user_id = profile_rec.id) THEN
                INSERT INTO mock_bank_accounts (user_id, account_number, balance, is_verified)
                VALUES (profile_rec.id, account_num, 1000000, TRUE);
                
                RAISE NOTICE 'Created bank account % for user %', account_num, profile_rec.email;
            END IF;
        END IF;
    END LOOP;
END $$;

-- ============================================
-- STEP 8: VERIFICATION QUERIES
-- ============================================

SELECT '✅ Setup Complete!' as status;

SELECT 
    'Tables Created' as check_type,
    COUNT(*) as count
FROM information_schema.tables
WHERE table_schema = 'public'
    AND table_name IN ('profiles', 'wallets', 'mock_bank_accounts', 'transactions');

SELECT 
    'Functions Created' as check_type,
    COUNT(*) as count
FROM pg_proc
WHERE proname IN ('deposit_from_bank', 'withdraw_to_bank', 'transfer_between_wallets');

SELECT 
    'Users with Wallets' as check_type,
    COUNT(*) as count
FROM profiles p
JOIN wallets w ON w.owner_id = p.id;
