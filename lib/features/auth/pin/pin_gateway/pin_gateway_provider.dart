import 'package:logger/logger.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/features/auth/pin/create_new_pin/create_new_pin_provider.dart';
import 'package:monikid/repositories/auth/pin_code_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'pin_gateway_state.dart';

part 'pin_gateway_provider.g.dart';

@riverpod
class PinGateway extends _$PinGateway {
  late final Logger _logger;
  late final PinCodeRepository _pinCodeRepository;

  @override
  PinGatewayState build() {
    _logger = getIt<Logger>();
    _pinCodeRepository = ref.read(pinCodeRepositoryProvider);
    return const PinGatewayState();
  }

  Future<void> onInit() async {
    if (state.status != PinGatewayStatus.initial) {
      return;
    }

    _logger.d('PinGateway.onInit: start.');
    state = state.copyWith(
      status: PinGatewayStatus.loading,
      errorMessage: null,
    );

    try {
      final snapshot = await _pinCodeRepository.getPinSecuritySnapshot();
      if (snapshot.hasPinCode) {
        _logger.i('PinGateway.onInit: PIN exists, routing to enter.');
        state = state.copyWith(status: PinGatewayStatus.enterPinRequired);
        return;
      }

      _logger.i('PinGateway.onInit: no PIN, routing to create.');
      ref.read(createNewPINProvider.notifier).reset();
      state = state.copyWith(status: PinGatewayStatus.createPinRequired);
    } catch (error, stackTrace) {
      _logger.e(
        'PinGateway.onInit failed.',
        error: error,
        stackTrace: stackTrace,
      );
      state = state.copyWith(
        status: PinGatewayStatus.error,
        errorMessage: 'Failed to resolve the PIN flow.',
      );
    }
  }

  void reset() {
    state = const PinGatewayState();
  }
}
