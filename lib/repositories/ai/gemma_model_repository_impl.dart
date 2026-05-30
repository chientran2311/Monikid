import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:monikid/repositories/ai/gemma_model_repository.dart';
import 'package:path_provider/path_provider.dart';

class GemmaModelRepositoryImpl implements GemmaModelRepository {
  GemmaModelRepositoryImpl(this._logger);

  final Logger _logger;

  // Download target name — only used when the app itself downloads the model.
  // Discovery is filename-agnostic: any .task file >= _minModelBytes is valid.
  static const String _downloadFileName = 'model.task';
  static const String _downloadUrl =
      'https://drive.usercontent.google.com/download?id=1YpSyathqytl74bFD0o7cqSBzcsPYJVtp&export=download&authuser=0&confirm=t';

  // Any valid on-device LLM .task file will be well above 100 MB.
  // This threshold screens out HTML error pages, partial downloads, and
  // unrelated small .task assets without being model-specific.
  static const int _minModelBytes = 100 * 1024 * 1024; // 100 MB

  static const int _magicBytesLength = 8;

  final Dio _dio = Dio();

  // ---------------------------------------------------------------------------
  // Discovery — filename-agnostic scan
  // ---------------------------------------------------------------------------

  /// Scans the app documents directory for the largest `.task` file that is
  /// at least [_minModelBytes] in size. Returns `null` if none found.
  ///
  /// Picking the *largest* file avoids ambiguity when multiple .task files
  /// coexist (e.g. stale partial next to a complete model).
  Future<File?> _discoverModelFile() async {
    final dir = await getApplicationDocumentsDirectory();
    File? best;
    int bestSize = 0;

    try {
      await for (final entity in dir.list()) {
        if (entity is! File) continue;
        if (!entity.path.endsWith('.task')) continue;
        try {
          final size = await entity.length();
          if (size < _minModelBytes) continue;

          // Skip non-ZIP files early — they are incompatible with flutter_gemma.
          // Deletes them so they never block a valid model on subsequent calls.
          final raf = await entity.open();
          final header = await raf.read(4);
          await raf.close();
          final isZip = header.length >= 4 &&
              header[0] == _zipMagic[0] &&
              header[1] == _zipMagic[1] &&
              header[2] == _zipMagic[2] &&
              header[3] == _zipMagic[3];
          if (!isZip) {
            _logger.w(
              'GemmaRepo._discoverModelFile: skipping non-ZIP file '
              '${entity.uri.pathSegments.last} '
              '(magic=${header.map((b) => b.toRadixString(16).padLeft(2, "0")).join(" ")}) — deleting.',
            );
            try { await entity.delete(); } catch (_) {}
            continue;
          }

          if (size > bestSize) {
            best = entity;
            bestSize = size;
          }
        } catch (_) {
          // Ignore unreadable files
        }
      }
    } catch (e, st) {
      _logger.w('GemmaRepo._discoverModelFile: error scanning dir.', error: e, stackTrace: st);
    }

    if (best != null) {
      _logger.d(
        'GemmaRepo._discoverModelFile: found ${best.path} '
        '(${(bestSize / 1e9).toStringAsFixed(3)} GB)',
      );
    } else {
      _logger.d('GemmaRepo._discoverModelFile: no valid .task file found.');
    }
    return best;
  }

  // ---------------------------------------------------------------------------
  // GemmaModelRepository
  // ---------------------------------------------------------------------------

  /// MediaPipe `.task` files are ZIP archives — first 4 bytes are `PK\x03\x04`.
  /// Web/WASM `.task` variants use a different binary format and will crash
  /// flutter_gemma with "Unable to open zip archive". Reject them early.
  static const List<int> _zipMagic = [0x50, 0x4B, 0x03, 0x04]; // PK\x03\x04

  @override
  Future<bool> isModelCached() async {
    final file = await _discoverModelFile();
    if (file == null) return false;

    try {
      final raf = await file.open();
      final header = await raf.read(_magicBytesLength);
      await raf.close();

      // All-zero bytes → zeroed / corrupt file
      if (header.every((b) => b == 0)) {
        _logger.w('GemmaRepo.isModelCached: all-zero header, deleting ${file.path}');
        await file.delete();
        return false;
      }

      // Not a ZIP archive → web/WASM variant, incompatible with flutter_gemma
      final isZip = header.length >= 4 &&
          header[0] == _zipMagic[0] &&
          header[1] == _zipMagic[1] &&
          header[2] == _zipMagic[2] &&
          header[3] == _zipMagic[3];
      if (!isZip) {
        _logger.w(
          'GemmaRepo.isModelCached: NOT a ZIP archive '
          '(magic=${header.take(4).map((b) => b.toRadixString(16).padLeft(2, "0")).join(" ")}) — '
          'likely a web/WASM variant, incompatible with flutter_gemma. '
          'Use the standard MediaPipe .task format, not the -web.task variant.',
        );
        return false;
      }
    } catch (e, st) {
      _logger.w('GemmaRepo.isModelCached: could not read header.', error: e, stackTrace: st);
      return false;
    }

    final size = await file.length();
    _logger.i(
      'GemmaRepo.isModelCached: OK — '
      '${file.uri.pathSegments.last} '
      '(${(size / 1e9).toStringAsFixed(3)} GB)',
    );
    return true;
  }

  @override
  Future<String> getCachedModelPath() async {
    final file = await _discoverModelFile();
    if (file == null) {
      throw StateError(
        'GemmaRepo.getCachedModelPath: no valid .task model file found in documents dir.',
      );
    }
    return file.path;
  }

  @override
  Future<void> downloadModel({
    required void Function(double progress) onProgress,
    CancelToken? cancelToken,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final savePath = '${dir.path}/$_downloadFileName';
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

      final downloadedSize = await File(partPath).length();
      _logger.i(
        'GemmaRepo: downloaded ${(downloadedSize / 1e6).toStringAsFixed(1)} MB '
        '(threshold ${(_minModelBytes / 1e6).toStringAsFixed(0)} MB)',
      );
      if (downloadedSize < _minModelBytes) {
        await File(partPath).delete();
        throw Exception(
          'GemmaRepo: downloaded file is only ${(downloadedSize / 1e6).toStringAsFixed(1)} MB — '
          'likely an HTML error page. Check the share link is public.',
        );
      }

      await File(partPath).rename(savePath);
      _logger.i('GemmaRepo: download complete → $savePath');
    } on DioException catch (e) {
      final partFile = File(partPath);
      if (await partFile.exists()) await partFile.delete();
      if (e.type == DioExceptionType.cancel) {
        _logger.i('GemmaRepo: download cancelled, partial file removed.');
        return;
      }
      _logger.e('GemmaRepo: download failed.', error: e);
      rethrow;
    }
  }

  @override
  Future<void> deleteCachedModel() async {
    final dir = await getApplicationDocumentsDirectory();

    // Delete all valid .task model files found by discovery (not just one name)
    int deleted = 0;
    await for (final entity in dir.list()) {
      if (entity is! File) continue;
      if (!entity.path.endsWith('.task')) continue;
      try {
        final size = await entity.length();
        if (size >= _minModelBytes) {
          await entity.delete();
          _logger.i('GemmaRepo: deleted ${entity.uri.pathSegments.last}.');
          deleted++;
        }
      } catch (_) {}
    }
    if (deleted == 0) {
      _logger.d('GemmaRepo.deleteCachedModel: no model files to delete.');
    }
  }

  @override
  Future<void> reconcileStalePartFile() async {
    final dir = await getApplicationDocumentsDirectory();

    // Remove any stale .part files from interrupted downloads
    await for (final entity in dir.list()) {
      if (entity is File && entity.path.endsWith('.task.part')) {
        await entity.delete();
        _logger.i('GemmaRepo: stale .part file removed — ${entity.uri.pathSegments.last}');
      }
    }
  }
}
