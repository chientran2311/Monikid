// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_family_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$linkedFamilyHash() => r'c6823ad46fa848292f347c8b8edab6d8f376cd27';

/// See also [linkedFamily].
@ProviderFor(linkedFamily)
final linkedFamilyProvider = AutoDisposeFutureProvider<FamilyModel?>.internal(
  linkedFamily,
  name: r'linkedFamilyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$linkedFamilyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LinkedFamilyRef = AutoDisposeFutureProviderRef<FamilyModel?>;
String _$familyMembersHash() => r'ef7acef4a93bd55385852031e036741d2561ba86';

/// See also [familyMembers].
@ProviderFor(familyMembers)
final familyMembersProvider =
    AutoDisposeStreamProvider<List<FamilyMemberModel>>.internal(
      familyMembers,
      name: r'familyMembersProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$familyMembersHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FamilyMembersRef =
    AutoDisposeStreamProviderRef<List<FamilyMemberModel>>;
String _$joinFamilyNotifierHash() =>
    r'a2f08985424487fbafc4d0f54199638fd6a4bb78';

/// See also [JoinFamilyNotifier].
@ProviderFor(JoinFamilyNotifier)
final joinFamilyNotifierProvider =
    AutoDisposeNotifierProvider<JoinFamilyNotifier, JoinFamilyState>.internal(
      JoinFamilyNotifier.new,
      name: r'joinFamilyNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$joinFamilyNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$JoinFamilyNotifier = AutoDisposeNotifier<JoinFamilyState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
