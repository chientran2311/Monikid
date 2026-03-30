// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_pin_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createNewPINHash() => r'16eac0b4f5248528094828804d5932898ec5bba6';

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

abstract class _$CreateNewPIN
    extends BuildlessAutoDisposeNotifier<CreateNewPINState> {
  late final EnterPINCodeEnum type;
  late final String? pinCode;

  CreateNewPINState build(EnterPINCodeEnum type, {String? pinCode});
}

/// See also [CreateNewPIN].
@ProviderFor(CreateNewPIN)
const createNewPINProvider = CreateNewPINFamily();

/// See also [CreateNewPIN].
class CreateNewPINFamily extends Family<CreateNewPINState> {
  /// See also [CreateNewPIN].
  const CreateNewPINFamily();

  /// See also [CreateNewPIN].
  CreateNewPINProvider call(EnterPINCodeEnum type, {String? pinCode}) {
    return CreateNewPINProvider(type, pinCode: pinCode);
  }

  @override
  CreateNewPINProvider getProviderOverride(
    covariant CreateNewPINProvider provider,
  ) {
    return call(provider.type, pinCode: provider.pinCode);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createNewPINProvider';
}

/// See also [CreateNewPIN].
class CreateNewPINProvider
    extends AutoDisposeNotifierProviderImpl<CreateNewPIN, CreateNewPINState> {
  /// See also [CreateNewPIN].
  CreateNewPINProvider(EnterPINCodeEnum type, {String? pinCode})
    : this._internal(
        () => CreateNewPIN()
          ..type = type
          ..pinCode = pinCode,
        from: createNewPINProvider,
        name: r'createNewPINProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$createNewPINHash,
        dependencies: CreateNewPINFamily._dependencies,
        allTransitiveDependencies:
            CreateNewPINFamily._allTransitiveDependencies,
        type: type,
        pinCode: pinCode,
      );

  CreateNewPINProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.pinCode,
  }) : super.internal();

  final EnterPINCodeEnum type;
  final String? pinCode;

  @override
  CreateNewPINState runNotifierBuild(covariant CreateNewPIN notifier) {
    return notifier.build(type, pinCode: pinCode);
  }

  @override
  Override overrideWith(CreateNewPIN Function() create) {
    return ProviderOverride(
      origin: this,
      override: CreateNewPINProvider._internal(
        () => create()
          ..type = type
          ..pinCode = pinCode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        pinCode: pinCode,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CreateNewPIN, CreateNewPINState>
  createElement() {
    return _CreateNewPINProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateNewPINProvider &&
        other.type == type &&
        other.pinCode == pinCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, pinCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CreateNewPINRef on AutoDisposeNotifierProviderRef<CreateNewPINState> {
  /// The parameter `type` of this provider.
  EnterPINCodeEnum get type;

  /// The parameter `pinCode` of this provider.
  String? get pinCode;
}

class _CreateNewPINProviderElement
    extends AutoDisposeNotifierProviderElement<CreateNewPIN, CreateNewPINState>
    with CreateNewPINRef {
  _CreateNewPINProviderElement(super.provider);

  @override
  EnterPINCodeEnum get type => (origin as CreateNewPINProvider).type;
  @override
  String? get pinCode => (origin as CreateNewPINProvider).pinCode;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
