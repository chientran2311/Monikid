import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class AddTransactionAmountInput extends StatelessWidget {
  const AddTransactionAmountInput({
    super.key,
    required this.controller,
    required this.enabled,
    required this.textColor,
  });

  final TextEditingController controller;
  final bool enabled;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            s.transactionAmountLabel.toUpperCase(),
            style: context.typo.caption.big.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textGrey,
              letterSpacing: 0.65,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'đ',
                style: context.typo.title.big.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textMuted,
                ),
              ),
              SizedBox(width: 4.w),
              Flexible(
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                  ),
                  enabled: enabled,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  style: context.typo.display.big.copyWith(
                    fontSize: 56.sp,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    letterSpacing: -2.24,
                  ),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: context.typo.display.big.copyWith(
                      fontSize: 56.sp,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.iconLight,
                      letterSpacing: -2.24,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
