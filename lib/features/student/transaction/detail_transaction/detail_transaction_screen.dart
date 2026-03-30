import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:monikid/App/app.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/features/student/transaction/detail_transaction/detail_transaction_provider.dart';
import 'package:monikid/features/student/transaction/detail_transaction/detail_transaction_state.dart';
import 'package:monikid/features/student/transaction/detail_transaction/widgets/detail_transaction_bottom_bar.dart';
import 'package:monikid/features/student/transaction/detail_transaction/widgets/transaction_detail_row.dart';
import 'package:monikid/features/student/transaction/transaction_status.dart';
import 'package:monikid/features/student/transaction/widgets/transaction_loading_skeleton.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class DetailTransactionScreen extends ConsumerStatefulWidget {
  const DetailTransactionScreen({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  ConsumerState<DetailTransactionScreen> createState() =>
      _DetailTransactionScreenState();
}

class _DetailTransactionScreenState
    extends ConsumerState<DetailTransactionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(detailTransactionNotifierProvider.notifier)
          .setTransaction(widget.transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<DetailTransactionState>(detailTransactionNotifierProvider, (
      previous,
      next,
    ) {
      if (!context.mounted || previous?.status == next.status) {
        return;
      }

      switch (next.status) {
        case TransactionStatus.success:
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(s.msgTransactionDeleted)));
          context.pop(true);
          return;
        case TransactionStatus.error:
          if (next.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
          }
          return;
        case TransactionStatus.initial:
        case TransactionStatus.loading:
        case TransactionStatus.ready:
        case TransactionStatus.submitting:
          break;
      }
    });

    final state = ref.watch(detailTransactionNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: state.isDeleting ? null : () => context.pop(),
        ),
        title: Text(
          'Chi tiết Giao dịch',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(state, isDark),
      bottomNavigationBar: _buildBottomBar(state, isDark, bgColor),
    );
  }

  Widget _buildBody(DetailTransactionState state, bool isDark) {
    switch (state.status) {
      case TransactionStatus.initial:
      case TransactionStatus.loading:
        return TransactionDetailLoadingSkeleton(isDark: isDark);
      case TransactionStatus.error:
        return _buildErrorState(state.errorMessage);
      case TransactionStatus.ready:
      case TransactionStatus.submitting:
        final transaction = state.transaction;
        if (transaction == null) {
          return const Center(child: Text('Không có dữ liệu giao dịch'));
        }
        return Stack(
          children: [
            _buildTransactionContent(transaction, isDark),
            if (state.isDeleting)
              TransactionDetailLoadingOverlay(isDark: isDark),
          ],
        );
      case TransactionStatus.success:
        return const SizedBox.shrink();
    }
  }

  Widget _buildErrorState(String? errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.redAlert.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? 'Có lỗi xảy ra',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionContent(TransactionModel transaction, bool isDark) {
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          _buildSummaryHeader(transaction),
          const SizedBox(height: 24),
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
                TransactionDetailRow(
                  iconData: Icons.calendar_today,
                  label: 'THỜI GIAN',
                  value: DateFormat('dd/MM/yyyy - HH:mm').format(transaction.date),
                  isDark: isDark,
                ),
                Divider(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF1F5F9),
                  height: 32,
                ),
                TransactionDetailRow(
                  iconData: Icons.account_balance_wallet,
                  label: 'NGUỒN TIỀN',
                  value: transaction.paymentMethod ?? 'Tiền mặt',
                  isDark: isDark,
                ),
                if (transaction.note != null && transaction.note!.isNotEmpty) ...[
                  Divider(
                    color: isDark
                        ? const Color(0xFF1E293B)
                        : const Color(0xFFF1F5F9),
                    height: 32,
                  ),
                  TransactionDetailRow(
                    iconData: Icons.description,
                    label: 'GHI CHÚ',
                    value: transaction.note!,
                    isDark: isDark,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildLocationCard(transaction, isDark),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader(TransactionModel transaction) {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildLocationCard(TransactionModel transaction, bool isDark) {
    return Container(
      width: double.infinity,
      height: 128,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.map,
              size: 48,
              color: Color(0xFF94A3B8),
            ),
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
          Positioned(
            bottom: 12,
            left: 12,
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  transaction.location ?? 'Chưa có vị trí',
                  style: const TextStyle(
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
    );
  }

  Widget _buildBottomBar(
    DetailTransactionState state,
    bool isDark,
    Color bgColor,
  ) {
    final transaction = state.transaction;
    if (transaction == null ||
        state.status == TransactionStatus.initial ||
        state.status == TransactionStatus.loading ||
        state.status == TransactionStatus.error) {
      return const SizedBox.shrink();
    }

    return DetailTransactionBottomBar(
      isDark: isDark,
      bgColor: bgColor,
      isDeleting: state.isDeleting,
      onEdit: () async {
        final updatedTransaction = await context.push<TransactionModel>(
          AppRoutes.updateTransaction,
          extra: transaction,
        );
        if (!mounted || updatedTransaction == null) {
          return;
        }
        ref
            .read(detailTransactionNotifierProvider.notifier)
            .setTransaction(updatedTransaction);
      },
      onDelete: () {
        ref
            .read(detailTransactionNotifierProvider.notifier)
            .deleteTransaction(transaction.transactionId);
      },
    );
  }
}
