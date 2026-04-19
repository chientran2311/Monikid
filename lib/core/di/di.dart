import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:monikid/repositories/auth/onboarding_repository.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:monikid/repositories/category/category_repository.dart';
import 'package:monikid/repositories/fqa/fqa_repository.dart';
import 'package:monikid/repositories/profile/profile_repository.dart';
import 'package:monikid/repositories/request_money/request_money_repository.dart';
import 'package:monikid/repositories/set_money_limit/set_money_limit_repository.dart';
import 'package:monikid/repositories/statistic/statistic_repository.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';


final getIt = GetIt.instance;

Future<void> setupLocator() async {
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
  getIt.registerLazySingleton<Logger>(() => Logger());

  // Register Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<FirebaseAuth>(), getIt<FirebaseFirestore>(), getIt<Logger>())
  );

  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(getIt<AppLocalStorage>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<PinCodeRepository>(
    () => PinCodeRepositoryImpl(getIt<AppSecureStorage>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<FQARepository>(
    () => FQARepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<RequestMoneyRepository>(
    () => RequestMoneyRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<SetMoneyLimitRepository>(
    () => SetMoneyLimitRepositoryImpl(getIt<AppLocalStorage>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<StatisticRepository>(
    () => StatisticRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );
}

Future<void> configureDependencies() => setupLocator();
