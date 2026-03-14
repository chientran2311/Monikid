import 'package:monikid/core/utils/logger.dart';
import 'package:monikid/features/change_language/change_language_provider.dart';
import 'package:monikid/features/fqa/fqa_state.dart';
import 'package:monikid/repositories/fqa/fqa_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:monikid/App/app.dart';

part 'fqa_provider.g.dart';

@riverpod
class FQA extends _$FQA {
  @override
  FQAState build() {
    _loadFAQs();
    // Listen for language changes to reload FAQs
    ref.listen(changeLanguageProvider, (previous, next) {
      if (previous?.localeCode != next.localeCode) {
        _loadFAQs();
      }
    });
    return const FQAState();
  }

  Future<void> _loadFAQs() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final langCode = ref.read(changeLanguageProvider).localeCode;
      final repository = ref.read(fqaRepositoryProvider);

      final list = await repository.getFAQs(langCode: langCode);

      state = state.copyWith(fqaList: list, isLoading: false);
    } catch (e) {
      // logger.e('Error loading FAQ: $e', stackTrace: stack);
      state = state.copyWith(
        isLoading: false,
        errorMessage: s.errorGeneric(e.toString()),
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
