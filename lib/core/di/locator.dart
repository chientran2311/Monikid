import 'package:get_it/get_it.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';
import 'package:monikid/repositories/transaction/transaction_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize local storage synchronously inside the DI async block
  final localStorage = await AppLocalStorage.create();
  getIt.registerSingleton<AppLocalStorage>(localStorage);

  // Register secure storage as lazy singleton
  getIt.registerLazySingleton<AppSecureStorage>(() => AppSecureStorage());

  // Firestore
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Repositories
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<FirebaseFirestore>()),
  );
}
