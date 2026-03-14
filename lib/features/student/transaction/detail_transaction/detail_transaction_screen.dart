import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/App/app.dart';
import 'package:monikid/features/student/transaction/detail_transaction/detail_transaction_provider.dart';

class DetailTransactionScreen extends ConsumerWidget {
  final TransactionModel transaction;
  const DetailTransactionScreen({Key? key, required this.transaction})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "Chi tiết Giao dịch",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            // Hero Section: Amount & Category
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: transaction.type == 'income'
                    ? Colors.green.withOpacity(0.1)
                    : AppTheme.primary.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: transaction.type == 'income'
                      ? Colors.green.withOpacity(0.2)
                      : AppTheme.primary.withOpacity(0.1),
                  width: 4,
                ),
              ),
              child: Center(
                child: Text(
                  transaction.categoryEmoji ??
                      (transaction.type == 'income' ? '💰' : '💸'),
                  style: const TextStyle(fontSize: 36),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              transaction.category,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              CurrencyFormatter.formatWithSign(
                transaction.amount,
                transaction.type,
              ),
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: transaction.type == 'income'
                    ? Colors.green
                    : AppTheme.redAlert,
              ),
            ),
            const SizedBox(height: 24),

            // Details Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF1F5F9),
                ),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    iconData: Icons.calendar_today,
                    label: "THỜI GIAN",
                    value: DateFormat(
                      'dd/MM/yyyy - HH:mm',
                    ).format(transaction.date),
                    isDark: isDark,
                  ),
                  Divider(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFF1F5F9),
                    height: 32,
                  ),
                  _buildDetailRow(
                    iconData: Icons.account_balance_wallet,
                    label: "NGUỒN TIỀN",
                    value: "Tiền mặt",
                    isDark: isDark,
                  ),
                  if (transaction.note != null &&
                      transaction.note!.isNotEmpty) ...[
                    Divider(
                      color: isDark
                          ? const Color(0xFF1E293B)
                          : const Color(0xFFF1F5F9),
                      height: 32,
                    ),
                    _buildDetailRow(
                      iconData: Icons.description,
                      label: "GHI CHÚ",
                      value: transaction.note!,
                      isDark: isDark,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Map Preview Placeholder
            Container(
              width: double.infinity,
              height: 128,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF334155)
                    : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.map, size: 48, color: Color(0xFF94A3B8)),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 12,
                    left: 12,
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "Canteen Đại học",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            top: BorderSide(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.updateTransaction, extra: transaction);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Chỉnh sửa",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () async {
                try {
                  await ref
                      .read(detailTransactionNotifierProvider.notifier)
                      .deleteTransaction(transaction.transactionId);
                  if (context.mounted) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(s.msgTransactionDeleted)),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(s.errorGeneric(e.toString()))));
                  }
                }
              }, // delete action
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF64748B),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Xóa giao dịch",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData iconData,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
            shape: BoxShape.circle,
          ),
          child: Icon(iconData, color: AppTheme.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? const Color(0xFFCBD5E1)
                      : const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
