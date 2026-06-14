import 'dart:convert';

import 'package:flutter_gemma/flutter_gemma.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_category_option.dart';
import 'package:monikid/models/ai/receipt_scan/receipt_ocr_result.dart';
import 'package:monikid/models/entities/category_model.dart';

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

/// System instruction for local on-device model — passed via [createChat(systemInstruction:)].
///
/// Compact form to save context tokens. Category keyword hints guide the model
/// toward correct IDs without seeing the full list; the full dynamic list is
/// still injected per-request by [buildLocalGemmaPrompt] for exact ID matching.
const String kLocalGemmaSystemInstruction =
    'Vietnamese bank TX classifier. Output ONLY valid JSON, no markdown.\n'
    'amount_minor=copy "amount" as int VND; transaction_date="YYYY-MM-DD" from "date".\n'
    'description=short Vietnamese "Verb+object+amount" (e.g."Ăn trưa 45.000đ","Nhận lương 5.000.000đ"). Never copy dates/times.\n'
    'category=the NUMBER of the best-matching item in the CATEGORIES list (output the integer index only, e.g. 3). '
    'Match (chi)=expense, (thu)=income by meaning: '
    'ăn/cơm/phở/café/food/quán/baemin→food; grab/xe/xăng/taxi/bus/vé→transport; '
    'shopee/lazada/tiki/mua/order→shopping; học phí/sách/trường→education; '
    'thuốc/bệnh viện/phòng khám→health; game/rạp/karaoke/netflix→entertainment; '
    'điện/nước/internet/wifi/tiền nhà/gas→utilities; lương/salary/thưởng/nhận lương→salary income. '
    'Pick the closest item; use the generic "khác" item only if unsure.\n'
    'OUTPUT: {"amount_minor":45000,"category":3,"description":"Ăn trưa 45.000đ","transaction_date":"2026-05-17"}';

/// Builds the user-turn prompt for the local on-device model.
///
/// Injects the full category list (default + custom from Firebase) so the
/// model chooses a real category ID — not a hardcoded semantic key.
/// Three diverse few-shot examples use default IDs so the model learns
/// the ID format before seeing custom UUIDs in the live category list.
String buildLocalGemmaPrompt({
  required ReceiptOcrResult ocrResult,
  required String languageCode,
  required ModelType modelType,
  required List<CategoryModel> categories,
}) {
  final context = _buildGemmaContext(ocrResult);
  // Numbered list — the model outputs the index, NOT the id. Small on-device
  // models cannot reliably copy long/UUID category ids, so we ask for the
  // integer position and map it back to the real id in Dart. Dropping the ids
  // also shortens the prompt (fewer prefill tokens → KV-cache headroom).
  final categoryList = StringBuffer();
  for (var i = 0; i < categories.length; i++) {
    final c = categories[i];
    final kind = c.type == 'income' ? 'thu' : 'chi';
    categoryList.write('${i + 1}:${c.label}($kind)\n');
  }

  // Point the few-shot examples at real list positions so the example number
  // is consistent with the labeled list the model sees this request.
  final expenseNo = _categoryNumber(categories, idHint: 'an-uong', type: 'expense');
  final incomeNo = _categoryNumber(categories, idHint: 'luong', type: 'income');

  return 'CATEGORIES:\n$categoryList'
      'IN:{"amount":45000,"description":"tien an trua","date":"2026-05-17"}\n'
      'OUT:{"amount_minor":45000,"category":$expenseNo,"description":"Ăn trưa 45.000đ","transaction_date":"2026-05-17"}\n'
      'IN:{"amount":5000000,"raw":"Cong ty ABC chuyen luong thang 5","date":"2026-05-31"}\n'
      'OUT:{"amount_minor":5000000,"category":$incomeNo,"description":"Nhận lương tháng 5 5.000.000đ","transaction_date":"2026-05-31"}\n'
      'IN:$context\n'
      'OUT:';
}

/// Returns the 1-based position of a representative category for few-shot
/// examples: prefers a default id containing [idHint], else the first category
/// of [type], else 1. Never returns an out-of-range value.
int _categoryNumber(
  List<CategoryModel> categories, {
  required String idHint,
  required String type,
}) {
  var index = categories.indexWhere((c) => c.id.contains(idHint));
  if (index < 0) index = categories.indexWhere((c) => c.type == type);
  if (index < 0) index = 0;
  return index + 1;
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

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

/// Compact context for Gemma/Gemma4 on-device model.
///
/// Includes truncated raw OCR text as the primary context for category and
/// description inference — without it the model gets only amount+date and
/// must hallucinate both fields. recipient_name is excluded (OCR noise).
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
  // Raw OCR text is the main signal for category and description when the
  // structured fields are absent or sparse. Capped at 300 chars to keep
  // prompt tokens low for on-device inference.
  if (r.rawText.isNotEmpty) {
    final raw = r.rawText
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .join(' ');
    map['raw'] = raw.length > 300 ? '${raw.substring(0, 300)}...' : raw;
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
