import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final transactionImageIntakeProvider = Provider<TransactionImageIntake>(
  (ref) => DeviceTransactionImageIntake(),
);

enum TransactionImageIntakeError { unsupportedFormat, readFailed }

class TransactionImageIntakeException implements Exception {
  const TransactionImageIntakeException(this.error);

  final TransactionImageIntakeError error;
}

abstract class TransactionImageIntake {
  Future<TransactionImageSelection?> pickFromCamera();

  Future<TransactionImageSelection?> pickFromGallery();
}

class TransactionImageSelection {
  const TransactionImageSelection({
    required this.bytes,
    required this.filePath,
    required this.fileName,
    required this.mimeType,
  });

  final Uint8List bytes;
  final String filePath;
  final String fileName;
  final String mimeType;
}

class DeviceTransactionImageIntake implements TransactionImageIntake {
  DeviceTransactionImageIntake({ImagePicker? picker})
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<TransactionImageSelection?> pickFromCamera() {
    return _pickImage(ImageSource.camera);
  }

  @override
  Future<TransactionImageSelection?> pickFromGallery() {
    return _pickImage(ImageSource.gallery);
  }

  Future<TransactionImageSelection?> _pickImage(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );
    if (image == null) {
      return null;
    }

    final bytes = await image.readAsBytes();
    if (bytes.isEmpty) {
      throw const TransactionImageIntakeException(
        TransactionImageIntakeError.readFailed,
      );
    }

    final fileName = image.path.split(RegExp(r'[\\/]')).last;
    final mimeType = _resolveMimeType(fileName);
    if (mimeType == null) {
      throw const TransactionImageIntakeException(
        TransactionImageIntakeError.unsupportedFormat,
      );
    }

    return TransactionImageSelection(
      bytes: bytes,
      filePath: image.path,
      fileName: fileName,
      mimeType: mimeType,
    );
  }

  String? _resolveMimeType(String fileName) {
    final normalized = fileName.toLowerCase();
    if (normalized.endsWith('.png')) {
      return 'image/png';
    }
    if (normalized.endsWith('.jpg') || normalized.endsWith('.jpeg')) {
      return 'image/jpeg';
    }
    return null;
  }
}
