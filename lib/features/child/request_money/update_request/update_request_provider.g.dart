// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateRequestHash() => r'df3fcf3f8c80030bb94e6905ee48d387b9676665';

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

abstract class _$UpdateRequest
    extends BuildlessAutoDisposeNotifier<UpdateRequestState> {
  late final RequestMoneyModel initialRequest;

  UpdateRequestState build(RequestMoneyModel initialRequest);
}

/// See also [UpdateRequest].
@ProviderFor(UpdateRequest)
const updateRequestProvider = UpdateRequestFamily();

/// See also [UpdateRequest].
class UpdateRequestFamily extends Family<UpdateRequestState> {
  /// See also [UpdateRequest].
  const UpdateRequestFamily();

  /// See also [UpdateRequest].
  UpdateRequestProvider call(RequestMoneyModel initialRequest) {
    return UpdateRequestProvider(initialRequest);
  }

  @override
  UpdateRequestProvider getProviderOverride(
    covariant UpdateRequestProvider provider,
  ) {
    return call(provider.initialRequest);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateRequestProvider';
}

/// See also [UpdateRequest].
class UpdateRequestProvider
    extends AutoDisposeNotifierProviderImpl<UpdateRequest, UpdateRequestState> {
  /// See also [UpdateRequest].
  UpdateRequestProvider(RequestMoneyModel initialRequest)
    : this._internal(
        () => UpdateRequest()..initialRequest = initialRequest,
        from: updateRequestProvider,
        name: r'updateRequestProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateRequestHash,
        dependencies: UpdateRequestFamily._dependencies,
        allTransitiveDependencies:
            UpdateRequestFamily._allTransitiveDependencies,
        initialRequest: initialRequest,
      );

  UpdateRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialRequest,
  }) : super.internal();

  final RequestMoneyModel initialRequest;

  @override
  UpdateRequestState runNotifierBuild(covariant UpdateRequest notifier) {
    return notifier.build(initialRequest);
  }

  @override
  Override overrideWith(UpdateRequest Function() create) {
    return ProviderOverride(
      origin: this,
      override: UpdateRequestProvider._internal(
        () => create()..initialRequest = initialRequest,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialRequest: initialRequest,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<UpdateRequest, UpdateRequestState>
  createElement() {
    return _UpdateRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateRequestProvider &&
        other.initialRequest == initialRequest;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialRequest.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateRequestRef on AutoDisposeNotifierProviderRef<UpdateRequestState> {
  /// The parameter `initialRequest` of this provider.
  RequestMoneyModel get initialRequest;
}

class _UpdateRequestProviderElement
    extends
        AutoDisposeNotifierProviderElement<UpdateRequest, UpdateRequestState>
    with UpdateRequestRef {
  _UpdateRequestProviderElement(super.provider);

  @override
  RequestMoneyModel get initialRequest =>
      (origin as UpdateRequestProvider).initialRequest;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
