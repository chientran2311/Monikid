import 'package:flutter/material.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

class DetailTransactionBottomBar extends StatelessWidget {
  const DetailTransactionBottomBar({
    super.key,
    required this.isDark,
    required this.bgColor,
    required this.onDelete,
  });

  final bool isDark;
  final Color bgColor;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            bgColor.withValues(alpha: 0),
            bgColor,
          ],
          stops: const [0.0, 0.28],
        ),
      ),
      child: _DeleteButton(onTap: onDelete),
    );
  }
}

class _DeleteButton extends StatefulWidget {
  const _DeleteButton({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<_DeleteButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          height: 58.h,
          decoration: BoxDecoration(
            color: AppTheme.dangerSurface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppTheme.dangerBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_outline, color: AppTheme.redAlert, size: 20.r),
              SizedBox(width: 8.w),
              Text(
                s.transactionDeleteAction,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.redAlert,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
