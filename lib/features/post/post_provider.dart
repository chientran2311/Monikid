import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/features/post/post_state.dart';
import 'package:monikid/repository/post_repository.dart';
import 'package:monikid/utils/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'post_provider.g.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return getIt<PostRepository>();
});

final localStorageProvider = Provider<AppLocalStorage>((ref) {
  return getIt<AppLocalStorage>();
});

@riverpod
class PostProvider extends _$PostProvider {
  AppLocalStorage get _localStorage => ref.read(localStorageProvider);

  @override
  PostProviderState build() {
    // Load local mode state on initialization
    final isLocalMode = _localStorage.getLocalMode();
    return PostProviderState(isLocalMode: isLocalMode);
  }

  // Toggle between local storage and API mode
  Future<void> toggleMode() async {
    final newMode = !state.isLocalMode;
    await _localStorage.setLocalMode(newMode);
    state = state.copyWith(isLocalMode: newMode);

    if (newMode) {
      // Switch to local mode - load from local storage
      await loadFromLocal();
    } else {
      // Switch to API mode - fetch from API
      await load_post(reset: true);
    }
  }

  // Load posts from local storage
  Future<void> loadFromLocal() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final cachedPosts = await _localStorage.loadPosts();
      if (cachedPosts.isEmpty) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'No cached data. Please fetch from API first.',
        );
      } else {
        state = state.copyWith(
          postList: cachedPosts,
          isLoading: false,
          errorMessage: null,
        );
        logger.i('Loaded ${cachedPosts.length} posts from local storage');
      }
    } catch (e, stack) {
      logger.e('Error loading from local storage: $e', stackTrace: stack);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load cached data.',
      );
    }
  }

  Future<void> load_post({
    required bool reset,
    bool isRefesh = false,
    int? pageOverride,
  }) async {
    final page = reset ? 1 : (pageOverride ?? state.page);
    _updateLoadingState(reset: reset, isRefesh: isRefesh, page: page);
    try {
      final newPost = await ref.read(postRepositoryProvider).getPosts();
      final newItem = newPost.items;
      final combinedList = reset ? newItem : [...state.postList, ...newItem];

      // Save first 10 items to local storage
      if (reset && newItem.isNotEmpty) {
        await _localStorage.savePosts(newItem);
        logger.i('Saved ${newItem.take(10).length} posts to local storage');
      }

      state = state.copyWith(
        postList: combinedList,
        isLoading: false,
        isLoadingMore: false,
        errorMessage: null,
      );
    } catch (e, stack) {
      logger.e('Error loading post: $e', stackTrace: stack);
      _handleLoadError(reset);
    }
  }

  void _updateLoadingState({
    required bool reset,
    required bool isRefesh,
    int? page,
  }) {
    if (reset) {
      state = state.copyWith(
        selectedItem: -1,
        isLoading: true,
        isLoadingMore: false,
        postList: isRefesh ? state.postList : [],
        errorMessage: null,
      );
    } else {
      state = state.copyWith(isLoadingMore: true, errorMessage: null);
    }
  }

  void _handleLoadError(bool reset) {
    if (reset) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load posts. Please try again.',
        postList: [],
      );
    } else {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: 'Failed to load more posts. Please try again.',
      );
    }
  }
}
