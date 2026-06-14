import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class TransactionDetailCard extends StatelessWidget {
  const TransactionDetailCard({
    super.key,
    required this.selectedDate,
    required this.noteController,
    required this.enabled,
    required this.onSelectDate,
    required this.onPickImage,
    this.noteHint,
    this.previewBytes,
    this.hasExistingImage = false,
    this.onRemoveImage,
  });

  static const int _noteMaxLength = 120;

  final DateTime selectedDate;
  final TextEditingController noteController;
  final bool enabled;
  final VoidCallback onSelectDate;
  final VoidCallback onPickImage;
  final String? noteHint;
  final Uint8List? previewBytes;
  final bool hasExistingImage;
  final VoidCallback? onRemoveImage;

  bool get _hasImage => previewBytes != null || hasExistingImage;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 8.h),
            blurRadius: 24.r,
            color: Colors.black.withValues(alpha: 0.04),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          _DateRow(date: selectedDate, enabled: enabled, onTap: onSelectDate),
          const _Divider(),
          _NoteRow(
            controller: noteController,
            maxLength: _noteMaxLength,
            enabled: enabled,
            noteHint: noteHint,
          ),
          const _Divider(),
          _ImageRow(hasImage: _hasImage, enabled: enabled, onTap: onPickImage),
          if (_hasImage)
            _ImagePreview(
              bytes: previewBytes,
              hasExistingImage: hasExistingImage,
              enabled: enabled,
              onRemove: onRemoveImage,
            ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Divider(
      height: 0.5,
      thickness: 0.5,
      color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
    );
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.date,
    required this.enabled,
    required this.onTap,
  });

  final DateTime date;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    final formatted = DateFormat('EEE, d MMM').format(date);
    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        child: Row(
          children: [
            const _RowIcon(emoji: '📅'),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                s.transactionDateRowLabel,
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.subtitleSmall,
                  weight: FontWeight.w600,
                  color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                ),
              ),
            ),
            Text(
              formatted,
              style: AppTextStyleFactory.style(
                size: AppFontSizes.subtitleSmall,
                weight: FontWeight.w700,
                color: AppTheme.primary,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              '›',
              style: AppTextStyleFactory.style(
                size: AppFontSizes.titleSmall,
                weight: FontWeight.w400,
                color: AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteRow extends StatelessWidget {
  const _NoteRow({
    required this.controller,
    required this.maxLength,
    required this.enabled,
    this.noteHint,
  });

  final TextEditingController controller;
  final int maxLength;
  final bool enabled;
  final String? noteHint;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _RowIcon(emoji: '📝'),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        s.transactionNoteLabel,
                        style: AppTextStyleFactory.style(
                          size: AppFontSizes.subtitleSmall,
                          weight: FontWeight.w600,
                          color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                        ),
                      ),
                    ),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller,
                      builder: (_, value, __) => Text(
                        '${value.text.length}/$maxLength',
                        style: AppTextStyleFactory.style(
                          size: AppFontSizes.captionBig,
                          weight: FontWeight.w600,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppTheme.backgroundDark
                        : AppTheme.backgroundLight,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                    ),
                  ),
                  child: TextField(
                    controller: controller,
                    enabled: enabled,
                    maxLines: 2,
                    maxLength: maxLength,
                    style: AppTextStyleFactory.style(
                      size: AppFontSizes.subtitleSmall,
                      weight: FontWeight.w400,
                      color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: noteHint ?? s.updateTransactionNoteHint,
                      hintStyle: AppTextStyleFactory.style(
                        size: AppFontSizes.subtitleSmall,
                        weight: FontWeight.w400,
                        color: AppTheme.textMuted,
                      ),
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageRow extends StatelessWidget {
  const _ImageRow({
    required this.hasImage,
    required this.enabled,
    required this.onTap,
  });

  final bool hasImage;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        child: Row(
          children: [
            const _RowIcon(emoji: '📷'),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                s.transactionEvidenceRowLabel,
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.subtitleSmall,
                  weight: FontWeight.w600,
                  color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                ),
              ),
            ),
            Text(
              hasImage
                  ? s.transactionEvidenceReplaceAction
                  : s.transactionEvidenceAddAction,
              style: AppTextStyleFactory.style(
                size: AppFontSizes.subtitleSmall,
                weight: FontWeight.w500,
                color: AppTheme.textMuted,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              '›',
              style: AppTextStyleFactory.style(
                size: AppFontSizes.titleSmall,
                weight: FontWeight.w400,
                color: AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({
    required this.hasExistingImage,
    required this.enabled,
    this.bytes,
    this.onRemove,
  });

  final Uint8List? bytes;
  final bool hasExistingImage;
  final bool enabled;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
        color: isDark ? AppTheme.darkSurfaceVariant : AppTheme.surfaceLightGrey,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (bytes != null)
            // Full-width preview — decode to screen width to keep it sharp.
            Image.memory(
              bytes!,
              fit: BoxFit.cover,
              cacheWidth: decodePixelsFor(
                context,
                MediaQuery.sizeOf(context).width,
              ),
            )
          else
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.image_outlined, size: 32.r, color: AppTheme.primary),
                  SizedBox(height: 4.h),
                  Text(
                    context.l10n.transactionEvidenceAttachedLabel,
                    style: AppTextStyleFactory.style(
                      size: AppFontSizes.bodyMedium,
                      weight: FontWeight.w500,
                      color: AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
            ),
          if (onRemove != null)
            Positioned(
              top: 8.h,
              right: 8.w,
              child: GestureDetector(
                onTap: enabled ? onRemove : null,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      width: 28.r,
                      height: 28.r,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, color: Colors.white, size: 14.r),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RowIcon extends StatelessWidget {
  const _RowIcon({required this.emoji});
  final String emoji;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 36.r,
      height: 36.r,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurfaceVariant : AppTheme.surfaceLightGrey,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(child: Text(emoji, style: TextStyle(fontSize: 18.sp))),
    );
  }
}
