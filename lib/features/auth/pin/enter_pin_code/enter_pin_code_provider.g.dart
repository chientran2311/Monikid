// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enter_pin_code_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$enterPINCodeHash() => r'aa210da1fdba914abb60653aa9ba25e123829ca5';

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

abstract class _$EnterPINCode
    extends BuildlessAutoDisposeNotifier<EnterPINCodeState> {
  late final String expectedPinHash;

  EnterPINCodeState build(String expectedPinHash);
}

/// See also [EnterPINCode].
@ProviderFor(EnterPINCode)
const enterPINCodeProvider = EnterPINCodeFamily();

/// See also [EnterPINCode].
class EnterPINCodeFamily extends Family<EnterPINCodeState> {
  /// See also [EnterPINCode].
  const EnterPINCodeFamily();

  /// See also [EnterPINCode].
  EnterPINCodeProvider call(String expectedPinHash) {
    return EnterPINCodeProvider(expectedPinHash);
  }

  @override
  EnterPINCodeProvider getProviderOverride(
    covariant EnterPINCodeProvider provider,
  ) {
    return call(provider.expectedPinHash);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'enterPINCodeProvider';
}

/// See also [EnterPINCode].
class EnterPINCodeProvider
    extends AutoDisposeNotifierProviderImpl<EnterPINCode, EnterPINCodeState> {
  /// See also [EnterPINCode].
  EnterPINCodeProvider(String expectedPinHash)
    : this._internal(
        () => EnterPINCode()..expectedPinHash = expectedPinHash,
        from: enterPINCodeProvider,
        name: r'enterPINCodeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$enterPINCodeHash,
        dependencies: EnterPINCodeFamily._dependencies,
        allTransitiveDependencies:
            EnterPINCodeFamily._allTransitiveDependencies,
        expectedPinHash: expectedPinHash,
      );

  EnterPINCodeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.expectedPinHash,
  }) : super.internal();

  final String expectedPinHash;

  @override
  EnterPINCodeState runNotifierBuild(covariant EnterPINCode notifier) {
    return notifier.build(expectedPinHash);
  }

  @override
  Override overrideWith(EnterPINCode Function() create) {
    return ProviderOverride(
      origin: this,
      override: EnterPINCodeProvider._internal(
        () => create()..expectedPinHash = expectedPinHash,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        expectedPinHash: expectedPinHash,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<EnterPINCode, EnterPINCodeState>
  createElement() {
    return _EnterPINCodeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EnterPINCodeProvider &&
        other.expectedPinHash == expectedPinHash;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, expectedPinHash.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EnterPINCodeRef on AutoDisposeNotifierProviderRef<EnterPINCodeState> {
  /// The parameter `expectedPinHash` of this provider.
  String get expectedPinHash;
}

class _EnterPINCodeProviderElement
    extends AutoDisposeNotifierProviderElement<EnterPINCode, EnterPINCodeState>
    with EnterPINCodeRef {
  _EnterPINCodeProviderElement(super.provider);

  @override
  String get expectedPinHash =>
      (origin as EnterPINCodeProvider).expectedPinHash;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
