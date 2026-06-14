import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monikid/core/font/font.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class TransactionAmountSection extends StatelessWidget {
  const TransactionAmountSection({
    super.key,
    required this.controller,
    required this.enabled,
  });

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = context.l10n;
    return LayoutBuilder(
      builder: (context, constraints) {
        final inputWidth = constraints.maxWidth / 2;
        return Padding(
          padding: EdgeInsets.fromLTRB(0, 32.h, 0, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                s.transactionAmountInputLabel.toUpperCase(),
                style: AppTextStyleFactory.style(
                  size: AppFontSizes.bodySmall,
                  weight: FontWeight.w700,
                  color: AppTheme.textGrey,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: inputWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'đ',
                      style: AppTextStyleFactory.style(
                        size: AppFontSizes.headlineBig,
                        weight: FontWeight.w600,
                        color: AppTheme.textMuted,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        enabled: enabled,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        scrollPhysics: const ClampingScrollPhysics(),
                        style: AppTextStyleFactory.style(
                          size: 52,
                          weight: FontWeight.w800,
                          color: isDark ? AppTheme.textWhite : AppTheme.textBlack,
                          letterSpacing: -2.5,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.transparent,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: '0',
                          hintStyle: AppTextStyleFactory.style(
                            size: 52,
                            weight: FontWeight.w800,
                            color: AppTheme.textMuted,
                            letterSpacing: -2.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
