// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionStreamHash() => r'8e1098529909b0e775648d554f8ceb43137a9e3f';

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
String _$homeTabNotifierHash() => r'e0762d03b12fbf98ccec2ba23166a2cc6a0609f4';

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
