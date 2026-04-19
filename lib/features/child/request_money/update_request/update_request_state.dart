import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_request_state.freezed.dart';

@freezed
abstract class UpdateRequestState with _$UpdateRequestState {
  const factory UpdateRequestState.initial() = _Initial;
  const factory UpdateRequestState.loading() = _Loading;
  const factory UpdateRequestState.success() = _Success;
  const factory UpdateRequestState.deleted() = _Deleted;
  const factory UpdateRequestState.error(String message) = _Error;
}

extension UpdateRequestStateX on UpdateRequestState {
  bool get isLoading => this is _Loading;
  bool get isSuccess => this is _Success;
  bool get isDeleted => this is _Deleted;
  bool get isError => this is _Error;
  String? get errorMessage => this is _Error ? (this as _Error).message : null;
}

