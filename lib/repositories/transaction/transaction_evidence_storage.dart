import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:monikid/models/entities/transaction_model.dart';

class TransactionEvidenceUploadPayload {
  const TransactionEvidenceUploadPayload({
    required this.bytes,
    required this.fileName,
    required this.mimeType,
  });

  final Uint8List bytes;
  final String fileName;
  final String mimeType;
}

abstract class TransactionEvidenceStorage {
  Future<TransactionEvidenceImage> uploadEvidenceImage({
    required String userId,
    required String transactionId,
    required TransactionEvidenceUploadPayload payload,
  });

  Future<void> deleteEvidenceImage(String storagePath);

  Future<String> getEvidenceDownloadUrl(String storagePath);
}

class TransactionEvidenceStorageImpl implements TransactionEvidenceStorage {
  TransactionEvidenceStorageImpl(this._storage, this._logger);

  final FirebaseStorage _storage;
  final Logger _logger;

  @override
  Future<TransactionEvidenceImage> uploadEvidenceImage({
    required String userId,
    required String transactionId,
    required TransactionEvidenceUploadPayload payload,
  }) async {
    final uploadedAt = DateTime.now();
    final extension = _resolveExtension(payload.fileName, payload.mimeType);
    final fileName = 'evidence_${uploadedAt.millisecondsSinceEpoch}.$extension';
    final storagePath = 'transactions/$userId/$transactionId/$fileName';

    try {
      _logger.i(
        'Uploading evidence image for transaction $transactionId to $storagePath.',
      );
      final ref = _storage.ref(storagePath);
      await ref.putData(
        payload.bytes,
        SettableMetadata(contentType: payload.mimeType),
      );

      return TransactionEvidenceImage(
        storagePath: storagePath,
        fileName: payload.fileName,
        mimeType: payload.mimeType,
        uploadedAt: uploadedAt,
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to upload evidence image.',
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

    try {
      _logger.i('Deleting evidence image at $storagePath.');
      await _storage.ref(storagePath).delete();
    } on FirebaseException catch (error, stackTrace) {
      if (error.code == 'object-not-found') {
        _logger.w('Evidence image already missing at $storagePath.');
        return;
      }

      _logger.e(
        'Failed to delete evidence image.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to delete evidence image.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<String> getEvidenceDownloadUrl(String storagePath) async {
    try {
      _logger.i('Resolving evidence image url for $storagePath.');
      return _storage.ref(storagePath).getDownloadURL();
    } catch (error, stackTrace) {
      _logger.e(
        'Failed to resolve evidence image url.',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
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
