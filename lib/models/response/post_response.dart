import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_response.freezed.dart';
part 'post_response.g.dart';

// Wrapper cho List response từ API
@freezed
abstract class PostDataWrapper with _$PostDataWrapper {
  const factory PostDataWrapper({
    @JsonKey(name: 'data') @Default([]) List<PostResponseItem> items,
  }) = _PostDataWrapper;

  // Factory để parse từ List<dynamic> trực tiếp (khi API trả về array)
  factory PostDataWrapper.fromList(List<dynamic> json) => PostDataWrapper(
    items: json
        .map((e) => PostResponseItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  factory PostDataWrapper.fromJson(Map<String, dynamic> json) =>
      _$PostDataWrapperFromJson(json);
}

// Item đơn lẻ
@freezed
abstract class PostResponseItem with _$PostResponseItem {
  const factory PostResponseItem({
    required int userId,
    required int id,
    String? title,
    String? body,
  }) = _PostResponseItem;

  factory PostResponseItem.fromJson(Map<String, dynamic> json) =>
      _$PostResponseItemFromJson(json);
}
