import 'dart:convert';

import 'package:monikid/models/ai/receipt_scan/receipt_category_option.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_ocr_result.dart';

const String kReceiptAnalysisSystemInstruction = '''
You are a financial assistant that processes receipts.

STRICT RULES:
- You MUST choose EXACTLY ONE category from the provided list
- Do NOT invent new categories
- If unsure, choose the closest category
- Output MUST be valid JSON only
- Return ONLY JSON. No explanation, no extra text
''';

/// Builds the Gemini prompt. Accepts a [ReceiptOcrResult] and builds a
/// structured JSON context so the model has clean, labelled data rather than
/// raw OCR text.
String buildReceiptAnalysisPrompt({
  required ReceiptOcrResult ocrResult,
  required String languageCode,
  required List<ReceiptCategoryOption> categories,
}) {
  final languageLabel = _languageLabel(languageCode);
  final categoriesJson = jsonEncode(
    categories.map((c) => c.toJson()).toList(growable: false),
  );
  final context = _buildStructuredContext(ocrResult);

  return '''
CATEGORIES:
$categoriesJson

TASK:
Analyze the transaction JSON and:
1. Determine the final amount in minor units as an integer and return it in "amount_minor"
2. Choose the most appropriate category key from the list and return it in "category"
3. Determine the transaction date and return it in "transaction_date"
4. Write a short $languageLabel description that summarizes how much was spent for what on which date

TRANSACTION:
$context

OUTPUT FORMAT:
{
  "category": "one_of_the_list",
  "description": "short sentence",
  "amount_minor": 50000,
  "transaction_date": "2026-04-23"
}
''';
}

/// Builds the local Gemma prompt. Uses a fixed 9-category list and a single
/// few-shot example to keep token count low for the 1B quantised model.
/// Does NOT include raw_lines or recipient_name — only the fields Gemma needs
/// to produce the 4 required output keys.
String buildLocalGemmaPrompt({
  required ReceiptOcrResult ocrResult,
  required String languageCode,
}) {
  final context = _buildGemmaContext(ocrResult);
  // Very explicit schema — the 1B model needs exact key names repeated in the
  // instruction, the example, and the output scaffold to stay on-format.
  return '<start_of_turn>user\n'
      'You are a Vietnamese bank receipt parser.\n'
      'Read the INPUT JSON and return OUTPUT JSON with EXACTLY these 4 keys:\n'
      '  "amount_minor" : integer VND (copy from input "amount")\n'
      '  "category"     : one of [$_kGemmaFixedCategories]\n'
      '  "description"  : short Vietnamese sentence about the transaction\n'
      '  "transaction_date": date string "YYYY-MM-DD" (copy from input "date")\n\n'
      'EXAMPLE\n'
      'INPUT:  {"amount":45000,"description":"tiền ăn trưa","date":"2026-05-17"}\n'
      'OUTPUT: {"amount_minor":45000,"category":"food_drink",'
      '"description":"Ăn trưa 45.000đ","transaction_date":"2026-05-17"}\n\n'
      'INPUT:  $context\n'
      'OUTPUT:\n'
      '<end_of_turn>\n'
      '<start_of_turn>model\n';
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

const _kGemmaFixedCategories =
    'food_drink, transport, shopping, education, health, '
    'entertainment, personal_care, bills_utilities, other_expense';

/// Full structured context for Gemini — includes raw_lines as AI fallback.
String _buildStructuredContext(ReceiptOcrResult r) {
  final map = <String, dynamic>{};
  if (r.amountMinor != null) map['amount'] = r.amountMinor;
  if (r.senderName != null) map['sender_name'] = r.senderName;
  if (r.recipientName != null) map['recipient_name'] = r.recipientName;
  if (r.description != null) map['description'] = r.description;
  if (r.transactionDate != null) {
    map['date'] = r.transactionDate!.toIso8601String().substring(0, 10);
  }
  if (r.conventionHint != null) {
    final hint = <String, dynamic>{};
    if (r.conventionHint!.purpose != null) hint['purpose'] = r.conventionHint!.purpose;
    if (r.conventionHint!.merchant != null) hint['merchant'] = r.conventionHint!.merchant;
    if (r.conventionHint!.categoryHint != null) {
      hint['category_hint'] = r.conventionHint!.categoryHint;
    }
    if (hint.isNotEmpty) map['convention_hint'] = hint;
  }
  // raw_lines gives Gemini fallback context when extraction misses something.
  map['raw_lines'] = r.rawText
      .split('\n')
      .map((l) => l.trim())
      .where((l) => l.isNotEmpty)
      .toList(growable: false);
  return jsonEncode(map);
}

/// Compact context for Gemma — only the 3 fields that map directly to output
/// keys. recipient_name is intentionally excluded: it's OCR noise for a 1B
/// model and doesn't appear in the output schema.
String _buildGemmaContext(ReceiptOcrResult r) {
  final map = <String, dynamic>{};
  if (r.amountMinor != null) map['amount'] = r.amountMinor;
  // Prefer convention hint description over raw OCR description
  final desc = r.conventionHint?.purpose ?? r.description;
  if (desc != null && desc.isNotEmpty) map['description'] = desc;
  if (r.transactionDate != null) {
    map['date'] = r.transactionDate!.toIso8601String().substring(0, 10);
  }
  // Category hint nudges the model without forcing it
  if (r.conventionHint?.categoryHint != null) {
    map['category_hint'] = r.conventionHint!.categoryHint;
  }
  return jsonEncode(map);
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
