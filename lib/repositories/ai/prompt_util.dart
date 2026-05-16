import 'dart:convert';

import 'package:monikid/models/ai/receipt_scan/receipt_category_option.dart';

const String kReceiptAnalysisSystemInstruction = '''
You are a financial assistant that processes receipts.

STRICT RULES:
- You MUST choose EXACTLY ONE category from the provided list
- Do NOT invent new categories
- If unsure, choose the closest category
- Output MUST be valid JSON only
- Return ONLY JSON. No explanation, no extra text
''';

String buildReceiptAnalysisPrompt({
  required String ocrText,
  required String languageCode,
  required List<ReceiptCategoryOption> categories,
}) {
  final languageLabel = _languageLabel(languageCode);
  final categoriesJson = jsonEncode(
    categories.map((category) => category.toJson()).toList(growable: false),
  );

  return '''
CATEGORIES:
$categoriesJson

TASK:
Analyze the transaction text and all content from OCR and:
1. Determine the final amount in minor units as an integer and return it in "amount_minor"
2. Choose the most appropriate category key from the list and return it in "category"
3. Determine the transaction date and return it in "transaction_date"
4. Write a short $languageLabel description that summarizes how much was spent for what on which date

TRANSACTION:
"""
$ocrText
"""

OUTPUT FORMAT:
{
  "category": "one_of_the_list",
  "description": "short sentence",
  "amount_minor": 50000,
  "transaction_date": "2026-04-23"
}
''';
}

String _languageLabel(String languageCode) {
  switch (languageCode.trim().toLowerCase()) {
    case 'vi':
      return 'Vietnamese';
    case 'en':
      return 'English';
    default:
      return languageCode.trim();
  }
}

/// Builds a prompt in Gemma 2B instruction-following format.
///
/// flutter_gemma has no systemInstruction param, so it is embedded inline.
String buildLocalGemmaPrompt({
  required String ocrText,
  required String languageCode,
  required List<ReceiptCategoryOption> categories,
}) {
  return '<start_of_turn>user\n'
      '$kReceiptAnalysisSystemInstruction\n\n'
      '${buildReceiptAnalysisPrompt(ocrText: ocrText, languageCode: languageCode, categories: categories)}'
      '<end_of_turn>\n'
      '<start_of_turn>model\n';
}
