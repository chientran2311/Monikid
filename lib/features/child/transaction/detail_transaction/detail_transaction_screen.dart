import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/currency_formatter.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_provider.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_state.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/detail_transaction_bottom_bar.dart';
import 'package:monikid/features/child/transaction/detail_transaction/widgets/transaction_detail_row.dart';
import 'package:monikid/features/child/transaction/transaction_history/transaction_history_provider.dart';
import 'package:monikid/features/child/transaction/transaction_status.dart';
import 'package:monikid/features/child/transaction/widgets/transaction_loading_skeleton.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class DetailTransactionScreen extends ConsumerStatefulWidget {
  const DetailTransactionScreen({super.key, required this.transactionId});

  final String transactionId;

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
          .initialize(widget.transactionId);
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
        backgroundColor: bgColor.withValues(alpha: 0.95),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor),
          onPressed: state.isDeleting ? null : () => context.pop(),
        ),
        title: Text(
          s.transactionDetailTitle,
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
        return _ErrorState(errorMessage: state.errorMessage);
      case TransactionStatus.ready:
      case TransactionStatus.submitting:
        final transaction = state.transaction;
        if (transaction == null) {
          return Center(child: Text(s.transactionDetailNoData));
        }
        return Stack(
          children: [
            _TransactionContent(state: state, isDark: isDark),
            if (state.isDeleting)
              TransactionDetailLoadingOverlay(isDark: isDark),
          ],
        );
      case TransactionStatus.success:
        return const SizedBox.shrink();
    }
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
        ref
            .read(transactionHistoryProvider.notifier)
            .selectTransaction(transaction);
        await context.push(
          AppRoutes.updateTransactionPath(transaction.transactionId),
        );
      },
      onDelete: () {
        ref
            .read(detailTransactionNotifierProvider.notifier)
            .deleteTransaction();
      },
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.redAlert.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? s.transactionLoadError,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Color(0xFF64748B)),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionContent extends ConsumerWidget {
  const _TransactionContent({required this.state, required this.isDark});

  final DetailTransactionState state;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = state.transaction!;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          _SummaryHeader(transaction: transaction),
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
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              children: [
                TransactionDetailRow(
                  iconData: Icons.calendar_today,
                  label: s.transactionDetailTimeLabel,
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
                TransactionDetailRow(
                  iconData: Icons.account_balance_wallet,
                  label: s.transactionDetailSourceLabel,
                  value:
                      transaction.paymentMethod ??
                      transaction.merchantName ??
                      s.updateTransactionCashWalletValue,
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
                  TransactionDetailRow(
                    iconData: Icons.description_outlined,
                    label: s.transactionDetailNoteLabel,
                    value: transaction.note!,
                    isDark: isDark,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          _EvidenceSection(state: state, isDark: isDark),
        ],
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: transaction.type == 'income'
                ? Colors.green.withValues(alpha: 0.1)
                : AppTheme.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: transaction.type == 'income'
                  ? Colors.green.withValues(alpha: 0.2)
                  : AppTheme.primary.withValues(alpha: 0.1),
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
}

class _EvidenceSection extends ConsumerWidget {
  const _EvidenceSection({required this.state, required this.isDark});

  final DetailTransactionState state;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = state.transaction!;
    final surfaceColor = isDark ? AppTheme.surfaceDark : Colors.white;
    final borderColor = isDark
        ? const Color(0xFF1E293B)
        : const Color(0xFFF1F5F9);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.transactionEvidenceSectionTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 12),
          if (!state.hasEvidenceImage)
            _EvidenceEmptyState(isDark: isDark)
          else if (state.isResolvingEvidenceImage)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CircularProgressIndicator(),
              ),
            )
          else if (state.evidenceImageUrl == null)
            _EvidenceErrorState(
              errorMessage: state.evidenceImageErrorMessage,
              onRetry: () => ref
                  .read(detailTransactionNotifierProvider.notifier)
                  .retryEvidenceImage(),
            )
          else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                state.evidenceImageUrl!,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const _BrokenImagePlaceholder();
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              transaction.evidenceImage?.fileName ??
                  s.transactionEvidenceAttachedLabel,
              style: TextStyle(
                fontSize: 14,
                color: isDark
                    ? const Color(0xFFCBD5E1)
                    : const Color(0xFF475569),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EvidenceEmptyState extends StatelessWidget {
  const _EvidenceEmptyState({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          s.transactionEvidenceEmpty,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}

class _EvidenceErrorState extends StatelessWidget {
  const _EvidenceErrorState({
    required this.errorMessage,
    required this.onRetry,
  });

  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            errorMessage ?? s.transactionEvidenceLoadError,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(s.actionRetry),
          ),
        ],
      ),
    );
  }
}

class _BrokenImagePlaceholder extends StatelessWidget {
  const _BrokenImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      child: Center(
        child: Text(
          s.transactionEvidenceLoadError,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
