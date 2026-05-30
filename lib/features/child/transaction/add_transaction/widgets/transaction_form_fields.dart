import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class TransactionFormFields extends StatelessWidget {
  const TransactionFormFields({
    required this.selectedDate,
    required this.noteController,
    required this.evidenceImageBytes,
    required this.evidenceImageFileName,
    required this.hasEvidenceImageSelection,
    required this.onDateTap,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.isDark,
    required this.surfaceColor,
    required this.textColor,
    required this.enabled,
    super.key,
  });

  final DateTime selectedDate;
  final TextEditingController noteController;
  final List<int>? evidenceImageBytes;
  final String? evidenceImageFileName;
  final bool hasEvidenceImageSelection;
  final VoidCallback onDateTap;
  final VoidCallback onPickImage;
  final VoidCallback? onRemoveImage;
  final bool isDark;
  final Color surfaceColor;
  final Color textColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: borderColor),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              offset: Offset(0, 8.h),
              blurRadius: 24.r,
              color: Colors.black.withValues(alpha: 0.04),
            ),
        ],
      ),
      child: Column(
        children: [
          _DateRow(
            selectedDate: selectedDate,
            onTap: enabled ? onDateTap : () {},
            textColor: textColor,
            isDark: isDark,
          ),
          Divider(height: 0.5.h, thickness: 0.5, color: borderColor),
          _NoteRow(
            controller: noteController,
            enabled: enabled,
            textColor: textColor,
            isDark: isDark,
          ),
          Divider(height: 0.5.h, thickness: 0.5, color: borderColor),
          _PhotoSection(
            evidenceImageBytes: evidenceImageBytes != null
                ? Uint8List.fromList(evidenceImageBytes!)
                : null,
            hasEvidenceImageSelection: hasEvidenceImageSelection,
            enabled: enabled,
            onPickImage: onPickImage,
            onRemoveImage: onRemoveImage,
            isDark: isDark,
            textColor: textColor,
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
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: AppTheme.surfaceLightGrey,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: Text(emoji, style: TextStyle(fontSize: 18.sp)),
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.selectedDate,
    required this.onTap,
    required this.textColor,
    required this.isDark,
  });

  final DateTime selectedDate;
  final VoidCallback onTap;
  final Color textColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final now = DateTime.now();
    final isToday = selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
    final displayDate = isToday
        ? s.transactionDateToday
        : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
          child: Row(
            children: [
              const _RowIcon(emoji: '📅'),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  s.transactionDateLabel,
                  style: context.typo.body.big.copyWith(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    displayDate,
                    style: context.typo.body.big.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primary,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '›',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoteRow extends StatelessWidget {
  const _NoteRow({
    required this.controller,
    required this.enabled,
    required this.textColor,
    required this.isDark,
  });

  final TextEditingController controller;
  final bool enabled;
  final Color textColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    final bgColor =
        isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight;
    final borderColor = isDark ? AppTheme.borderDark : AppTheme.borderLight;

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      s.transactionNoteLabel,
                      style: context.typo.body.big.copyWith(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller,
                      builder: (_, value, __) => Text(
                        '${value.text.length}/120',
                        style: context.typo.caption.big.copyWith(
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: borderColor),
                  ),
                  child: TextField(
                    controller: controller,
                    enabled: enabled,
                    maxLength: 120,
                    maxLines: 2,
                    style:
                        context.typo.body.medium.copyWith(color: textColor),
                    decoration: InputDecoration(
                      hintText: s.addTransactionNoteHint,
                      hintStyle: context.typo.body.medium.copyWith(
                        color: AppTheme.textMuted,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 10.h,
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

class _PhotoSection extends StatelessWidget {
  const _PhotoSection({
    required this.evidenceImageBytes,
    required this.hasEvidenceImageSelection,
    required this.enabled,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.isDark,
    required this.textColor,
  });

  final Uint8List? evidenceImageBytes;
  final bool hasEvidenceImageSelection;
  final bool enabled;
  final VoidCallback onPickImage;
  final VoidCallback? onRemoveImage;
  final bool isDark;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onPickImage : null,
            borderRadius: hasEvidenceImageSelection
                ? BorderRadius.zero
                : BorderRadius.only(
                    bottomLeft: Radius.circular(24.r),
                    bottomRight: Radius.circular(24.r),
                  ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
              child: Row(
                children: [
                  const _RowIcon(emoji: '📷'),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      s.transactionReceiptLabel,
                      style: context.typo.body.big.copyWith(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        hasEvidenceImageSelection
                            ? s.transactionChangePhoto
                            : s.transactionAddPhoto,
                        style: context.typo.body.big.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textMuted,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '›',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (evidenceImageBytes != null)
          _ImagePreviewFilled(
            bytes: evidenceImageBytes!,
            onRemove: enabled ? onRemoveImage : null,
          )
        else
          _ImagePreviewEmpty(isDark: isDark),
      ],
    );
  }
}

class _ImagePreviewEmpty extends StatelessWidget {
  const _ImagePreviewEmpty({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    return Container(
      margin: EdgeInsets.fromLTRB(18.w, 0, 18.w, 16.h),
      height: 120.h,
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.surfaceVeryDark
            : AppTheme.surfaceLightGrey,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('📸', style: TextStyle(fontSize: 28.sp)),
          SizedBox(height: 8.h),
          Text(
            s.transactionReceiptEmptyTitle,
            style: context.typo.body.small.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppTheme.textMuted : AppTheme.textGrey,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            s.transactionReceiptScanHint,
            style: context.typo.caption.big.copyWith(
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagePreviewFilled extends StatelessWidget {
  const _ImagePreviewFilled({required this.bytes, this.onRemove});

  final Uint8List bytes;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(18.w, 0, 18.w, 16.h),
      height: 140.h,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Image.memory(
              bytes,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          if (onRemove != null)
            Positioned(
              top: 8.h,
              right: 8.w,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 14.r),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
