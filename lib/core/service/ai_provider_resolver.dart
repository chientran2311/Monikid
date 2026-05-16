import 'package:logger/logger.dart';
import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/service/ai_analysis_service.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/repositories/ai/gemma_model_repository.dart';

/// Routes AI analysis calls to the correct [AiAnalysisService].
///
/// Decision matrix:
///   useLocal=true  + model cached → local service
///   useLocal=false + API key      → gemini service
///   no API key     + model cached → local service (auto-fallback)
///   no API key     + no model     → null (caller shows error)
class AiProviderResolver {
  AiProviderResolver({
    required AiAnalysisService geminiService,
    required AiAnalysisService localService,
    required AppLocalStorage storage,
    required GemmaModelRepository gemmaRepo,
    Logger? logger,
  })  : _geminiService = geminiService,
        _localService = localService,
        _storage = storage,
        _gemmaRepo = gemmaRepo,
        _logger = logger ?? Logger();

  final AiAnalysisService _geminiService;
  final AiAnalysisService _localService;
  final AppLocalStorage _storage;
  final GemmaModelRepository _gemmaRepo;
  final Logger _logger;

  /// Exposes Gemini service for fallback access in HomeScanBillNotifier.
  AiAnalysisService get geminiService => _geminiService;

  Future<AiAnalysisService?> resolve() async {
    final useLocal =
        await _storage.readBool(StorageKeys.useLocalModel) ?? false;
    final modelCached = await _gemmaRepo.isModelCached();
    final hasApiKey =
        await _storage.readBool(StorageKeys.hasStoredGeminiApiKey) ?? false;

    _logger.d(
      'AiProviderResolver.resolve: '
      'useLocal=$useLocal | modelCached=$modelCached | hasApiKey=$hasApiKey',
    );

    if (useLocal && modelCached) {
      _logger.i('AiProviderResolver: → LocalGemmaAiAnalysisService (useLocal=true + model cached)');
      return _localService;
    }
    if (!useLocal && hasApiKey) {
      _logger.i('AiProviderResolver: → GeminiAiAnalysisService (useLocal=false + API key active)');
      return _geminiService;
    }
    if (!hasApiKey && modelCached) {
      _logger.i('AiProviderResolver: → LocalGemmaAiAnalysisService (auto-fallback: no API key but model cached)');
      return _localService;
    }
    _logger.w('AiProviderResolver: → null (no API key AND no cached model — scan blocked)');
    return null;
  }
}
