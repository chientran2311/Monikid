import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:monikid/models/response/post_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/posts")
  Future<List<PostResponseItem>> getPosts();
}
