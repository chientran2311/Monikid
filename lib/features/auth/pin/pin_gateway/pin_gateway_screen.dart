import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:monikid/app/router.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

import 'pin_gateway_provider.dart';
import 'pin_gateway_state.dart';

class PinGatewayScreen extends HookConsumerWidget {
  const PinGatewayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenUtils.init(context);

    final state = ref.watch(pinGatewayProvider);
    final notifier = ref.read(pinGatewayProvider.notifier);
    final s = context.l10n;

    ref.listen<PinGatewayState>(pinGatewayProvider, (previous, next) {
      final statusChanged = previous?.status != next.status;
      if (!statusChanged || !context.mounted) {
        return;
      }

      if (next.status == PinGatewayStatus.createPinRequired) {
        context.go(AppRoutes.createNewPin);
      } else if (next.status == PinGatewayStatus.enterPinRequired) {
        context.go(AppRoutes.enterPinCode);
      }
    });

    useEffect(() {
      Future.microtask(notifier.onInit);
      return null;
    }, const []);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: state.status == PinGatewayStatus.error
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(s.pinGatewayError),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        notifier.reset();
                        notifier.onInit();
                      },
                      child: Text(s.actionRetry),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(s.pinGatewayLoading),
                  ],
                ),
        ),
      ),
    );
  }
}
