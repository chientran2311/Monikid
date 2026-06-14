import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';
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
      transaction.evidenceImage?.imageUrl,
    );
    final bgColor = isDark ? AppTheme.surfaceVariant : AppTheme.surfaceLightGrey;
    final labelColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final iconColor = isDark ? AppTheme.textWhite : AppTheme.textBlack;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                alignment: Alignment.center,
                child: Icon(Icons.camera_alt_rounded, size: 18.r, color: iconColor),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: Text(
                    s.transactionEvidenceSectionTitle,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: labelColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 16.h),
          child: _buildContent(context, ref, transaction, hasLegacyEvidencePath),
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    dynamic transaction,
    bool hasLegacyEvidencePath,
  ) {
    if (!state.hasEvidenceImage) return EvidenceEmptyState(isDark: isDark);
    if (state.isResolvingEvidenceImage) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state.evidenceImageUrl == null) {
      return EvidenceErrorState(
        errorMessage: hasLegacyEvidencePath
            ? s.transactionEvidenceLegacyUnavailable
            : state.evidenceImageErrorMessage,
        onRetry: hasLegacyEvidencePath
            ? null
            : () => ref
                  .read(detailTransactionNotifierProvider.notifier)
                  .retryEvidenceImage(),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showEvidenceImageViewer(
            context,
            imageUrl: state.evidenceImageUrl!,
            fileName: transaction.evidenceImage?.fileName,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Image.network(
              state.evidenceImageUrl!,
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
              cacheWidth: decodePixelsFor(
                context,
                MediaQuery.sizeOf(context).width,
              ),
              errorBuilder: (context, error, stackTrace) {
                return const BrokenImagePlaceholder();
              },
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          transaction.evidenceImage?.fileName ?? s.transactionEvidenceAttachedLabel,
          style: context.typo.body.medium.copyWith(
            color: isDark ? AppTheme.iconLight : AppTheme.textDark,
          ),
        ),
      ],
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
      height: 140.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceVeryDark : AppTheme.surfaceVeryLight,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Center(
        child: Text(
          s.transactionEvidenceEmpty,
          style: context.typo.body.medium.copyWith(
            color: isDark ? AppTheme.iconLight : AppTheme.textGrey,
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVeryLight,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Text(
            errorMessage ?? s.transactionEvidenceLoadError,
            textAlign: TextAlign.center,
            style: context.typo.body.medium.copyWith(color: AppTheme.textGrey),
          ),
          if (onRetry != null) ...[
            SizedBox(height: 12.h),
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
      height: 180.h,
      width: double.infinity,
      color: AppTheme.surfaceVeryLight,
      child: Center(
        child: Text(
          s.transactionEvidenceLoadError,
          style: const TextStyle(
            color: AppTheme.textGrey,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      fileName!,
                      textAlign: TextAlign.center,
                      style: context.typo.body.medium.copyWith(color: labelColor),
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
