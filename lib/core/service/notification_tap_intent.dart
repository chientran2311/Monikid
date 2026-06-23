import 'dart:convert';

/// Where a notification tap should navigate.
enum NotificationTarget { parentStat, childStat, unknown }

/// Intent carried by a notification payload: built when scheduling,
/// parsed back when the user taps the notification.
class NotificationTapIntent {
  const NotificationTapIntent({
    required this.target,
    this.childUid,
    this.childName,
  });

  final NotificationTarget target;
  final String? childUid;
  final String? childName;

  /// Parent reminder → open parent statistic tab for [childUid].
  static String encodeParent({
    required String childUid,
    required String childName,
  }) =>
      jsonEncode({
        'target': 'parent_stat',
        'childUid': childUid,
        'name': childName,
      });

  /// Child reminder → open child statistic tab (own data, no uid needed).
  static String encodeChild() => jsonEncode({'target': 'child_stat'});

  /// Returns null when [payload] is null/empty/malformed.
  static NotificationTapIntent? tryParse(String? payload) {
    if (payload == null || payload.isEmpty) return null;
    try {
      final map = jsonDecode(payload) as Map<String, dynamic>;
      switch (map['target']) {
        case 'parent_stat':
          return NotificationTapIntent(
            target: NotificationTarget.parentStat,
            childUid: map['childUid'] as String?,
            childName: map['name'] as String?,
          );
        case 'child_stat':
          return const NotificationTapIntent(
            target: NotificationTarget.childStat,
          );
        default:
          return const NotificationTapIntent(
            target: NotificationTarget.unknown,
          );
      }
    } catch (_) {
      return null;
    }
  }
}
