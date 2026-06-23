// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_nav_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationNavHash() => r'ce993ee9e5ce6f05d03206de2fa319277cbdf735';

/// Holds a pending notification-tap navigation intent until a nav bar consumes
/// it. keepAlive so a cold-start intent survives the auth/PIN gate.
///
/// Copied from [NotificationNav].
@ProviderFor(NotificationNav)
final notificationNavProvider =
    NotifierProvider<NotificationNav, NotificationTapIntent?>.internal(
      NotificationNav.new,
      name: r'notificationNavProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationNavHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationNav = Notifier<NotificationTapIntent?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
