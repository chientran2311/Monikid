import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
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

      return ReceiptOcrResult(
        rawText: rawText,
        amountMinor: _extractLargestAmount(rawText),
        transactionDate: _extractDate(rawText),
        merchantName: _extractMerchantName(rawText),
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

  int? _extractLargestAmount(String rawText) {
    final normalizedText = rawText.replaceAll('\n', ' ');
    final candidates = <int>[];

    for (final match in RegExp(
      r'(?<!\d)(\d{1,3}(?:[.,\s]\d{3})+|\d{4,9})(?!\d)',
    ).allMatches(normalizedText)) {
      final digits = match.group(0)?.replaceAll(RegExp(r'[^0-9]'), '');
      if (digits == null || digits.isEmpty) {
        continue;
      }

      final value = int.tryParse(digits);
      if (value != null && value >= 1000) {
        candidates.add(value);
      }
    }

    for (final match in RegExp(
      r'(?<!\d)(\d{1,3})(?:[.,](\d))?\s*[kK]\b',
    ).allMatches(normalizedText)) {
      final whole = int.tryParse(match.group(1) ?? '');
      final decimal = int.tryParse(match.group(2) ?? '') ?? 0;
      if (whole == null) {
        continue;
      }

      candidates.add((whole * 1000) + (decimal * 100));
    }

    if (candidates.isEmpty) {
      return null;
    }

    candidates.sort();
    return candidates.last;
  }

  DateTime? _extractDate(String rawText) {
    final patterns = [
      RegExp(r'\b(\d{1,2})[/-](\d{1,2})[/-](\d{2,4})\b'),
      RegExp(r'\b(\d{4})[/-](\d{1,2})[/-](\d{1,2})\b'),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(rawText);
      if (match == null) {
        continue;
      }

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
        if (year < 100) {
          year += 2000;
        }
        return DateTime(year, month, day);
      } catch (_) {
        continue;
      }
    }

    return null;
  }

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

      if (RegExp(r'^[0-9\s.,:/-]+$').hasMatch(line)) {
        continue;
      }

      return line;
    }

    return lines.isEmpty ? null : lines.first;
  }

  String _previewRawText(String rawText) {
    final normalized = rawText.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (normalized.length <= 300) {
      return normalized;
    }

    return '${normalized.substring(0, 300)}...';
  }
}
