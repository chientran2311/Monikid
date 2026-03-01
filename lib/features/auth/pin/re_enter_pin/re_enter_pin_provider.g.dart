// GENERATED CODE - DO NOT MODIFY BY HAND

part of 're_enter_pin_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reEnterPINHash() => r'6982bf3edc67360ec1ce1b83e04c9d4409dd543c';

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

abstract class _$ReEnterPIN
    extends BuildlessAutoDisposeNotifier<ReEnterPINState> {
  late final String pinCodeHash;

  ReEnterPINState build(String pinCodeHash);
}

/// See also [ReEnterPIN].
@ProviderFor(ReEnterPIN)
const reEnterPINProvider = ReEnterPINFamily();

/// See also [ReEnterPIN].
class ReEnterPINFamily extends Family<ReEnterPINState> {
  /// See also [ReEnterPIN].
  const ReEnterPINFamily();

  /// See also [ReEnterPIN].
  ReEnterPINProvider call(String pinCodeHash) {
    return ReEnterPINProvider(pinCodeHash);
  }

  @override
  ReEnterPINProvider getProviderOverride(
    covariant ReEnterPINProvider provider,
  ) {
    return call(provider.pinCodeHash);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'reEnterPINProvider';
}

/// See also [ReEnterPIN].
class ReEnterPINProvider
    extends AutoDisposeNotifierProviderImpl<ReEnterPIN, ReEnterPINState> {
  /// See also [ReEnterPIN].
  ReEnterPINProvider(String pinCodeHash)
    : this._internal(
        () => ReEnterPIN()..pinCodeHash = pinCodeHash,
        from: reEnterPINProvider,
        name: r'reEnterPINProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$reEnterPINHash,
        dependencies: ReEnterPINFamily._dependencies,
        allTransitiveDependencies: ReEnterPINFamily._allTransitiveDependencies,
        pinCodeHash: pinCodeHash,
      );

  ReEnterPINProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pinCodeHash,
  }) : super.internal();

  final String pinCodeHash;

  @override
  ReEnterPINState runNotifierBuild(covariant ReEnterPIN notifier) {
    return notifier.build(pinCodeHash);
  }

  @override
  Override overrideWith(ReEnterPIN Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReEnterPINProvider._internal(
        () => create()..pinCodeHash = pinCodeHash,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pinCodeHash: pinCodeHash,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ReEnterPIN, ReEnterPINState>
  createElement() {
    return _ReEnterPINProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReEnterPINProvider && other.pinCodeHash == pinCodeHash;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pinCodeHash.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReEnterPINRef on AutoDisposeNotifierProviderRef<ReEnterPINState> {
  /// The parameter `pinCodeHash` of this provider.
  String get pinCodeHash;
}

class _ReEnterPINProviderElement
    extends AutoDisposeNotifierProviderElement<ReEnterPIN, ReEnterPINState>
    with ReEnterPINRef {
  _ReEnterPINProviderElement(super.provider);

  @override
  String get pinCodeHash => (origin as ReEnterPINProvider).pinCodeHash;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
