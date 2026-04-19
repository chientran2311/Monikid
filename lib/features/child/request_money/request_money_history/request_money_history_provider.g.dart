// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_money_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$requestMoneyHistoryHash() =>
    r'617f1519482759acb4576befa0d17544ea3909a6';

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

abstract class _$RequestMoneyHistory
    extends BuildlessAutoDisposeNotifier<RequestMoneyHistoryState> {
  late final RequestMoneyModel initialRequest;

  RequestMoneyHistoryState build(RequestMoneyModel initialRequest);
}

/// See also [RequestMoneyHistory].
@ProviderFor(RequestMoneyHistory)
const requestMoneyHistoryProvider = RequestMoneyHistoryFamily();

/// See also [RequestMoneyHistory].
class RequestMoneyHistoryFamily extends Family<RequestMoneyHistoryState> {
  /// See also [RequestMoneyHistory].
  const RequestMoneyHistoryFamily();

  /// See also [RequestMoneyHistory].
  RequestMoneyHistoryProvider call(RequestMoneyModel initialRequest) {
    return RequestMoneyHistoryProvider(initialRequest);
  }

  @override
  RequestMoneyHistoryProvider getProviderOverride(
    covariant RequestMoneyHistoryProvider provider,
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
  String? get name => r'requestMoneyHistoryProvider';
}

/// See also [RequestMoneyHistory].
class RequestMoneyHistoryProvider
    extends
        AutoDisposeNotifierProviderImpl<
          RequestMoneyHistory,
          RequestMoneyHistoryState
        > {
  /// See also [RequestMoneyHistory].
  RequestMoneyHistoryProvider(RequestMoneyModel initialRequest)
    : this._internal(
        () => RequestMoneyHistory()..initialRequest = initialRequest,
        from: requestMoneyHistoryProvider,
        name: r'requestMoneyHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$requestMoneyHistoryHash,
        dependencies: RequestMoneyHistoryFamily._dependencies,
        allTransitiveDependencies:
            RequestMoneyHistoryFamily._allTransitiveDependencies,
        initialRequest: initialRequest,
      );

  RequestMoneyHistoryProvider._internal(
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
  RequestMoneyHistoryState runNotifierBuild(
    covariant RequestMoneyHistory notifier,
  ) {
    return notifier.build(initialRequest);
  }

  @override
  Override overrideWith(RequestMoneyHistory Function() create) {
    return ProviderOverride(
      origin: this,
      override: RequestMoneyHistoryProvider._internal(
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
  AutoDisposeNotifierProviderElement<
    RequestMoneyHistory,
    RequestMoneyHistoryState
  >
  createElement() {
    return _RequestMoneyHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RequestMoneyHistoryProvider &&
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
mixin RequestMoneyHistoryRef
    on AutoDisposeNotifierProviderRef<RequestMoneyHistoryState> {
  /// The parameter `initialRequest` of this provider.
  RequestMoneyModel get initialRequest;
}

class _RequestMoneyHistoryProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          RequestMoneyHistory,
          RequestMoneyHistoryState
        >
    with RequestMoneyHistoryRef {
  _RequestMoneyHistoryProviderElement(super.provider);

  @override
  RequestMoneyModel get initialRequest =>
      (origin as RequestMoneyHistoryProvider).initialRequest;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
