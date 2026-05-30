import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_convention_hint.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_ocr_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'receipt_ocr_service.g.dart';

@riverpod
ReceiptOcrService receiptOcrService(Ref ref) {
  return getIt<ReceiptOcrService>();
}

abstract class ReceiptOcrService {
  Future<ReceiptOcrResult?> extractFromImage({required String filePath});
}

class ReceiptOcrServiceImpl implements ReceiptOcrService {
  ReceiptOcrServiceImpl(this._logger);

  final Logger _logger;

  static const _senderLabels = [
    'người gửi',
    'tài khoản nguồn',
    'tên tài khoản',
  ];
  static const _recipientLabels = [
    'người nhận',
    'tên người thụ hưởng',
    'thụ hưởng',
    'tên người nhận',
  ];
  static const _descriptionLabels = [
    'nội dung',
    'nội dung giao dịch',
    'nội dung chuyển khoản',
    'mô tả',
  ];
  static const _amountLabels = [
    'số tiền',
    'tổng tiền',
    'tổng cộng',
    'amount',
  ];

  @override
  Future<ReceiptOcrResult?> extractFromImage({required String filePath}) async {
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      final inputImage = InputImage.fromFilePath(filePath);
      final recognizedText = await recognizer.processImage(inputImage);
      final rawText = recognizedText.text.trim();

      if (rawText.isEmpty) {
        _logger.w('OCR returned empty text for receipt image: $filePath.');
        return null;
      }

      _logger.d(
        'OCR extracted text successfully. '
        'filePath=$filePath '
        'rawTextLength=${rawText.length} '
        'rawTextPreview=${_previewRawText(rawText)}',
      );

      final lines = rawText
          .split('\n')
          .map((l) => l.trim())
          .where((l) => l.isNotEmpty)
          .toList(growable: false);

      final fields = _extractKeyValueFields(lines);
      final description = fields['description'];

      return ReceiptOcrResult(
        rawText: rawText,
        amountMinor: _extractAmount(lines),
        transactionDate: _extractDate(rawText),
        merchantName: _extractMerchantName(rawText),
        senderName: fields['sender'],
        recipientName: fields['recipient'],
        description: description,
        conventionHint: _parseConventionHint(description),
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to extract receipt text with ML Kit.',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    } finally {
      await recognizer.close();
    }
  }

  // ---------------------------------------------------------------------------
  // Amount extraction — currency-marker proximity first, label fallback second.
  // Account numbers (≥13 consecutive digits) are always blocked.
  // ---------------------------------------------------------------------------

  int? _extractAmount(List<String> lines) {
    final currencyLine = RegExp(
      r'(?:VND|đồng|đ)',
      caseSensitive: false,
    );
    final amountInText = RegExp(r'(\d[\d\s,.]*\d|\d{4,})');

    // Strategy 1: line contains a currency marker.
    for (final line in lines) {
      if (!currencyLine.hasMatch(line)) continue;
      final value = _largestValidAmount(amountInText.allMatches(line));
      if (value != null) return value;
    }

    // Strategy 2: line contains an amount label.
    final labelPattern = RegExp(
      _amountLabels.map(RegExp.escape).join('|'),
      caseSensitive: false,
    );
    for (int i = 0; i < lines.length; i++) {
      if (!labelPattern.hasMatch(lines[i])) continue;
      final searchLines = [lines[i], if (i + 1 < lines.length) lines[i + 1]];
      for (final l in searchLines) {
        final value = _largestValidAmount(amountInText.allMatches(l));
        if (value != null) return value;
      }
    }

    // Strategy 3: fallback — largest number that is not an account number.
    final candidates = <int>[];
    for (final line in lines) {
      for (final match in amountInText.allMatches(line)) {
        final digits = match.group(0)!.replaceAll(RegExp(r'[^0-9]'), '');
        if (digits.length >= 13) continue;
        final value = int.tryParse(digits);
        if (value != null && value >= 1000) candidates.add(value);
      }
    }
    if (candidates.isEmpty) return null;
    candidates.sort();
    return candidates.last;
  }

  int? _largestValidAmount(Iterable<RegExpMatch> matches) {
    int? best;
    for (final match in matches) {
      final digits = match.group(0)!.replaceAll(RegExp(r'[^0-9]'), '');
      if (digits.length >= 13) continue;
      final value = int.tryParse(digits);
      if (value != null && value >= 1000) {
        if (best == null || value > best) best = value;
      }
    }
    return best;
  }

  // ---------------------------------------------------------------------------
  // Key-value field extraction — scan label/value pairs common in VN banking.
  // ---------------------------------------------------------------------------

  Map<String, String?> _extractKeyValueFields(List<String> lines) {
    String? sender, recipient, description;

    final senderPattern = RegExp(
      _senderLabels.map(RegExp.escape).join('|'),
      caseSensitive: false,
    );
    final recipientPattern = RegExp(
      _recipientLabels.map(RegExp.escape).join('|'),
      caseSensitive: false,
    );
    final descriptionPattern = RegExp(
      _descriptionLabels.map(RegExp.escape).join('|'),
      caseSensitive: false,
    );

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final next = i + 1 < lines.length ? lines[i + 1] : null;

      // Prefer value on the same line after a colon; fallback to next line.
      String? valueFor(RegExp pattern) {
        if (!pattern.hasMatch(line)) return null;
        final colonIdx = line.indexOf(':');
        if (colonIdx != -1) {
          final inline = line.substring(colonIdx + 1).trim();
          if (inline.isNotEmpty) return inline;
        }
        return next?.isNotEmpty == true ? next : null;
      }

      sender ??= valueFor(senderPattern);
      recipient ??= valueFor(recipientPattern);
      description ??= valueFor(descriptionPattern);

      if (sender != null && recipient != null && description != null) break;
    }

    return {
      'sender': sender,
      'recipient': recipient,
      'description': description,
    };
  }

  // ---------------------------------------------------------------------------
  // Convention hint parser — detects user-encoded description patterns.
  // Format: "[purpose], [merchant], ?[category_hint]"
  // All parts are optional. Triggers on presence of ',' or '?'.
  // ---------------------------------------------------------------------------

  ReceiptConventionHint? _parseConventionHint(String? description) {
    if (description == null) return null;
    final hasComma = description.contains(',');
    final hasQuestion = description.contains('?');
    if (!hasComma && !hasQuestion) return null;

    String? purpose, merchant, categoryHint;

    if (hasQuestion) {
      final qIdx = description.indexOf('?');
      categoryHint = description.substring(qIdx + 1).trim();
      if (categoryHint.isEmpty) categoryHint = null;

      final before = description.substring(0, qIdx);
      final parts = before
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(growable: false);
      if (parts.length >= 2) {
        purpose = parts[0];
        merchant = parts[1];
      } else if (parts.length == 1) {
        merchant = parts[0];
      }
    } else {
      // Only comma, no '?'.
      final parts = description
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList(growable: false);
      if (parts.length >= 2) {
        purpose = parts[0];
        merchant = parts[1];
      }
    }

    if (purpose == null && merchant == null && categoryHint == null) return null;
    return ReceiptConventionHint(
      purpose: purpose,
      merchant: merchant,
      categoryHint: categoryHint,
    );
  }

  // ---------------------------------------------------------------------------
  // Date extraction — unchanged from original.
  // ---------------------------------------------------------------------------

  DateTime? _extractDate(String rawText) {
    final patterns = [
      RegExp(r'\b(\d{1,2})[/-](\d{1,2})[/-](\d{2,4})\b'),
      RegExp(r'\b(\d{4})[/-](\d{1,2})[/-](\d{1,2})\b'),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(rawText);
      if (match == null) continue;

      try {
        if (pattern.pattern.startsWith(r'\b(\d{4})')) {
          final year = int.parse(match.group(1)!);
          final month = int.parse(match.group(2)!);
          final day = int.parse(match.group(3)!);
          return DateTime(year, month, day);
        }

        final day = int.parse(match.group(1)!);
        final month = int.parse(match.group(2)!);
        var year = int.parse(match.group(3)!);
        if (year < 100) year += 2000;
        return DateTime(year, month, day);
      } catch (_) {
        continue;
      }
    }

    return null;
  }

  // ---------------------------------------------------------------------------
  // Merchant name extraction — kept for backward compatibility.
  // ---------------------------------------------------------------------------

  String? _extractMerchantName(String rawText) {
    final lines = rawText
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList(growable: false);

    for (final line in lines) {
      final normalized = line.toLowerCase();
      if (normalized.contains('total') ||
          normalized.contains('tong') ||
          normalized.contains('cash') ||
          normalized.contains('change') ||
          normalized.contains('tax')) {
        continue;
      }

      if (RegExp(r'^[0-9\s.,:/-]+$').hasMatch(line)) continue;

      return line;
    }

    return lines.isEmpty ? null : lines.first;
  }

  String _previewRawText(String rawText) {
    final normalized = rawText.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (normalized.length <= 300) return normalized;
    return '${normalized.substring(0, 300)}...';
  }
}
