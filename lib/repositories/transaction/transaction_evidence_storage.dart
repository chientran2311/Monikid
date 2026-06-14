import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:monikid/core/config/app_config.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/models/enums/image_storage_mode.dart';

class TransactionEvidenceUploadPayload {
  const TransactionEvidenceUploadPayload({
    required this.bytes,
    required this.fileName,
    required this.mimeType,
    required this.categoryKey,
    this.filePath,
  });

  final Uint8List bytes;
  final String fileName;
  final String mimeType;
  final String categoryKey;
  final String? filePath;
}

abstract class TransactionEvidenceStorage {
  Future<TransactionEvidenceImage> uploadEvidenceImage({
    required String userId,
    required String transactionId,
    required TransactionEvidenceUploadPayload payload,
    required String recipientName,
    required DateTime transactionDate,
  });

  Future<void> deleteEvidenceImage(String storagePath);

  Future<String> getEvidenceDownloadUrl(String storagePath);
}

class TransactionEvidenceStorageImpl implements TransactionEvidenceStorage {
  TransactionEvidenceStorageImpl(this._logger, {http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  final Logger _logger;
  final http.Client _httpClient;

  @override
  Future<TransactionEvidenceImage> uploadEvidenceImage({
    required String userId,
    required String transactionId,
    required TransactionEvidenceUploadPayload payload,
    required String recipientName,
    required DateTime transactionDate,
  }) async {
    final uploadedAt = DateTime.now();
    final cloudName = AppConfig.cloudinaryCloudName;
    final uploadPreset = AppConfig.cloudinaryUnsignedUploadPreset;
    final fileName = _buildFileName(
      recipientName: recipientName,
      categoryKey: payload.categoryKey,
      uploadedAt: uploadedAt,
      originalFileName: payload.fileName,
      mimeType: payload.mimeType,
    );
    final folder = _buildFolder(userId, transactionDate);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/upload'),
    )
      ..fields['upload_preset'] = uploadPreset
      ..fields['folder'] = folder
      ..fields['resource_type'] = 'image'
      ..fields['tags'] = 'transaction_evidence,$transactionId,$userId'
      ..fields['context'] = 'transaction_id=$transactionId|user_id=$userId'
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          payload.bytes,
          filename: fileName,
        ),
      );

    try {
      _logger.i(
        'Uploading evidence image for transaction $transactionId to Cloudinary folder $folder.',
      );
      final streamedResponse = await _httpClient.send(request);
      final responseBody = await streamedResponse.stream.bytesToString();
      if (streamedResponse.statusCode < 200 || streamedResponse.statusCode >= 300) {
        throw Exception(
          'Cloudinary upload failed: ${streamedResponse.statusCode} $responseBody',
        );
      }

      final responseJson = jsonDecode(responseBody);
      if (responseJson is! Map<String, dynamic>) {
        throw Exception('Cloudinary upload returned an invalid JSON payload.');
      }

      final secureUrl = responseJson['secure_url'] as String?;
      if (secureUrl == null || secureUrl.trim().isEmpty) {
        throw Exception('Cloudinary upload response is missing secure_url.');
      }

      return TransactionEvidenceImage(
        imageUrl: secureUrl,
        fileName: responseJson['original_filename'] as String? ?? payload.fileName,
        mimeType: payload.mimeType,
        uploadedAt: uploadedAt,
        storageMode: ImageStorageMode.cloudinary,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to upload evidence image to Cloudinary.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> deleteEvidenceImage(String storagePath) async {
    if (storagePath.trim().isEmpty) {
      return;
    }

    _logger.w(
      'Cloudinary unsigned upload flow cannot guarantee durable asset deletion from the client. Skipping delete for $storagePath.',
    );
  }

  @override
  Future<String> getEvidenceDownloadUrl(String storagePath) async {
    final trimmedStoragePath = storagePath.trim();
    if (trimmedStoragePath.isEmpty) {
      throw Exception('Missing Cloudinary evidence URL.');
    }

    final uri = Uri.tryParse(trimmedStoragePath);
    final isHttpUrl =
        uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host.isNotEmpty;
    if (!isHttpUrl) {
      throw Exception(
        'Unsupported legacy evidence path. Expected a Cloudinary delivery URL.',
      );
    }

    return trimmedStoragePath;
  }

  String _buildFileName({
    required String recipientName,
    required String categoryKey,
    required DateTime uploadedAt,
    required String originalFileName,
    required String mimeType,
  }) {
    final normalizedRecipient = _normalizeText(recipientName);
    final normalizedCategory = _normalizeCategoryKey(categoryKey);
    final extension = _resolveExtension(originalFileName, mimeType);
    final formattedTimestamp = _formatFileTimestamp(uploadedAt);
    return '${normalizedRecipient}_${normalizedCategory}_$formattedTimestamp.$extension';
  }

  String _buildFolder(String userId, DateTime transactionDate) {
    final mm = transactionDate.month.toString().padLeft(2, '0');
    final dd = transactionDate.day.toString().padLeft(2, '0');
    final year = transactionDate.year;
    return 'transactions/$userId/${year}_$mm/$dd';
  }

  String _normalizeText(String text) {
    final normalized = text
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return normalized.isEmpty ? 'unknown' : normalized;
  }

  String _normalizeCategoryKey(String categoryKey) {
    final normalized = categoryKey
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');

    if (normalized.isEmpty) {
      return 'uncategorized';
    }

    return normalized;
  }

  String _formatFileTimestamp(DateTime uploadedAt) {
    final twoDigitMonth = uploadedAt.month.toString().padLeft(2, '0');
    final twoDigitDay = uploadedAt.day.toString().padLeft(2, '0');
    final twoDigitHour = uploadedAt.hour.toString().padLeft(2, '0');
    final twoDigitMinute = uploadedAt.minute.toString().padLeft(2, '0');
    final twoDigitSecond = uploadedAt.second.toString().padLeft(2, '0');

    return '${uploadedAt.year}$twoDigitMonth${twoDigitDay}_$twoDigitHour$twoDigitMinute$twoDigitSecond';
  }

  String _resolveExtension(String fileName, String mimeType) {
    final trimmedFileName = fileName.trim();
    final dotIndex = trimmedFileName.lastIndexOf('.');
    if (dotIndex != -1 && dotIndex < trimmedFileName.length - 1) {
      return trimmedFileName.substring(dotIndex + 1).toLowerCase();
    }

    if (mimeType == 'image/png') {
      return 'png';
    }
    if (mimeType == 'image/webp') {
      return 'webp';
    }
    return 'jpg';
  }
}
