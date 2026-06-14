import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monikid/core/di/di.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/image_decode_size.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/transaction_model.dart';
import 'package:monikid/repositories/transaction/transaction_repository.dart';

class TransactionDetailEvidenceSection extends HookConsumerWidget {
  const TransactionDetailEvidenceSection({
    required this.evidenceImage,
    required this.isDark,
    super.key,
  });

  final TransactionEvidenceImage evidenceImage;
  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mutedColor = isDark ? AppTheme.textMuted : AppTheme.textGrey;
    final imageUrlFuture = useMemoized(
      () => getIt<TransactionRepository>().getEvidenceDownloadUrl(
        evidenceImage,
      ),
      [evidenceImage.storagePath],
    );
    final imageUrlSnapshot = useFuture(imageUrlFuture);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.transactionDetailEvidenceLabel,
          style: context.typo.caption.big.copyWith(
          color: mutedColor,
          fontWeight: FontWeight.w500,
        ),
        ),
        SizedBox(height: 12.h),
        if (imageUrlSnapshot.connectionState == ConnectionState.waiting)
          Center(
            child: SizedBox(
              height: 200.h,
              child: const CircularProgressIndicator(),
            ),
          )
        else if (imageUrlSnapshot.hasError || imageUrlSnapshot.data == null)
          Container(
            height: 200.h,
            decoration: BoxDecoration(
              color: isDark
                  ? AppTheme.backgroundDark
                  : AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.broken_image_outlined,
                    size: 48.r,
                    color: mutedColor,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    context.l10n.transactionEvidenceLoadError,
                    style: context.typo.caption.big.copyWith(color: mutedColor),
                  ),
                ],
              ),
            ),
          )
        else
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              imageUrl: imageUrlSnapshot.data!,
              fit: BoxFit.cover,
              memCacheWidth: decodePixelsFor(
                context,
                MediaQuery.sizeOf(context).width,
              ),
              placeholder: (context, url) => Container(
                height: 200.h,
                color: isDark
                    ? AppTheme.backgroundDark
                    : AppTheme.backgroundLight,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppTheme.backgroundDark
                      : AppTheme.backgroundLight,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 48.r,
                    color: mutedColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
