-- ============================================
-- WALLET OPERATION FUNCTIONS (RPC)
-- Thực hiện deposit, withdraw, transfer trực tiếp
-- ============================================

-- 1. DEPOSIT FROM BANK TO WALLET
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

-- 2. WITHDRAW FROM WALLET TO BANK
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

-- 3. TRANSFER BETWEEN WALLETS
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
