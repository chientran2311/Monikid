// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionStreamHash() => r'5d418db08fb2f29d1b3c4fdfc6ff8337106974b4';

/// See also [transactionStream].
@ProviderFor(transactionStream)
final transactionStreamProvider =
    AutoDisposeStreamProvider<List<TransactionModel>>.internal(
      transactionStream,
      name: r'transactionStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionStreamRef =
    AutoDisposeStreamProviderRef<List<TransactionModel>>;
String _$homeMonthlySummaryHash() =>
    r'93dc7d4031a377d8e954f465033774960ea9e283';

/// See also [homeMonthlySummary].
@ProviderFor(homeMonthlySummary)
final homeMonthlySummaryProvider =
    AutoDisposeStreamProvider<
      ({double totalIncome, double totalExpense})
    >.internal(
      homeMonthlySummary,
      name: r'homeMonthlySummaryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$homeMonthlySummaryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeMonthlySummaryRef =
    AutoDisposeStreamProviderRef<({double totalIncome, double totalExpense})>;
String _$homeTabNotifierHash() => r'5778b5fa496aff1024f09c7f79d45c7a92b9d920';

/// See also [HomeTabNotifier].
@ProviderFor(HomeTabNotifier)
final homeTabNotifierProvider =
    AutoDisposeAsyncNotifierProvider<HomeTabNotifier, HomeTabState>.internal(
      HomeTabNotifier.new,
      name: r'homeTabNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$homeTabNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HomeTabNotifier = AutoDisposeAsyncNotifier<HomeTabState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
