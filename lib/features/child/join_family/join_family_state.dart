import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_family_state.freezed.dart';

enum JoinFamilyStatus { initial, loading, success, error }

@freezed
abstract class JoinFamilyState with _$JoinFamilyState {
  const factory JoinFamilyState({
    @Default(JoinFamilyStatus.initial) JoinFamilyStatus status,
    String? errorMessage,
  }) = _JoinFamilyState;

  const JoinFamilyState._();

  bool get isBusy => status == JoinFamilyStatus.loading;
  bool get isSuccess => status == JoinFamilyStatus.success;
  bool get isError => status == JoinFamilyStatus.error;
}
