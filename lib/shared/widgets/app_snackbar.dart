import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/screen_utils.dart';

enum SnackBarType { success, error, warning, info }

class AppSnackBar {
  AppSnackBar._();

  static void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _SnackBarContent(message: message, type: type),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        padding: EdgeInsets.zero,
        duration: duration,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  static void success(BuildContext context, String message) =>
      show(context, message: message, type: SnackBarType.success);

  static void error(BuildContext context, String message) =>
      show(context, message: message, type: SnackBarType.error);

  static void warning(BuildContext context, String message) =>
      show(context, message: message, type: SnackBarType.warning);

  static void info(BuildContext context, String message) =>
      show(context, message: message, type: SnackBarType.info);
}

class _SnackBarContent extends StatelessWidget {
  const _SnackBarContent({required this.message, required this.type});

  final String message;
  final SnackBarType type;

  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(context);

    final cfg = _configFor(type);
    const textColor = Color(0xFF1F2937);
    const closeColor = Color(0xFF9CA3AF);

    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: cfg.badgeBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(cfg.icon, color: cfg.iconColor, size: 20.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              if (type == SnackBarType.info)
                SizedBox(
                  width: 16.r,
                  height: 16.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.chartBlue,
                    backgroundColor:
                        AppTheme.chartBlue.withValues(alpha: 0.25),
                  ),
                )
              else
                GestureDetector(
                  onTap: () =>
                      ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  child: Icon(Icons.close, color: closeColor, size: 18.r),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static ({Color badgeBg, Color iconColor, IconData icon}) _configFor(
    SnackBarType type,
  ) =>
      switch (type) {
        SnackBarType.success => (
          badgeBg: AppTheme.successSurface,
          iconColor: AppTheme.primary,
          icon: Icons.check_circle_rounded,
        ),
        SnackBarType.error => (
          badgeBg: AppTheme.dangerSurface,
          iconColor: AppTheme.redAlert,
          icon: Icons.cancel_rounded,
        ),
        SnackBarType.warning => (
          badgeBg: AppTheme.amberFill,
          iconColor: AppTheme.amberText,
          icon: Icons.warning_rounded,
        ),
        SnackBarType.info => (
          badgeBg: AppTheme.infoSurface,
          iconColor: AppTheme.chartBlue,
          icon: Icons.info_rounded,
        ),
      };
}
