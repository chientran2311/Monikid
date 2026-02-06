import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:monikid/core/network/api_client.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/core/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future configureDependencies() async {
  // Initialize local storage first
  final localStorage = await AppLocalStorage.create();
  getIt.registerSingleton<AppLocalStorage>(localStorage);

  return getIt.init();
}

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'User-Agent': 'Monikid/1.0', 'Accept': 'application/json'},
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print(obj),
      ),
    );
    return dio;
  }

  @lazySingleton
  ApiClient get apiClient => ApiClient(dio);
}
