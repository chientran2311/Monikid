import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:monikid/core/service/ai_analysis_service.dart';
import 'package:monikid/core/service/local_notification_service.dart';
import 'package:monikid/core/service/ai_provider_resolver.dart';
import 'package:monikid/core/service/gemini_ai_analysis_service.dart';
import 'package:monikid/core/service/gemini_ai_service.dart';
import 'package:monikid/core/service/local_gemma_ai_analysis_service.dart';
import 'package:monikid/repositories/ai/gemma_model_repository.dart';
import 'package:monikid/repositories/ai/gemma_model_repository_impl.dart';
import 'package:monikid/repositories/ai/receipt_ocr_service.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/core/storage/secure_storage.dart';
import 'package:monikid/repositories/auth/auth_repository.dart';
import 'package:monikid/repositories/auth/onboarding_repository.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:monikid/repositories/category/add_custom_category_repository.dart';
import 'package:monikid/repositories/dev_tools/dev_tools_repository.dart';
import 'package:monikid/repositories/faq/faq_repository.dart';
import 'package:monikid/repositories/profile/profile_repository.dart';
import 'package:monikid/repositories/set_money_limit/set_money_limit_repository.dart';
import 'package:monikid/repositories/link_family/link_family_repository.dart';
import 'package:monikid/repositories/parent_dashboard/parent_dashboard_repository.dart';
import 'package:monikid/repositories/notification/notification_repository.dart';
import 'package:monikid/repositories/parent_statistic/parent_statistic_repository.dart';
import 'package:monikid/repositories/child_statistic/statistic_repository.dart';
import 'package:monikid/repositories/transaction/monthly_summary_repository.dart';
import 'package:monikid/repositories/transaction/transaction_evidence_storage.dart';
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

  // Register notification service
  getIt.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationService(getIt<Logger>()),
  );

  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      logger: getIt<Logger>(),
      notificationService: getIt<LocalNotificationService>(),
    ),
  );

  // Register AI Service
  getIt.registerLazySingleton<GeminiAiService>(
    () => GeminiAiService(),
  );
  getIt.registerLazySingleton<ReceiptOcrService>(
    () => ReceiptOcrServiceImpl(getIt<Logger>()),
  );
  getIt.registerLazySingleton<GemmaModelRepository>(
    () => GemmaModelRepositoryImpl(getIt<Logger>()),
  );
  getIt.registerLazySingleton<AiAnalysisService>(
    () => GeminiAiAnalysisService(
      geminiService: getIt<GeminiAiService>(),
      localStorage: getIt<AppLocalStorage>(),
    ),
    instanceName: 'gemini',
  );
  getIt.registerLazySingleton<AiAnalysisService>(
    () => LocalGemmaAiAnalysisService(
      gemmaRepository: getIt<GemmaModelRepository>(),
    ),
    instanceName: 'local',
  );
  getIt.registerLazySingleton<AiProviderResolver>(
    () => AiProviderResolver(
      geminiService: getIt<AiAnalysisService>(instanceName: 'gemini'),
      localService: getIt<AiAnalysisService>(instanceName: 'local'),
      storage: getIt<AppLocalStorage>(),
      gemmaRepo: getIt<GemmaModelRepository>(),
    ),
  );

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

  getIt.registerLazySingleton<TransactionEvidenceStorage>(
    () => TransactionEvidenceStorageImpl(getIt<Logger>()),
  );

  getIt.registerLazySingleton<MonthlySummaryRepository>(
    () => MonthlySummaryRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      getIt<FirebaseFirestore>(),
      getIt<TransactionEvidenceStorage>(),
      getIt<Logger>(),
      getIt<ReceiptOcrService>(),
    ),
  );

  getIt.registerLazySingleton<CustomCategoryRepository>(
    () => CustomCategoryRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<FAQRepository>(
    () => FAQRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );


  getIt.registerLazySingleton<SetMoneyLimitRepository>(
    () => FirestoreSpendingLimitRepositoryImpl(
      firestore: getIt<FirebaseFirestore>(),
      logger: getIt<Logger>(),
    ),
  );

  getIt.registerLazySingleton<StatisticRepository>(
    () => StatisticRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<LinkFamilyRepository>(
    () => LinkFamilyRepositoryImpl(getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<ParentDashboardRepository>(
    () => ParentDashboardRepositoryImpl(
        getIt<FirebaseFirestore>(), getIt<Logger>()),
  );

  getIt.registerLazySingleton<ParentStatisticRepository>(
    () => ParentStatisticRepositoryImpl(
      getIt<FirebaseFirestore>(),
      getIt<Logger>(),
    ),
  );

  getIt.registerLazySingleton<DevToolsRepository>(
    () => DevToolsRepositoryImpl(
      firestore: getIt<FirebaseFirestore>(),
      transactionRepository: getIt<TransactionRepository>(),
      logger: getIt<Logger>(),
    ),
  );

}

Future<void> configureDependencies() => setupLocator();
