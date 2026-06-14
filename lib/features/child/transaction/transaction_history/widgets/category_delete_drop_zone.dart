import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:monikid/core/theme/theme.dart';
import 'package:monikid/core/utils/build_context_x.dart';
import 'package:monikid/core/utils/screen_utils.dart';
import 'package:monikid/models/entities/category_model.dart';

/// Bottom dock that slides up while a custom category is being dragged.
/// Dropping a category here triggers [onCategoryDropped].
class CategoryDeleteDropZone extends StatefulWidget {
  const CategoryDeleteDropZone({
    super.key,
    required this.visible,
    required this.isDark,
    required this.onCategoryDropped,
  });

  final bool visible;
  final bool isDark;
  final ValueChanged<CategoryModel> onCategoryDropped;

  @override
  State<CategoryDeleteDropZone> createState() => _CategoryDeleteDropZoneState();
}

class _CategoryDeleteDropZoneState extends State<CategoryDeleteDropZone> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final s = context.l10n;
    return IgnorePointer(
      ignoring: !widget.visible,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        offset: widget.visible ? Offset.zero : const Offset(0, 1.4),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 180),
          opacity: widget.visible ? 1 : 0,
          child: DragTarget<CategoryModel>(
            onWillAcceptWithDetails: (_) {
              HapticFeedback.mediumImpact();
              setState(() => _hovering = true);
              return true;
            },
            onLeave: (_) => setState(() => _hovering = false),
            onAcceptWithDetails: (details) {
              HapticFeedback.heavyImpact();
              setState(() => _hovering = false);
              widget.onCategoryDropped(details.data);
            },
            builder: (_, __, ___) => AnimatedScale(
              duration: const Duration(milliseconds: 160),
              scale: _hovering ? 1.08 : 1,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
                height: 72.h,
                decoration: BoxDecoration(
                  color: _hovering
                      ? AppTheme.redAlert.withValues(alpha: 0.18)
                      : AppTheme.dangerSurface,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: _hovering ? AppTheme.redDark : AppTheme.dangerBorder,
                    width: _hovering ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedScale(
                      duration: const Duration(milliseconds: 160),
                      scale: _hovering ? 1.25 : 1,
                      child: Icon(
                        _hovering ? Icons.delete_forever : Icons.delete_outline,
                        color: AppTheme.redDark,
                        size: 28.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      s.customCategoryDropToDelete,
                      style: context.typo.subtitle.small.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.redDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
