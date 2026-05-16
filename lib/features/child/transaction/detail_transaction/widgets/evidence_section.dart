import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_provider.dart';
import 'package:monikid/features/child/transaction/detail_transaction/detail_transaction_state.dart';

class EvidenceSection extends ConsumerWidget {
  const EvidenceSection({super.key, required this.state, required this.isDark});

  final DetailTransactionState state;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = state.transaction!;
    final hasLegacyEvidencePath = _hasLegacyEvidencePath(
      transaction.evidenceImage?.storagePath,
    );
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
            EvidenceEmptyState(isDark: isDark)
          else if (state.isResolvingEvidenceImage)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CircularProgressIndicator(),
              ),
            )
          else if (state.evidenceImageUrl == null)
            EvidenceErrorState(
              errorMessage: hasLegacyEvidencePath
                  ? s.transactionEvidenceLegacyUnavailable
                  : state.evidenceImageErrorMessage,
              onRetry: hasLegacyEvidencePath
                  ? null
                  : () => ref
                        .read(detailTransactionNotifierProvider.notifier)
                        .retryEvidenceImage(),
            )
          else ...[
            GestureDetector(
              onTap: () => _showEvidenceImageViewer(
                context,
                imageUrl: state.evidenceImageUrl!,
                fileName: transaction.evidenceImage?.fileName,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  state.evidenceImageUrl!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const BrokenImagePlaceholder();
                  },
                ),
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

  bool _hasLegacyEvidencePath(String? storagePath) {
    final trimmedStoragePath = storagePath?.trim();
    if (trimmedStoragePath == null || trimmedStoragePath.isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(trimmedStoragePath);
    if (uri == null) {
      return true;
    }

    return uri.scheme != 'https' && uri.scheme != 'http';
  }

  Future<void> _showEvidenceImageViewer(
    BuildContext context, {
    required String imageUrl,
    String? fileName,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) => EvidenceImageViewerDialog(
        imageUrl: imageUrl,
        fileName: fileName,
      ),
    );
  }
}

class EvidenceEmptyState extends StatelessWidget {
  const EvidenceEmptyState({super.key, required this.isDark});

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

class EvidenceErrorState extends StatelessWidget {
  const EvidenceErrorState({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  final String? errorMessage;
  final VoidCallback? onRetry;

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
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(s.actionRetry),
            ),
          ],
        ],
      ),
    );
  }
}

class BrokenImagePlaceholder extends StatelessWidget {
  const BrokenImagePlaceholder({super.key});

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

class EvidenceImageViewerDialog extends StatelessWidget {
  const EvidenceImageViewerDialog({
    super.key,
    required this.imageUrl,
    this.fileName,
  });

  final String imageUrl;
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    final labelColor = Colors.white.withValues(alpha: 0.8);

    return Dialog.fullscreen(
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.black,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4,
                  child: Center(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const BrokenImagePlaceholder();
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Material(
                  color: Colors.black.withValues(alpha: 0.4),
                  shape: const CircleBorder(),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              if (fileName != null)
                Positioned(
                  bottom: 24,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      fileName!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: labelColor, fontSize: 14),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
