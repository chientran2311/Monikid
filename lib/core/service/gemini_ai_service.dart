import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/secure_storage.dart';

class GeminiAiService {
  GeminiAiService({Logger? logger}) : _logger = logger ?? Logger() {
    _secureStorage = getIt<AppSecureStorage>();
  }

  final Logger _logger;
  late final AppSecureStorage _secureStorage;

  /// Sends a minimal test request with [apiKey] (not yet stored) to verify it
  /// is valid and has API access. Throws [InvalidApiKey] or
  /// [UnsupportedUserLocation] on auth failures, or a network exception on
  /// connectivity issues.
  Future<void> validateApiKey(String apiKey) async {
    _logger.i('GeminiAiService.validateApiKey: testing key...');
    final model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
    );
    await model.generateContent([Content.text('hi')]);
    _logger.i('GeminiAiService.validateApiKey: key is valid.');
  }

  Future<String?> getStoredApiKey() async {
    final apiKey = await _secureStorage.read(StorageKeys.userGeminiApiKey);
    if (apiKey != null && apiKey.isNotEmpty) {
      _logger.d('Gemini API key found in secure storage.');
      return apiKey;
    }
    _logger.d('Gemini API key not found in secure storage.');
    return null;
  }

  Future<String?> generateContent({
    required String prompt,
    String model = 'gemini-2.5-flash',
  }) async {
    final apiKey = await _secureStorage.read(StorageKeys.userGeminiApiKey);
    if (apiKey == null || apiKey.trim().isEmpty) {
      _logger.e('Gemini API key is missing. Cannot generate content.');
      return null;
    }

    _logger.i('Initializing Gemini model: $model');

    final modelInstance = GenerativeModel(
      model: model,
      apiKey: apiKey,
    );

    _logger.i('Sending prompt to Gemini. promptLength=${prompt.length}');

    final response = await modelInstance.generateContent(
      [Content.text(prompt)],
    );

    final responseText = response.text;
    if (responseText == null || responseText.trim().isEmpty) {
      _logger.w('Gemini response was empty.');
      return null;
    }

    _logger.i(
      'Gemini response received. responseLength=${responseText.length}',
    );
    _logger.d('Gemini response text: ${responseText.trim()}');
    return responseText.trim();
  }

  Future<String?> testConnection() async {
    final apiKey = await _secureStorage.read(StorageKeys.userGeminiApiKey);
    if (apiKey == null || apiKey.trim().isEmpty) {
      _logger.d('testConnection: No API key found.');
      return null;
    }

    _logger.d('testConnection: Testing Gemini with API key length=${apiKey.length}');
    
    final modelInstance = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
    );

    const testPrompt = 'Say "Hello" if you can understand this.';
    _logger.d('testConnection: Sending test prompt: $testPrompt');

    final response = await modelInstance.generateContent(
      [Content.text(testPrompt)],
    );

    final responseText = response.text;
    _logger.d('testConnection: Received response: $responseText');
    return responseText?.trim();
  }

  Future<Map<String, dynamic>?> generateStructuredContent({
    required String systemInstruction,
    required String prompt,
    String model = 'gemini-2.5-flash',
  }) async {
    final apiKey = await _secureStorage.read(StorageKeys.userGeminiApiKey);
    if (apiKey == null || apiKey.trim().isEmpty) {
      _logger.e('Gemini API key is missing. Cannot generate structured content.');
      return null;
    }

    _logger.i('Initializing Gemini model for structured output: $model');

    final modelInstance = GenerativeModel(
      model: model,
      apiKey: apiKey,
      systemInstruction: Content.system(systemInstruction),
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );

    _logger.i('Sending structured prompt to Gemini. promptLength=${prompt.length}');

    final response = await modelInstance.generateContent(
      [Content.text(prompt)],
    );

    final responseText = response.text;
    if (responseText == null || responseText.trim().isEmpty) {
      _logger.w('Gemini structured response was empty.');
      return null;
    }

    _logger.d('Gemini structured response: ${responseText.trim()}');

    final jsonText = _extractJsonObject(responseText);
    if (jsonText == null) {
      _logger.w('Gemini response contained no JSON object. raw=${responseText.trim()}');
      return null;
    }

    try {
      final decoded = jsonDecode(jsonText);
      if (decoded is! Map<String, dynamic>) {
        _logger.e('Gemini response is not a JSON object. Got: ${decoded.runtimeType}');
        return null;
      }
      return decoded;
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to parse Gemini JSON response.',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Extracts the first top-level JSON object `{...}` from [text],
  /// ignoring any markdown fences or trailing content Gemini may add.
  String? _extractJsonObject(String text) {
    final start = text.indexOf('{');
    if (start == -1) return null;
    int depth = 0;
    for (int i = start; i < text.length; i++) {
      if (text[i] == '{') depth++;
      if (text[i] == '}') {
        depth--;
        if (depth == 0) return text.substring(start, i + 1);
      }
    }
    return null;
  }
}