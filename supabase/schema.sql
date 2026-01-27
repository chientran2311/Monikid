-- ============================================
-- MoniKid Database Schema for Supabase
-- Version: 1.0
-- ============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- PROFILES (extends auth.users)
-- ============================================
CREATE TABLE IF NOT EXISTS profiles (
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

-- Trigger to auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON profiles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- FAMILIES
-- ============================================
CREATE TABLE IF NOT EXISTS families (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    invite_code TEXT UNIQUE NOT NULL,
    created_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for invite code lookups
CREATE INDEX IF NOT EXISTS idx_families_invite_code ON families(invite_code);

-- ============================================
-- FAMILY MEMBERS (junction table)
-- ============================================
CREATE TABLE IF NOT EXISTS family_members (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    family_id UUID REFERENCES families(id) ON DELETE CASCADE,
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    role TEXT NOT NULL CHECK (role IN ('owner', 'parent', 'child')),
    added_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
    joined_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(family_id, user_id)
);

-- Indexes for family member lookups
CREATE INDEX IF NOT EXISTS idx_family_members_family_id ON family_members(family_id);
CREATE INDEX IF NOT EXISTS idx_family_members_user_id ON family_members(user_id);

-- ============================================
-- WALLETS
-- ============================================
CREATE TABLE IF NOT EXISTS wallets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    owner_id UUID UNIQUE REFERENCES profiles(id) ON DELETE CASCADE,
    family_id UUID REFERENCES families(id) ON DELETE CASCADE,
    wallet_type TEXT NOT NULL CHECK (wallet_type IN ('parent', 'child')),
    balance DECIMAL(12,2) DEFAULT 0 CHECK (balance >= 0),
    is_locked BOOLEAN DEFAULT FALSE,
    locked_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
    locked_at TIMESTAMPTZ,
    spending_limit_daily DECIMAL(12,2),
    created_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for wallet lookups
CREATE INDEX IF NOT EXISTS idx_wallets_family_id ON wallets(family_id);

-- ============================================
-- MOCK BANK ACCOUNTS (parents only)
-- ============================================
CREATE TABLE IF NOT EXISTS mock_bank_accounts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    bank_name TEXT DEFAULT 'Mock Bank',
    account_number TEXT NOT NULL,
    balance DECIMAL(12,2) DEFAULT 10000000 CHECK (balance >= 0),
    is_verified BOOLEAN DEFAULT FALSE,
    linked_wallet_id UUID REFERENCES wallets(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for bank account lookups
CREATE INDEX IF NOT EXISTS idx_mock_bank_accounts_user_id ON mock_bank_accounts(user_id);

-- ============================================
-- TRANSACTIONS
-- ============================================
CREATE TABLE IF NOT EXISTS transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    family_id UUID REFERENCES families(id) ON DELETE CASCADE,
    from_wallet_id UUID REFERENCES wallets(id) ON DELETE SET NULL,
    to_wallet_id UUID REFERENCES wallets(id) ON DELETE SET NULL,
    type TEXT NOT NULL CHECK (type IN (
        'bank_deposit',
        'bank_withdraw',
        'allowance',
        'payment',
        'request_transfer'
    )),
    amount DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    description TEXT,
    merchant_name TEXT,
    location_lat DECIMAL(10,8),
    location_lng DECIMAL(11,8),
    created_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
    status TEXT DEFAULT 'completed',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for transaction lookups
CREATE INDEX IF NOT EXISTS idx_transactions_family_id ON transactions(family_id);
CREATE INDEX IF NOT EXISTS idx_transactions_from_wallet ON transactions(from_wallet_id);
CREATE INDEX IF NOT EXISTS idx_transactions_to_wallet ON transactions(to_wallet_id);
CREATE INDEX IF NOT EXISTS idx_transactions_created_at ON transactions(created_at DESC);

-- ============================================
-- MONEY REQUESTS
-- ============================================
CREATE TABLE IF NOT EXISTS money_requests (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    from_wallet_id UUID REFERENCES wallets(id) ON DELETE CASCADE,
    to_wallet_id UUID REFERENCES wallets(id) ON DELETE CASCADE,
    amount DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    reason TEXT,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'denied')),
    responded_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for pending requests
CREATE INDEX IF NOT EXISTS idx_money_requests_status ON money_requests(status) WHERE status = 'pending';

-- ============================================
-- ALLOWANCE SCHEDULES
-- ============================================
CREATE TABLE IF NOT EXISTS allowance_schedules (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    from_wallet_id UUID REFERENCES wallets(id) ON DELETE CASCADE,
    to_wallet_id UUID REFERENCES wallets(id) ON DELETE CASCADE,
    amount DECIMAL(12,2) NOT NULL CHECK (amount > 0),
    frequency TEXT NOT NULL CHECK (frequency IN ('daily', 'weekly', 'monthly')),
    next_transfer_at TIMESTAMPTZ,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for active schedules
CREATE INDEX IF NOT EXISTS idx_allowance_schedules_active ON allowance_schedules(is_active, next_transfer_at) WHERE is_active = TRUE;

-- ============================================
-- RECEIPTS
-- ============================================
CREATE TABLE IF NOT EXISTS receipts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    transaction_id UUID REFERENCES transactions(id) ON DELETE SET NULL,
    image_url TEXT NOT NULL,
    ocr_amount DECIMAL(12,2),
    ocr_merchant TEXT,
    ocr_date TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for receipt lookups
CREATE INDEX IF NOT EXISTS idx_receipts_user_id ON receipts(user_id);

-- ============================================
-- LOCATION LOGS
-- ============================================
CREATE TABLE IF NOT EXISTS location_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    latitude DECIMAL(10,8) NOT NULL,
    longitude DECIMAL(11,8) NOT NULL,
    source TEXT CHECK (source IN ('interval', 'transaction')),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for location history
CREATE INDEX IF NOT EXISTS idx_location_logs_user_created ON location_logs(user_id, created_at DESC);

-- ============================================
-- MESSAGES (Family Chat)
-- ============================================
CREATE TABLE IF NOT EXISTS messages (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    family_id UUID REFERENCES families(id) ON DELETE CASCADE,
    sender_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for chat history
CREATE INDEX IF NOT EXISTS idx_messages_family_created ON messages(family_id, created_at DESC);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS on all tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE families ENABLE ROW LEVEL SECURITY;
ALTER TABLE family_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE wallets ENABLE ROW LEVEL SECURITY;
ALTER TABLE mock_bank_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE money_requests ENABLE ROW LEVEL SECURITY;
ALTER TABLE allowance_schedules ENABLE ROW LEVEL SECURITY;
ALTER TABLE receipts ENABLE ROW LEVEL SECURITY;
ALTER TABLE location_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

-- ============================================
-- RLS POLICIES - Profiles
-- ============================================
CREATE POLICY "Users can view own profile"
    ON profiles FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
    ON profiles FOR UPDATE
    USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
    ON profiles FOR INSERT
    WITH CHECK (auth.uid() = id);

-- Family members can view each other's profiles
CREATE POLICY "Family members can view each other"
    ON profiles FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM family_members fm1
            JOIN family_members fm2 ON fm1.family_id = fm2.family_id
            WHERE fm1.user_id = auth.uid() AND fm2.user_id = profiles.id
        )
    );

-- ============================================
-- RLS POLICIES - Families
-- ============================================
CREATE POLICY "Family members can view their family"
    ON families FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM family_members
            WHERE family_id = families.id AND user_id = auth.uid()
        )
    );

CREATE POLICY "Parents can create families"
    ON families FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles
            WHERE id = auth.uid() AND role = 'parent'
        )
    );

-- ============================================
-- RLS POLICIES - Family Members
-- ============================================
CREATE POLICY "Family members can view their family members"
    ON family_members FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM family_members fm
            WHERE fm.family_id = family_members.family_id AND fm.user_id = auth.uid()
        )
    );

-- ============================================
-- RLS POLICIES - Wallets
-- ============================================
CREATE POLICY "Users can view own wallet"
    ON wallets FOR SELECT
    USING (owner_id = auth.uid());

CREATE POLICY "Parents can view family wallets"
    ON wallets FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM family_members fm
            WHERE fm.family_id = wallets.family_id
            AND fm.user_id = auth.uid()
            AND fm.role IN ('owner', 'parent')
        )
    );

CREATE POLICY "Users can update own wallet"
    ON wallets FOR UPDATE
    USING (owner_id = auth.uid());

-- ============================================
-- RLS POLICIES - Transactions
-- ============================================
CREATE POLICY "Family members can view family transactions"
    ON transactions FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM family_members fm
            WHERE fm.family_id = transactions.family_id AND fm.user_id = auth.uid()
        )
    );

CREATE POLICY "Family members can insert transactions"
    ON transactions FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM family_members fm
            WHERE fm.family_id = transactions.family_id AND fm.user_id = auth.uid()
        )
    );

-- ============================================
-- RLS POLICIES - Messages
-- ============================================
CREATE POLICY "Family members can view messages"
    ON messages FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM family_members fm
            WHERE fm.family_id = messages.family_id AND fm.user_id = auth.uid()
        )
    );

CREATE POLICY "Family members can send messages"
    ON messages FOR INSERT
    WITH CHECK (
        sender_id = auth.uid() AND
        EXISTS (
            SELECT 1 FROM family_members fm
            WHERE fm.family_id = messages.family_id AND fm.user_id = auth.uid()
        )
    );

-- ============================================
-- REALTIME SUBSCRIPTIONS
-- ============================================
-- Enable realtime for specific tables
ALTER PUBLICATION supabase_realtime ADD TABLE messages;
ALTER PUBLICATION supabase_realtime ADD TABLE transactions;
ALTER PUBLICATION supabase_realtime ADD TABLE money_requests;
ALTER PUBLICATION supabase_realtime ADD TABLE wallets;

-- ============================================
-- STORAGE BUCKETS (run in Supabase dashboard)
-- ============================================
-- Create buckets for:
-- - avatars (profile pictures)
-- - receipts (scanned receipt images)
-- 
-- INSERT INTO storage.buckets (id, name, public)
-- VALUES ('avatars', 'avatars', true);
-- 
-- INSERT INTO storage.buckets (id, name, public)
-- VALUES ('receipts', 'receipts', false);
