// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$parentNotificationStreamHash() =>
    r'a53d505d46851106066d729ebfa9ac000d0a5865';

/// See also [parentNotificationStream].
@ProviderFor(parentNotificationStream)
final parentNotificationStreamProvider =
    AutoDisposeStreamProvider<List<NotificationModel>>.internal(
      parentNotificationStream,
      name: r'parentNotificationStreamProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$parentNotificationStreamHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ParentNotificationStreamRef =
    AutoDisposeStreamProviderRef<List<NotificationModel>>;
String _$parentUnreadNotificationCountHash() =>
    r'b5db5c2461165609733f8923bacbc8e72282492f';

/// See also [parentUnreadNotificationCount].
@ProviderFor(parentUnreadNotificationCount)
final parentUnreadNotificationCountProvider = AutoDisposeProvider<int>.internal(
  parentUnreadNotificationCount,
  name: r'parentUnreadNotificationCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$parentUnreadNotificationCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ParentUnreadNotificationCountRef = AutoDisposeProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
