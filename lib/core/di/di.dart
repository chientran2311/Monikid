import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart'
    as monikid_tx_repo;
import 'package:monikid/repositories/transaction/transaction_repository_impl.dart'
    as monikid_tx_impl;

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Initialize local storage first
  final localStorage = await AppLocalStorage.create();
  getIt.registerSingleton<AppLocalStorage>(localStorage);

  // Register secure storage as lazy singleton
  getIt.registerLazySingleton<AppSecureStorage>(() => AppSecureStorage());

  // Register Firebase instances
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // Register Repositories
  getIt.registerLazySingleton<monikid_tx_repo.TransactionRepository>(
    () => monikid_tx_impl.TransactionRepositoryImpl(getIt<FirebaseFirestore>()),
  );
}
