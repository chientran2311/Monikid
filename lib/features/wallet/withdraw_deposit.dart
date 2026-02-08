import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'package:monikid/shared/widgets/wallet/withdraw_deposit/quick_chips.dart';
import 'package:monikid/shared/widgets/wallet/withdraw_deposit/switch_tab.dart';
import 'providers/wallet_provider.dart';

// --- PHẦN 2: MÀN HÌNH CHÍNH ---

class WithdrawDepositScreen extends ConsumerStatefulWidget {
  const WithdrawDepositScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WithdrawDepositScreen> createState() => _WithdrawDepositScreenState();
}

class _WithdrawDepositScreenState extends ConsumerState<WithdrawDepositScreen> {
  // State: false = Top Up, true = Withdraw
  bool _isWithdrawMode = false;
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _handleAction() async {
    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText);
    
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    final walletState = ref.read(walletProvider);
    
    if (_isWithdrawMode && amount > walletState.balance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insufficient wallet balance'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    if (!_isWithdrawMode && amount > walletState.bankBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insufficient bank balance'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    try {
      if (_isWithdrawMode) {
        await ref.read(walletProvider.notifier).withdraw(
          amount: amount,
          description: 'Withdraw to bank',
        );
      } else {
        await ref.read(walletProvider.notifier).deposit(
          amount: amount,
          description: 'Deposit from bank',
        );
      }

      if (mounted) {
        // Clear input
        _amountController.clear();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isWithdrawMode 
                ? 'Successfully withdrew \$${amount.toStringAsFixed(2)}'
                : 'Successfully deposited \$${amount.toStringAsFixed(2)}'),
            backgroundColor: AppTheme.primaryGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Operation failed: ${e.toString()}'),
            backgroundColor: AppTheme.redAlert,
          ),
        );
      }
    }
  }

  void _selectQuickAmount(double amount) {
    _amountController.text = amount.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textWhite),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _isWithdrawMode ? "Withdraw Funds" : "Top Up Wallet",
          style: const TextStyle(color: AppTheme.textWhite, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - 60),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // 1. CUSTOM TAB SWITCHER
                      _buildTabSwitcher(),

                      const SizedBox(height: 24),

                      // Balance info cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildBalanceCard(
                              'Wallet',
                              walletState.balance,
                              Icons.account_balance_wallet,
                              !_isWithdrawMode,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildBalanceCard(
                              'Bank',
                              walletState.bankBalance,
                              Icons.account_balance,
                              _isWithdrawMode,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // 2. INPUT AMOUNT
                      const Text(
                        "Enter Amount",
                        style: TextStyle(color: AppTheme.textGrey, fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      CustomInputWidget(
                        label: "Amount",
                        placeholder: "0.00",
                        prefixIcon: Icons.attach_money,
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 24),

                      // 3. QUICK SUGGESTIONS
                      _buildQuickChips(),

                      const SizedBox(height: 40),

                      // 4. PAYMENT METHOD / BANK INFO
                      _buildMethodSection(walletState),

                      const Spacer(),

                      // 5. ACTION BUTTON
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24, top: 20),
                        child: Column(
                          children: [
                            if (_isWithdrawMode)
                              const Padding(
                                padding: EdgeInsets.only(bottom: 12),
                                child: Text(
                                  "Funds will arrive within 24 hours.",
                                  style: TextStyle(color: AppTheme.textGrey, fontSize: 12, fontStyle: FontStyle.italic),
                                ),
                              ),
                            walletState.isTransferring
                                ? const CircularProgressIndicator(color: AppTheme.primaryGreen)
                                : PrimaryButton(
                                    text: _isWithdrawMode ? "Confirm Withdraw" : "Confirm Top Up",
                                    onPressed: _handleAction,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isWithdrawMode = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: !_isWithdrawMode ? AppTheme.primaryGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Top Up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !_isWithdrawMode ? AppTheme.background : AppTheme.textGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isWithdrawMode = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: _isWithdrawMode ? AppTheme.redAlert : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Withdraw',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _isWithdrawMode ? AppTheme.textWhite : AppTheme.textGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(String label, double balance, IconData icon, bool isSource) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSource ? AppTheme.primaryGreen.withOpacity(0.5) : Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppTheme.textGrey, size: 16),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: AppTheme.textGrey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '\$${balance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppTheme.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isSource)
            const Text(
              'Source',
              style: TextStyle(color: AppTheme.primaryGreen, fontSize: 10),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [50, 100, 200, 500].map((amount) {
        return GestureDetector(
          onTap: () => _selectQuickAmount(amount.toDouble()),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Text(
              '\$$amount',
              style: const TextStyle(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMethodSection(walletState) {
    final bankAccount = walletState.bankAccount;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isWithdrawMode ? "Withdraw to" : "Deposit from",
          style: const TextStyle(color: AppTheme.textGrey, fontSize: 14),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _isWithdrawMode ? Icons.account_balance : Icons.credit_card,
                  color: Colors.black,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bankAccount?.bankName ?? "Mock Bank",
                      style: const TextStyle(color: AppTheme.textWhite, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bankAccount != null 
                          ? "**** ${bankAccount.accountNumber.substring(bankAccount.accountNumber.length - 4)}"
                          : "**** ****",
                      style: const TextStyle(color: AppTheme.textGrey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              if (bankAccount?.isVerified == true)
                const Icon(Icons.verified, color: AppTheme.primaryGreen, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}