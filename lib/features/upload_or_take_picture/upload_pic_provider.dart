import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'upload_pic_state.dart';

part 'upload_pic_provider.g.dart';

@riverpod
class UploadPic extends _$UploadPic {
  final ImagePicker _picker = ImagePicker();

  @override
  UploadPicState build() {
    return const UploadPicState();
  }

  Future<void> takePic() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (image != null) {
        state = state.copyWith(
          isTakePic: true,
          imagePath: image.path,
        );
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> choosePic() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (image != null) {
        state = state.copyWith(
          isUploadPic: true,
          imagePath: image.path,
        );
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  void resetState() {
    state = const UploadPicState();
  }
}
