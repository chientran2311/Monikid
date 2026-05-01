import 'package:dio/dio.dart';

abstract class GemmaModelRepository {
  Future<void> downloadModel({
    required void Function(double progress) onProgress,
    CancelToken? cancelToken,
  });
  Future<bool> isModelCached();
  Future<String> getCachedModelPath();
  Future<void> deleteCachedModel();
  Future<void> reconcileStalePartFile();
}
