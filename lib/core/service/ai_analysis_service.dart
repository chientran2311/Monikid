import 'package:monikid/models/ai/transaction_ai_result.dart';
import 'package:monikid/models/entities/category_model.dart';

abstract class AiAnalysisService {
  Future<TransactionAiResult?> analyzeReceipt(
    String ocrText,
    List<CategoryModel> categories,
  );
}
