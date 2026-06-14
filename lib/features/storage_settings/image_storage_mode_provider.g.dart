// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_storage_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imageStorageModeNotifierHash() =>
    r'49f3f67c80a1c885f4c2718ed74832901d0aad55';

/// Holds the user's chosen evidence-image storage mode (cloudinary vs local).
///
/// Persisted via [AppLocalStorage] under [StorageKeys.evidenceStorageMode].
/// Defaults to [ImageStorageMode.cloudinary] for backward compatibility.
///
/// Copied from [ImageStorageModeNotifier].
@ProviderFor(ImageStorageModeNotifier)
final imageStorageModeNotifierProvider =
    AutoDisposeNotifierProvider<
      ImageStorageModeNotifier,
      ImageStorageMode
    >.internal(
      ImageStorageModeNotifier.new,
      name: r'imageStorageModeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$imageStorageModeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ImageStorageModeNotifier = AutoDisposeNotifier<ImageStorageMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
