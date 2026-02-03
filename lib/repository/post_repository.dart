import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:monikid/core/network/api_client.dart';
import 'package:monikid/models/response/post_response.dart';

abstract class PostRepository {
  Future<PostResponse> getPosts({
    required int userId,
    required int id,
    String? title,
    String? body,
  });
}

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final ApiClient _apiClient;

  PostRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  @override
  Future<PostResponse> getPosts({
    required int userId,
    required int id,
    String? title,
    String? body,
  }) async {
    try {
      final response = await _apiClient.getPosts(userId, id);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
