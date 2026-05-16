import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class RequestActionButtons extends StatelessWidget {
  const RequestActionButtons({
    required this.onUpdate,
    required this.onDelete,
    required this.isSaving,
    required this.isDeleting,
    required this.backgroundColor,
    super.key,
  });

  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final bool isSaving;
  final bool isDeleting;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isSaving || isDeleting ? null : onUpdate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: AppTheme.primary.withValues(alpha: 0.3),
                ),
                child: isSaving
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.send, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Cập nhật yêu cầu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: TextButton(
                onPressed: isSaving || isDeleting ? null : onDelete,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.transparent),
                  ),
                ),
                child: isDeleting
                    ? const CircularProgressIndicator(color: Colors.red)
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_outline, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Xóa yêu cầu',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
