// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_summary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$streamSummaryCardHash() => r'b5763e8538641bcefc6bb3421930e9db606cd6bb';

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

/// See also [streamSummaryCard].
@ProviderFor(streamSummaryCard)
const streamSummaryCardProvider = StreamSummaryCardFamily();

/// See also [streamSummaryCard].
class StreamSummaryCardFamily
    extends Family<AsyncValue<({double totalIncome, double totalExpense})>> {
  /// See also [streamSummaryCard].
  const StreamSummaryCardFamily();

  /// See also [streamSummaryCard].
  StreamSummaryCardProvider call({
    DateTime? date,
    DateTime? month,
    String? categoryKey,
    String? type,
  }) {
    return StreamSummaryCardProvider(
      date: date,
      month: month,
      categoryKey: categoryKey,
      type: type,
    );
  }

  @override
  StreamSummaryCardProvider getProviderOverride(
    covariant StreamSummaryCardProvider provider,
  ) {
    return call(
      date: provider.date,
      month: provider.month,
      categoryKey: provider.categoryKey,
      type: provider.type,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'streamSummaryCardProvider';
}

/// See also [streamSummaryCard].
class StreamSummaryCardProvider
    extends
        AutoDisposeStreamProvider<({double totalIncome, double totalExpense})> {
  /// See also [streamSummaryCard].
  StreamSummaryCardProvider({
    DateTime? date,
    DateTime? month,
    String? categoryKey,
    String? type,
  }) : this._internal(
         (ref) => streamSummaryCard(
           ref as StreamSummaryCardRef,
           date: date,
           month: month,
           categoryKey: categoryKey,
           type: type,
         ),
         from: streamSummaryCardProvider,
         name: r'streamSummaryCardProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$streamSummaryCardHash,
         dependencies: StreamSummaryCardFamily._dependencies,
         allTransitiveDependencies:
             StreamSummaryCardFamily._allTransitiveDependencies,
         date: date,
         month: month,
         categoryKey: categoryKey,
         type: type,
       );

  StreamSummaryCardProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
    required this.month,
    required this.categoryKey,
    required this.type,
  }) : super.internal();

  final DateTime? date;
  final DateTime? month;
  final String? categoryKey;
  final String? type;

  @override
  Override overrideWith(
    Stream<({double totalIncome, double totalExpense})> Function(
      StreamSummaryCardRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamSummaryCardProvider._internal(
        (ref) => create(ref as StreamSummaryCardRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
        month: month,
        categoryKey: categoryKey,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<({double totalIncome, double totalExpense})>
  createElement() {
    return _StreamSummaryCardProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamSummaryCardProvider &&
        other.date == date &&
        other.month == month &&
        other.categoryKey == categoryKey &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);
    hash = _SystemHash.combine(hash, categoryKey.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin StreamSummaryCardRef
    on
        AutoDisposeStreamProviderRef<
          ({double totalIncome, double totalExpense})
        > {
  /// The parameter `date` of this provider.
  DateTime? get date;

  /// The parameter `month` of this provider.
  DateTime? get month;

  /// The parameter `categoryKey` of this provider.
  String? get categoryKey;

  /// The parameter `type` of this provider.
  String? get type;
}

class _StreamSummaryCardProviderElement
    extends
        AutoDisposeStreamProviderElement<
          ({double totalIncome, double totalExpense})
        >
    with StreamSummaryCardRef {
  _StreamSummaryCardProviderElement(super.provider);

  @override
  DateTime? get date => (origin as StreamSummaryCardProvider).date;
  @override
  DateTime? get month => (origin as StreamSummaryCardProvider).month;
  @override
  String? get categoryKey => (origin as StreamSummaryCardProvider).categoryKey;
  @override
  String? get type => (origin as StreamSummaryCardProvider).type;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
