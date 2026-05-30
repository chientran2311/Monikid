import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_state.freezed.dart';

enum NotificationSettingsStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
abstract class NotificationSettingsState with _$NotificationSettingsState {
  const factory NotificationSettingsState({
    @Default(NotificationSettingsStatus.initial) NotificationSettingsStatus status,
    @Default(false) bool enabled,
    @Default(21) int hour,
    @Default(0) int minute,
    String? errorMessage,
  }) = _NotificationSettingsState;

  const NotificationSettingsState._();

  bool get isLoading => status == NotificationSettingsStatus.loading;
  bool get hasError => status == NotificationSettingsStatus.error;

  String get formattedTime {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
