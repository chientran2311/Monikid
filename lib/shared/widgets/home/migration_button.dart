import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Thêm để dùng Firestore
import 'package:firebase_auth/firebase_auth.dart';

class MigrationButtons extends StatelessWidget {
  const MigrationButtons({super.key});

  Future<void> _startMigration(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Bạn chưa đăng nhập Firebase!")),
      );
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(color: AppTheme.primaryGreen)),
      );

      // --- PHẦN 1: KHỞI TẠO USER PROFILE & WALLET ---
      // Tương ứng bảng: profiles, wallets, mock_bank_accounts
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'full_name': "Trần Đạt Chiến", 
        'phone': "0000000000",
        'role': 'parent', // Mặc định role từ schema
        'avatar_url': "https://i.pravatar.cc/150?img=11",
        'wallet': {
          'balance': 1000000.0, // Khởi tạo 1.000.000đ như schema
          'is_locked': false,
          'spending_limit_daily': null,
          'last_updated': FieldValue.serverTimestamp(),
        },
        'bank_account': {
          'account_number': 'BK-${DateTime.now().millisecondsSinceEpoch}',
          'bank_balance': 1000000.0,
          'is_verified': true,
        },
        'family_id': null, // Sẽ cập nhật khi tạo/gia nhập gia đình
        'created_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

     

      Navigator.pop(context); 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(backgroundColor: AppTheme.primaryGreen, content: Text("✅ Migration hoàn tất: Đã tạo User, Wallet & Bank!")),
      );
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: AppTheme.redAlert, content: Text("❌ Lỗi Migration: $e")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Text(
            "Hệ thống chưa có dữ liệu ví?",
            style: TextStyle(color: AppTheme.textGrey, fontSize: 13),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => _startMigration(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.cloud_sync),
            label: const Text("Khởi tạo Storage & Ví (1M)", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
