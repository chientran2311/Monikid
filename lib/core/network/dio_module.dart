import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart'; // Khuyên dùng để log đẹp

class DioModule {
  Dio provideDio() {
    final dio = Dio();

    // 1. Cấu hình cơ bản
    dio.options = BaseOptions(
      baseUrl: "YOUR_RENDER_BASE_URL", // 🔴 THAY URL RENDER CỦA BẠN VÀO ĐÂY
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // 2. Thêm Interceptors (Để log hoặc thêm Token tự động)
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    // Ví dụ: Thêm Token vào header nếu có
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     final token = await _getToken();
    //     if (token != null) {
    //       options.headers['Authorization'] = 'Bearer $token';
    //     }
    //     return handler.next(options);
    //   },
    // ));

    return dio;
  }
}