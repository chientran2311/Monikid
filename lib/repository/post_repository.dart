import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:monikid/core/network/api_client.dart';
import 'package:monikid/models/response/post_response.dart';

abstract class PostRepository {
  Future<PostDataWrapper> getPosts({
    int? userId,
    int? id,
    String? title,
    String? body,
  });
}

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final ApiClient _apiClient;

  PostRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  @override
  Future<PostDataWrapper> getPosts({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) async {
    try {
      final response = await _apiClient.getPosts();
      // API trả về List<PostResponseItem>, wrap vào PostDataWrapper
      return PostDataWrapper(items: response);
    } catch (e) {
      rethrow;
    }
  }
}
