import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_pic_state.freezed.dart';

@freezed
abstract class UploadPicState with _$UploadPicState {
  const factory UploadPicState({
    @Default(false) bool isUploadPic,
    @Default(false) bool isTakePic,
    String? imagePath,
    String? errorMessage,
  }) = _UploadPicState;

  const UploadPicState._();
}
