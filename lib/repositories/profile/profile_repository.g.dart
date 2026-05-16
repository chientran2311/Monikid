// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRepositoryHash() => r'f7fb25357ffa348edff0ee5602118642e3bce412';

/// See also [profileRepository].
@ProviderFor(profileRepository)
final profileRepositoryProvider =
    AutoDisposeProvider<ProfileRepository>.internal(
      profileRepository,
      name: r'profileRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRepositoryRef = AutoDisposeProviderRef<ProfileRepository>;
String _$profileImageHash() => r'309778630c929baa44710cbca76baf05a613aaa1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [profileImage].
@ProviderFor(profileImage)
const profileImageProvider = ProfileImageFamily();

/// See also [profileImage].
class ProfileImageFamily extends Family<AsyncValue<String?>> {
  /// See also [profileImage].
  const ProfileImageFamily();

  /// See also [profileImage].
  ProfileImageProvider call(String uid) {
    return ProfileImageProvider(uid);
  }

  @override
  ProfileImageProvider getProviderOverride(
    covariant ProfileImageProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'profileImageProvider';
}

/// See also [profileImage].
class ProfileImageProvider extends AutoDisposeFutureProvider<String?> {
  /// See also [profileImage].
  ProfileImageProvider(String uid)
    : this._internal(
        (ref) => profileImage(ref as ProfileImageRef, uid),
        from: profileImageProvider,
        name: r'profileImageProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$profileImageHash,
        dependencies: ProfileImageFamily._dependencies,
        allTransitiveDependencies:
            ProfileImageFamily._allTransitiveDependencies,
        uid: uid,
      );

  ProfileImageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<String?> Function(ProfileImageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProfileImageProvider._internal(
        (ref) => create(ref as ProfileImageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String?> createElement() {
    return _ProfileImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProfileImageProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProfileImageRef on AutoDisposeFutureProviderRef<String?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _ProfileImageProviderElement
    extends AutoDisposeFutureProviderElement<String?>
    with ProfileImageRef {
  _ProfileImageProviderElement(super.provider);

  @override
  String get uid => (origin as ProfileImageProvider).uid;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
