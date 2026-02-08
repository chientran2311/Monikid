import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/wallet/providers/wallet_provider.dart';
import 'package:monikid/shared/widgets/home/header_home.dart';
import 'package:monikid/shared/widgets/home/quick_action.dart';


// --- PHẦN 2: MÀN HÌNH CHÍNH PARENT ---

class ParentHomeScreen extends ConsumerStatefulWidget {
  const ParentHomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends ConsumerState<ParentHomeScreen> {
  int _currentIndex = 0; // Index cho BottomNavigationBar
  bool _isCreatingFamily = false;

  Future<void> _handleFakeFamily() async {
    setState(() {
      _isCreatingFamily = true;
    });

    try {
      await ref.read(walletProvider.notifier).createFakeFamily();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Fake family created with 3 children!'),
            backgroundColor: AppTheme.primaryGreen,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error: $e'),
            backgroundColor: AppTheme.redAlert,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCreatingFamily = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      
      // --- BODY ---
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. CUSTOM HEADER (Profile & Noti)
              const   HeaderHome(),

              const SizedBox(height: 32),

              // 2. WALLET CARD
              const Card(),

              const SizedBox(height: 24),

              // 3. QUICK ACTIONS (Nạp, Rút, Approve...)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Quick Actions",
                    style: TextStyle(
                      color: AppTheme.textWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // NÚT FAKE DATA
                  TextButton.icon(
                    onPressed: _isCreatingFamily ? null : _handleFakeFamily,
                    icon: _isCreatingFamily
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppTheme.primaryGreen,
                            ),
                          )
                        : const Icon(Icons.group_add, color: AppTheme.primaryGreen, size: 18),
                    label: const Text(
                      "Fake Family",
                      style: TextStyle(color: AppTheme.primaryGreen, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const QuickAction(),

              const SizedBox(height: 32),

              // 4. GENERAL CONTENT (Ví dụ: Recent Transactions)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Activity",
                    style: TextStyle(
                      color: AppTheme.textWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("See All", style: TextStyle(color: AppTheme.primaryGreen)),
                  )
                ],
              ),
              const SizedBox(height: 8),
              _buildRecentActivityList(),
            ],
          ),
        ),
      ),

      // --- BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: AppTheme.background,
          type: BottomNavigationBarType.fixed, // Quan trọng khi có > 3 item
          selectedItemColor: AppTheme.primaryGreen,
          unselectedItemColor: AppTheme.textGrey,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.family_restroom), label: "Family"),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
          ],
        ),
      ),
    );
  }

  
  Widget _buildRecentActivityList() {
    return Column(
      children: [
        _buildTransactionItem(
          name: "Sent to Sarah",
          date: "Today, 10:23 AM",
          amount: "-\$50.00",
          isNegative: true,
          avatarColor: Colors.purpleAccent,
        ),
        _buildTransactionItem(
          name: "Allowance from Bank",
          date: "Yesterday, 4:00 PM",
          amount: "+\$200.00",
          isNegative: false,
          avatarColor: Colors.blueAccent,
        ),
        _buildTransactionItem(
          name: "Netflix Subscription",
          date: "Feb 28, 2024",
          amount: "-\$15.00",
          isNegative: true,
          avatarColor: Colors.redAccent,
        ),
      ],
    );
  }

  // Item giao dịch đơn lẻ
  Widget _buildTransactionItem({
    required String name,
    required String date,
    required String amount,
    required bool isNegative,
    required Color avatarColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Icon tròn
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: avatarColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isNegative ? Icons.shopping_bag_outlined : Icons.account_balance_wallet_outlined,
              color: avatarColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: AppTheme.textWhite, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: AppTheme.textGrey, fontSize: 12)),
              ],
            ),
          ),
          // Amount
          Text(
            amount,
            style: TextStyle(
              color: isNegative ? AppTheme.textWhite : AppTheme.primaryGreen,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}