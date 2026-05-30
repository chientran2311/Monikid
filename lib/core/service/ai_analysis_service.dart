import 'package:monikid/models/ai/receipt_scan/receipt_ocr_result.dart';
import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/models/entities/category_model.dart';

abstract class AiAnalysisService {
  Future<TransactionAiResult?> analyzeReceipt(
    ReceiptOcrResult ocrResult,
    List<CategoryModel> categories,
  );
}
