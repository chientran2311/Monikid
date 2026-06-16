// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_code_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$familyInviteCodeHash() => r'1697de8abe4b662c9aa04f211628a45d585abce9';

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

/// Fetches (or lazily generates) the invite code for [familyId].
///
/// Callers invalidate this provider to retry on error.
///
/// Copied from [familyInviteCode].
@ProviderFor(familyInviteCode)
const familyInviteCodeProvider = FamilyInviteCodeFamily();

/// Fetches (or lazily generates) the invite code for [familyId].
///
/// Callers invalidate this provider to retry on error.
///
/// Copied from [familyInviteCode].
class FamilyInviteCodeFamily extends Family<AsyncValue<String>> {
  /// Fetches (or lazily generates) the invite code for [familyId].
  ///
  /// Callers invalidate this provider to retry on error.
  ///
  /// Copied from [familyInviteCode].
  const FamilyInviteCodeFamily();

  /// Fetches (or lazily generates) the invite code for [familyId].
  ///
  /// Callers invalidate this provider to retry on error.
  ///
  /// Copied from [familyInviteCode].
  FamilyInviteCodeProvider call(String familyId) {
    return FamilyInviteCodeProvider(familyId);
  }

  @override
  FamilyInviteCodeProvider getProviderOverride(
    covariant FamilyInviteCodeProvider provider,
  ) {
    return call(provider.familyId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'familyInviteCodeProvider';
}

/// Fetches (or lazily generates) the invite code for [familyId].
///
/// Callers invalidate this provider to retry on error.
///
/// Copied from [familyInviteCode].
class FamilyInviteCodeProvider extends AutoDisposeFutureProvider<String> {
  /// Fetches (or lazily generates) the invite code for [familyId].
  ///
  /// Callers invalidate this provider to retry on error.
  ///
  /// Copied from [familyInviteCode].
  FamilyInviteCodeProvider(String familyId)
    : this._internal(
        (ref) => familyInviteCode(ref as FamilyInviteCodeRef, familyId),
        from: familyInviteCodeProvider,
        name: r'familyInviteCodeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$familyInviteCodeHash,
        dependencies: FamilyInviteCodeFamily._dependencies,
        allTransitiveDependencies:
            FamilyInviteCodeFamily._allTransitiveDependencies,
        familyId: familyId,
      );

  FamilyInviteCodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.familyId,
  }) : super.internal();

  final String familyId;

  @override
  Override overrideWith(
    FutureOr<String> Function(FamilyInviteCodeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FamilyInviteCodeProvider._internal(
        (ref) => create(ref as FamilyInviteCodeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        familyId: familyId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _FamilyInviteCodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FamilyInviteCodeProvider && other.familyId == familyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, familyId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FamilyInviteCodeRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `familyId` of this provider.
  String get familyId;
}

class _FamilyInviteCodeProviderElement
    extends AutoDisposeFutureProviderElement<String>
    with FamilyInviteCodeRef {
  _FamilyInviteCodeProviderElement(super.provider);

  @override
  String get familyId => (origin as FamilyInviteCodeProvider).familyId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
