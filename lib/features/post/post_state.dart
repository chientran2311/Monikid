import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:monikid/models/response/post_response.dart';

part 'post_state.freezed.dart';

@freezed
abstract class PostProviderState with _$PostProviderState {
  const factory PostProviderState({
    @Default([]) List<PostResponseItem> postList,
    @Default(false) bool isLoading,
    @Default(-1) int selectedItem,
    @Default(1) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isLocalMode,
    String? errorMessage,
  }) = _PostProviderState;
  const PostProviderState._();
}
