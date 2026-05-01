import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';

class TransactionEvidenceSection extends StatelessWidget {
  const TransactionEvidenceSection({
    super.key,
    required this.isDark,
    required this.surfaceColor,
    required this.enabled,
    required this.onPickImage,
    this.previewBytes,
    this.selectedFileName,
    this.hasExistingImage = false,
    this.existingFileName,
    this.onRemoveImage,
  });

  final bool isDark;
  final Color surfaceColor;
  final bool enabled;
  final VoidCallback onPickImage;
  final Uint8List? previewBytes;
  final String? selectedFileName;
  final bool hasExistingImage;
  final String? existingFileName;
  final VoidCallback? onRemoveImage;

  bool get hasPreview => previewBytes != null;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark
        ? const Color(0xFF334155)
        : const Color(0xFFE2E8F0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.transactionEvidenceAddOptionalLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasPreview)
                _PreviewImage(bytes: previewBytes!)
              else
                _EmptyPreview(
                  isDark: isDark,
                  hasExistingImage: hasExistingImage,
                ),
              const SizedBox(height: 12),
              Text(
                _buildDescription(),
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? const Color(0xFFCBD5E1)
                      : const Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: enabled ? onPickImage : null,
                      icon: Icon(
                        hasPreview || hasExistingImage
                            ? Icons.sync_outlined
                            : Icons.add_photo_alternate_outlined,
                      ),
                      label: Text(s.transactionEvidenceUploadAction),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  if (onRemoveImage != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: enabled ? onRemoveImage : null,
                        icon: const Icon(Icons.delete_outline),
                        label: Text(s.transactionEvidenceRemoveAction),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          foregroundColor: AppTheme.redAlert,
                          side: const BorderSide(color: AppTheme.redAlert),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _buildDescription() {
    if (hasPreview) {
      final fileName = selectedFileName;
      if (fileName != null && fileName.isNotEmpty) {
        return '${s.transactionEvidenceSelectedLabel}: $fileName';
      }
      return s.transactionEvidenceSelectedLabel;
    }

    if (hasExistingImage) {
      final fileName = existingFileName;
      if (fileName != null && fileName.isNotEmpty) {
        return '${s.transactionEvidenceAttachedLabel}: $fileName';
      }
      return s.transactionEvidenceAttachedLabel;
    }

    return s.transactionEvidenceOptionalLabel;
  }
}

class _PreviewImage extends StatelessWidget {
  const _PreviewImage({required this.bytes});

  final Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.memory(
        bytes,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _EmptyPreview extends StatelessWidget {
  const _EmptyPreview({required this.isDark, required this.hasExistingImage});

  final bool isDark;
  final bool hasExistingImage;

  @override
  Widget build(BuildContext context) {
    final bgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
    final iconColor = hasExistingImage
        ? AppTheme.primary
        : const Color(0xFF94A3B8);

    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            hasExistingImage
                ? Icons.image_outlined
                : Icons.image_search_outlined,
            size: 36,
            color: iconColor,
          ),
          const SizedBox(height: 8),
          Text(
            hasExistingImage
                ? s.transactionEvidenceAttachedLabel
                : s.transactionEvidenceEmpty,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }
}
