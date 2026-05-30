import 'package:flutter/material.dart';
import 'package:monikid/app/app.dart';
import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.errorMessage});

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.redAlert.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? s.transactionLoadError,
              textAlign: TextAlign.center,
              style: context.typo.subtitle.small.copyWith(color: AppTheme.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}
