import 'package:freezed_annotation/freezed_annotation.dart';

part 'pin_gateway_state.freezed.dart';

enum PinGatewayStatus {
  initial,
  loading,
  createPinRequired,
  enterPinRequired,
  error,
}

@freezed
abstract class PinGatewayState with _$PinGatewayState {
  const factory PinGatewayState({
    @Default(PinGatewayStatus.initial) PinGatewayStatus status,
    String? errorMessage,
  }) = _PinGatewayState;

  const PinGatewayState._();
}
