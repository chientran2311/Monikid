import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/App/router.dart';
import 'package:monikid/core/theme/theme.dart';

class QuickAction extends StatelessWidget {
  const QuickAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          icon: Icons.add, 
          label: "Top Up", 
          onTap: () => context.push(AppRoutes.parentWithdrawDeposit),
        ),
        _buildActionButton(
          icon: Icons.arrow_downward, 
          label: "Withdraw", 
          onTap: () => context.push(AppRoutes.parentWithdrawDeposit),
        ),
        _buildActionButton(
          icon: Icons.send, 
          label: "Transfer", 
          onTap: () => context.push(AppRoutes.parentTransfer),
        ),
        _buildActionButton(
          icon: Icons.account_balance_wallet, 
          label: "Wallet", 
          onTap: () => context.push(AppRoutes.parentWallet),
        ),
      ],
    );
  }
  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap, bool showBadge = false}) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white10),
                ),
                child: Icon(icon, color: AppTheme.primaryGreen, size: 28),
              ),
            ),
            if (showBadge)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppTheme.redAlert,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.background, width: 2),
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: AppTheme.textGrey, fontSize: 12),
        ),
      ],
    );
  }
  
}