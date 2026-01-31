import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/config/app_constants.dart';
import 'package:monikid/shared/widgets/app_inputs.dart'; // Đảm bảo import AppOTPField

class VerifyPhoneDialog extends StatefulWidget {
  final String phoneNumber;

  const VerifyPhoneDialog({super.key, required this.phoneNumber});

  @override
  State<VerifyPhoneDialog> createState() => _VerifyPhoneDialogState();
}

class _VerifyPhoneDialogState extends State<VerifyPhoneDialog> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.borderRadiusXL,
      ),
      title: const Text('Xác thực số điện thoại'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Nhập mã OTP đã gửi đến\n${widget.phoneNumber}',
            textAlign: TextAlign.center,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondaryLight,
            ),
          ),
          const SizedBox(height: AppTheme.spacingLG),
          // Giả sử AppOTPField của bạn hoạt động như code cũ
          AppOTPField(
            onCompleted: (value) => otp = value,
            onChanged: (value) => otp = value,
          ),
          const SizedBox(height: AppTheme.spacingMD),
          Text(
            'Mã demo: ${AppConstants.demoOtpCode}',
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textTertiaryLight,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            if (otp == AppConstants.demoOtpCode) {
              Navigator.pop(context, true);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mã OTP không đúng')),
              );
            }
          },
          child: const Text('Xác nhận'),
        ),
      ],
    );
  }
}