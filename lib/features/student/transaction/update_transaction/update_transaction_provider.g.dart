// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateTransactionNotifierHash() =>
    r'125f3502078383284c35f8cd773a4367bc02a5ab';

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

abstract class _$UpdateTransactionNotifier
    extends BuildlessAutoDisposeNotifier<UpdateTransactionState> {
  late final TransactionModel transaction;

  UpdateTransactionState build(TransactionModel transaction);
}

/// See also [UpdateTransactionNotifier].
@ProviderFor(UpdateTransactionNotifier)
const updateTransactionNotifierProvider = UpdateTransactionNotifierFamily();

/// See also [UpdateTransactionNotifier].
class UpdateTransactionNotifierFamily extends Family<UpdateTransactionState> {
  /// See also [UpdateTransactionNotifier].
  const UpdateTransactionNotifierFamily();

  /// See also [UpdateTransactionNotifier].
  UpdateTransactionNotifierProvider call(TransactionModel transaction) {
    return UpdateTransactionNotifierProvider(transaction);
  }

  @override
  UpdateTransactionNotifierProvider getProviderOverride(
    covariant UpdateTransactionNotifierProvider provider,
  ) {
    return call(provider.transaction);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateTransactionNotifierProvider';
}

/// See also [UpdateTransactionNotifier].
class UpdateTransactionNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<
          UpdateTransactionNotifier,
          UpdateTransactionState
        > {
  /// See also [UpdateTransactionNotifier].
  UpdateTransactionNotifierProvider(TransactionModel transaction)
    : this._internal(
        () => UpdateTransactionNotifier()..transaction = transaction,
        from: updateTransactionNotifierProvider,
        name: r'updateTransactionNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateTransactionNotifierHash,
        dependencies: UpdateTransactionNotifierFamily._dependencies,
        allTransitiveDependencies:
            UpdateTransactionNotifierFamily._allTransitiveDependencies,
        transaction: transaction,
      );

  UpdateTransactionNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.transaction,
  }) : super.internal();

  final TransactionModel transaction;

  @override
  UpdateTransactionState runNotifierBuild(
    covariant UpdateTransactionNotifier notifier,
  ) {
    return notifier.build(transaction);
  }

  @override
  Override overrideWith(UpdateTransactionNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UpdateTransactionNotifierProvider._internal(
        () => create()..transaction = transaction,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        transaction: transaction,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<
    UpdateTransactionNotifier,
    UpdateTransactionState
  >
  createElement() {
    return _UpdateTransactionNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateTransactionNotifierProvider &&
        other.transaction == transaction;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, transaction.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateTransactionNotifierRef
    on AutoDisposeNotifierProviderRef<UpdateTransactionState> {
  /// The parameter `transaction` of this provider.
  TransactionModel get transaction;
}

class _UpdateTransactionNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          UpdateTransactionNotifier,
          UpdateTransactionState
        >
    with UpdateTransactionNotifierRef {
  _UpdateTransactionNotifierProviderElement(super.provider);

  @override
  TransactionModel get transaction =>
      (origin as UpdateTransactionNotifierProvider).transaction;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
