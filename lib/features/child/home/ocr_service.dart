import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/upload_or_take_picture/upload_pic_provider.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_ocr_result.dart';
import 'package:monikid/repositories/ai/receipt_ocr_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ocr_service.g.dart';

@riverpod
HomeReceiptOcrService homeReceiptOcrService(Ref ref) {
  return HomeReceiptOcrService(
    ocrService: ref.read(receiptOcrServiceProvider),
    logger: getIt<Logger>(),
  );
}

class HomeReceiptOcrService {
  HomeReceiptOcrService({
    required ReceiptOcrService ocrService,
    required Logger logger,
  }) : _ocrService = ocrService,
       _logger = logger;

  final ReceiptOcrService _ocrService;
  final Logger _logger;

  Future<ReceiptOcrResult?> scan(TransactionImageSelection selection) async {
    _logger.i('Start home receipt OCR. file=${selection.fileName}');
    final startedAt = DateTime.now();

    final result = await _ocrService.extractFromImage(
      filePath: selection.filePath,
    );

    final elapsedMs = DateTime.now().difference(startedAt).inMilliseconds;
    if (result == null) {
      _logger.w(
        'Home receipt OCR returned no result. '
        'file=${selection.fileName} '
        'elapsedMs=$elapsedMs',
      );
      return null;
    }

    _logger.d(
      'Home receipt OCR completed. '
      'file=${selection.fileName} '
      'elapsedMs=$elapsedMs '
      'amountMinor=${result.amountMinor} '
      'transactionDate=${result.transactionDate?.toIso8601String()} '
      'merchantName=${result.merchantName} '
      'rawTextLength=${result.rawText.length}',
    );
    return result;
  }
}
