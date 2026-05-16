import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/features/child/home/home_tab_provider.dart';
import 'package:monikid/mock_up/transaction/mock_transaction_seeder.dart';
import 'package:monikid/shared/widgets/primary_button.dart';

/// [DEV ONLY] Seed mock transactions button
class SeedMockButton extends HookConsumerWidget {
  const SeedMockButton({required this.uid, super.key});

  final String? uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSeeding = useState(false);
    final resultMessage = useState<String?>(null);

    Future<void> handleSeed() async {
      if (uid == null) {
        resultMessage.value = '❌ Không tìm thấy userId';
        return;
      }

      isSeeding.value = true;
      resultMessage.value = null;

      try {
        final result = await MockTransactionSeeder.seedToFirestore(
          userId: uid!,
        );
        await ref.read(homeTabNotifierProvider.notifier).refresh();
        if (!context.mounted) {
          return;
        }

        if (result.hasErrors) {
          resultMessage.value =
              '⚠️ ${result.success}/30 thành công, bỏ qua ${result.skipped} giao dịch đã tồn tại.\n'
              'Lỗi (${result.failed.length}):\n'
              '${result.failed.take(3).join('\n')}';
        } else {
          resultMessage.value =
              '✅ ${result.success}/30 giao dịch đã được tạo! Bỏ qua ${result.skipped} đã tồn tại.';
        }
      } catch (e) {
        if (context.mounted) {
          resultMessage.value = '❌ Lỗi seed: $e';
        }
      } finally {
        isSeeding.value = false;
      }
    }

    return Column(
      children: [
        PrimaryButton(
          text: 'Seed Transactions',
          isLoading: isSeeding.value,
          onPressed: () => handleSeed(),
        ),
        if (resultMessage.value != null) ...[
          const SizedBox(height: 8),
          Text(
            resultMessage.value!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ],
    );
  }
}
