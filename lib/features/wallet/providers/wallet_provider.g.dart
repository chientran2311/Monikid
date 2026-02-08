// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$walletRepositoryHash() => r'cee7615108db57464e7d3ec6a056f4834c248e94';

/// Repository provider
///
/// Copied from [walletRepository].
@ProviderFor(walletRepository)
final walletRepositoryProvider = AutoDisposeProvider<WalletRepository>.internal(
  walletRepository,
  name: r'walletRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletRepositoryRef = AutoDisposeProviderRef<WalletRepository>;
String _$walletHash() => r'4d18be45f86a48f9c478c04663218bcdea96dc31';

/// Main wallet provider
///
/// Copied from [Wallet].
@ProviderFor(Wallet)
final walletProvider = NotifierProvider<Wallet, WalletState>.internal(
  Wallet.new,
  name: r'walletProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Wallet = Notifier<WalletState>;
String _$transactionHistoryHash() =>
    r'd4eb47fccb94675b56f1f19e963e6880e970f15d';

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

abstract class _$TransactionHistory
    extends BuildlessAutoDisposeAsyncNotifier<List<Transaction>> {
  late final int limit;
  late final int offset;

  FutureOr<List<Transaction>> build({int limit = 20, int offset = 0});
}

/// Provider for transaction history with pagination
///
/// Copied from [TransactionHistory].
@ProviderFor(TransactionHistory)
const transactionHistoryProvider = TransactionHistoryFamily();

/// Provider for transaction history with pagination
///
/// Copied from [TransactionHistory].
class TransactionHistoryFamily extends Family<AsyncValue<List<Transaction>>> {
  /// Provider for transaction history with pagination
  ///
  /// Copied from [TransactionHistory].
  const TransactionHistoryFamily();

  /// Provider for transaction history with pagination
  ///
  /// Copied from [TransactionHistory].
  TransactionHistoryProvider call({int limit = 20, int offset = 0}) {
    return TransactionHistoryProvider(limit: limit, offset: offset);
  }

  @override
  TransactionHistoryProvider getProviderOverride(
    covariant TransactionHistoryProvider provider,
  ) {
    return call(limit: provider.limit, offset: provider.offset);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'transactionHistoryProvider';
}

/// Provider for transaction history with pagination
///
/// Copied from [TransactionHistory].
class TransactionHistoryProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          TransactionHistory,
          List<Transaction>
        > {
  /// Provider for transaction history with pagination
  ///
  /// Copied from [TransactionHistory].
  TransactionHistoryProvider({int limit = 20, int offset = 0})
    : this._internal(
        () => TransactionHistory()
          ..limit = limit
          ..offset = offset,
        from: transactionHistoryProvider,
        name: r'transactionHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$transactionHistoryHash,
        dependencies: TransactionHistoryFamily._dependencies,
        allTransitiveDependencies:
            TransactionHistoryFamily._allTransitiveDependencies,
        limit: limit,
        offset: offset,
      );

  TransactionHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
    required this.offset,
  }) : super.internal();

  final int limit;
  final int offset;

  @override
  FutureOr<List<Transaction>> runNotifierBuild(
    covariant TransactionHistory notifier,
  ) {
    return notifier.build(limit: limit, offset: offset);
  }

  @override
  Override overrideWith(TransactionHistory Function() create) {
    return ProviderOverride(
      origin: this,
      override: TransactionHistoryProvider._internal(
        () => create()
          ..limit = limit
          ..offset = offset,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
        offset: offset,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TransactionHistory, List<Transaction>>
  createElement() {
    return _TransactionHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionHistoryProvider &&
        other.limit == limit &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransactionHistoryRef
    on AutoDisposeAsyncNotifierProviderRef<List<Transaction>> {
  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `offset` of this provider.
  int get offset;
}

class _TransactionHistoryProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          TransactionHistory,
          List<Transaction>
        >
    with TransactionHistoryRef {
  _TransactionHistoryProviderElement(super.provider);

  @override
  int get limit => (origin as TransactionHistoryProvider).limit;
  @override
  int get offset => (origin as TransactionHistoryProvider).offset;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
