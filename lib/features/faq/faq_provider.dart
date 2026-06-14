import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/app/app.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/features/faq/faq_state.dart';
import 'package:monikid/repositories/faq/faq_repository.dart';

part 'faq_provider.g.dart';

@riverpod
class FAQ extends _$FAQ {
  late final Logger _logger;

  @override
  FAQState build() {
    _logger = getIt<Logger>();
    Future.microtask(_loadFAQs);
    // Reload FAQs when the app language changes.
    ref.listen(changeLanguageProvider, (previous, next) {
      if (previous?.localeCode != next.localeCode) {
        _loadFAQs();
      }
    });
    return const FAQState();
  }

  Future<void> _loadFAQs() async {
    _logger.d('FAQ._loadFAQs: start.');
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final langCode = ref.read(changeLanguageProvider).localeCode;
      final repository = ref.read(faqRepositoryProvider);
      final list = await repository.getFAQs(langCode: langCode);
      _logger.i('FAQ._loadFAQs: success. count=${list.length}, lang=$langCode');
      state = state.copyWith(faqList: list, isLoading: false);
    } catch (error, stackTrace) {
      _logger.e('FAQ._loadFAQs failed.', error: error, stackTrace: stackTrace);
      state = state.copyWith(
        isLoading: false,
        errorMessage: s.errorGeneric(error.toString()),
      );
    }
  }

  Future<void> refresh() async {
    await _loadFAQs();
  }

  void selectedItem(String? id) {
    state = state.copyWith(selectedItemId: id);
  }
}
