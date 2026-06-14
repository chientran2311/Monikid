// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_family_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$linkedFamilyHash() => r'6221c04f45999ccef88d4f29b98483730dd3ca0a';

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
String _$familyMembersHash() => r'95efcb75475809e41403b67b79df21b76f7645ce';

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
    r'14246195f756a4c39734c45b5359c2ce3fc39a32';

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
