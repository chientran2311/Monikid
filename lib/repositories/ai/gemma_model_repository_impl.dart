import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:monikid/repositories/ai/gemma_model_repository.dart';
import 'package:path_provider/path_provider.dart';

class GemmaModelRepositoryImpl implements GemmaModelRepository {
  GemmaModelRepositoryImpl(this._logger);

  final Logger _logger;

  static const String _fileName = 'gemma-2b-it-int4.bin';
  static const String _downloadUrl =
      'https://huggingface.co/innermost47/gemma-2b-it-int4-mediapipe/resolve/main/gemma-1.1-2b-it-cpu-int4.bin?download=true';

  // 1.35 GB — Android only
  static const int _minExpectedBytes = 1_350_000_000;
  static const int _magicBytesLength = 8;

  final Dio _dio = Dio();

  @override
  Future<String> getCachedModelPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_fileName';
  }

  @override
  Future<bool> isModelCached() async {
    final path = await getCachedModelPath();
    final file = File(path);

    if (!await file.exists()) return false;

    final size = await file.length();
    if (size < _minExpectedBytes) {
      _logger.w('GemmaRepo: file too small ($size bytes), deleting.');
      await file.delete();
      return false;
    }

    // Magic bytes: first 8 bytes must not be all zeros
    final raf = await file.open();
    final magic = await raf.read(_magicBytesLength);
    await raf.close();
    if (magic.every((b) => b == 0)) {
      _logger.w('GemmaRepo: magic bytes invalid, deleting.');
      await file.delete();
      return false;
    }

    return true;
  }

  @override
  Future<void> downloadModel({
    required void Function(double progress) onProgress,
    CancelToken? cancelToken,
  }) async {
    final savePath = await getCachedModelPath();
    final partPath = '$savePath.part';

    _logger.i('GemmaRepo: starting download → $partPath');

    try {
      await _dio.download(
        _downloadUrl,
        partPath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          if (total > 0) onProgress(received / total);
        },
        options: Options(
          receiveTimeout: const Duration(minutes: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
      );

      // Rename .part → final only after complete transfer
      await File(partPath).rename(savePath);
      _logger.i('GemmaRepo: download complete → $savePath');
    } on DioException catch (e) {
      // Clean up partial file on any error (including cancel)
      final partFile = File(partPath);
      if (await partFile.exists()) await partFile.delete();
      if (e.type == DioExceptionType.cancel) {
        _logger.i('GemmaRepo: download cancelled, partial file removed.');
        return; // Not an error — caller handles cancel state
      }
      _logger.e('GemmaRepo: download failed.', error: e);
      rethrow;
    }
  }

  @override
  Future<void> deleteCachedModel() async {
    final path = await getCachedModelPath();
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
      _logger.i('GemmaRepo: cached model deleted.');
    }
  }

  @override
  Future<void> reconcileStalePartFile() async {
    final savePath = await getCachedModelPath();
    final partFile = File('$savePath.part');
    if (await partFile.exists()) {
      await partFile.delete();
      _logger.i('GemmaRepo: stale .part file removed on launch.');
    }
  }
}
