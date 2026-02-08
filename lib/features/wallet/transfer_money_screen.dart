import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/models/entities/wallet/wallet_model.dart';
import 'package:monikid/shared/widgets/custom_input.dart';
import 'package:monikid/shared/widgets/primary_button.dart';
import 'providers/wallet_provider.dart';

// --- MÀN HÌNH CHUYỂN TIỀN (TRANSFER SCREEN) ---

class TransferMoneyScreen extends ConsumerStatefulWidget {
  const TransferMoneyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TransferMoneyScreen> createState() => _TransferMoneyScreenState();
}

class _TransferMoneyScreenState extends ConsumerState<TransferMoneyScreen> {
  int _selectedUserIndex = 0;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _handleTransfer() async {
    final walletState = ref.read(walletProvider);
    final familyMembers = walletState.familyMembers;
    
    if (familyMembers.isEmpty || _selectedUserIndex >= familyMembers.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a recipient'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    final selectedMember = familyMembers[_selectedUserIndex];
    if (selectedMember.walletId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selected member does not have a wallet'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

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

    if (amount > walletState.balance) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insufficient balance'),
          backgroundColor: AppTheme.redAlert,
        ),
      );
      return;
    }

    try {
      await ref.read(walletProvider.notifier).transfer(
        toWalletId: selectedMember.walletId!,
        amount: amount,
        description: _noteController.text.trim().isNotEmpty 
            ? _noteController.text.trim() 
            : 'Transfer to ${selectedMember.fullName}',
      );

      if (mounted) {
        // Clear inputs
        _amountController.clear();
        _noteController.clear();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully sent \$${amount.toStringAsFixed(2)} to ${selectedMember.fullName}'),
            backgroundColor: AppTheme.primaryGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transfer failed: ${e.toString()}'),
            backgroundColor: AppTheme.redAlert,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletProvider);
    final familyMembers = walletState.familyMembers;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textWhite),
          onPressed: () => context.pop(),
        ),
        title: const Text("Transfer", style: TextStyle(color: AppTheme.textWhite, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      
                      // 1. NGƯỜI NHẬN (RECIPIENT LIST)
                      const Text("Send to", style: TextStyle(color: AppTheme.textGrey, fontSize: 14)),
                      const SizedBox(height: 16),
                      _buildRecipientList(familyMembers),

                      const SizedBox(height: 20),

                      // Balance info
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Available Balance", style: TextStyle(color: AppTheme.textGrey)),
                            Text(
                              '\$${walletState.balance.toStringAsFixed(2)}',
                              style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 2. NHẬP SỐ TIỀN (AMOUNT INPUT)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Column(
                          children: [
                            const Text("Enter Amount", style: TextStyle(color: AppTheme.textGrey, fontSize: 12)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                const Text("\$", style: TextStyle(color: AppTheme.textWhite, fontSize: 32, fontWeight: FontWeight.bold)),
                                IntrinsicWidth(
                                  child: TextField(
                                    controller: _amountController,
                                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                    style: const TextStyle(
                                      color: AppTheme.background,
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    cursorColor: AppTheme.primaryGreen,
                                    decoration: const InputDecoration(
                                      hintText: "0.00",
                                      hintStyle: TextStyle(color: Colors.white24),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 3. GỢI Ý NHANH (QUICK AMOUNTS)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [10, 20, 50, 100].map((amount) {
                          return GestureDetector(
                            onTap: () {
                              _amountController.text = amount.toString();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppTheme.surface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white10),
                              ),
                              child: Text(
                                "\$$amount",
                                style: const TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),

                      // 4. LỜI NHẮN (MESSAGE INPUT)
                      CustomInputWidget(
                        label: "Note (Optional)",
                        placeholder: "For lunch, books...",
                        prefixIcon: Icons.edit_note,
                        controller: _noteController,
                      ),

                      const Spacer(),

                      // 5. NÚT XÁC NHẬN (ACTION BUTTON)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0, top: 20.0),
                        child: walletState.isTransferring
                            ? const Center(
                                child: CircularProgressIndicator(color: AppTheme.primaryGreen),
                              )
                            : PrimaryButton(
                                text: "Confirm Transfer",
                                onPressed: _handleTransfer,
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

  Widget _buildRecipientList(List<FamilyMemberWallet> familyMembers) {
    if (familyMembers.isEmpty) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: const Text(
          'No family members found',
          style: TextStyle(color: AppTheme.textGrey),
        ),
      );
    }

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: familyMembers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final member = familyMembers[index];
          final isSelected = _selectedUserIndex == index;
          final colors = [Colors.blueAccent, Colors.purpleAccent, Colors.orangeAccent, Colors.tealAccent];
          final color = colors[index % colors.length];
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedUserIndex = index;
              });
            },
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.2),
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: member.avatarUrl != null
                      ? ClipOval(
                          child: Image.network(
                            member.avatarUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              member.role == 'child' ? Icons.face : Icons.face_2,
                              color: color,
                              size: 30,
                            ),
                          ),
                        )
                      : Icon(
                          member.role == 'child' ? Icons.face : Icons.face_2,
                          color: color,
                          size: 30,
                        ),
                ),
                const SizedBox(height: 8),
                Text(
                  member.fullName.split(' ').first,
                  style: TextStyle(
                    color: isSelected ? AppTheme.primaryGreen : AppTheme.textGrey,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}