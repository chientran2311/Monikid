import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:monikid/core/config/storage_keys.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/storage/local_storage.dart';
import 'package:monikid/models/enums/image_storage_mode.dart';

part 'image_storage_mode_provider.g.dart';

/// Holds the user's chosen evidence-image storage mode (cloudinary vs local).
///
/// Persisted via [AppLocalStorage] under [StorageKeys.evidenceStorageMode].
/// Defaults to [ImageStorageMode.cloudinary] for backward compatibility.
@riverpod
class ImageStorageModeNotifier extends _$ImageStorageModeNotifier {
  late final Logger _logger;
  late final AppLocalStorage _storage;

  @override
  ImageStorageMode build() {
    _logger = getIt<Logger>();
    _storage = getIt<AppLocalStorage>();
    final saved = _storage.readSync(StorageKeys.evidenceStorageMode);
    return ImageStorageMode.fromKey(saved);
  }

  Future<void> setMode(ImageStorageMode mode) async {
    if (state == mode) return;
    try {
      await _storage.write(
        key: StorageKeys.evidenceStorageMode,
        value: mode.name,
      );
      state = mode;
      _logger.i('ImageStorageModeNotifier.setMode: success. mode=${mode.name}');
    } catch (error, stackTrace) {
      _logger.e(
        'ImageStorageModeNotifier.setMode failed. mode=${mode.name}',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
