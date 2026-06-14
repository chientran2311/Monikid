import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:monikid/features/child/transaction/transaction_history/widgets/category_dialog.dart';
import 'package:monikid/models/entities/category_model.dart';

/// Wraps a custom [CategoryItemWidget] with an iOS-style jiggle while in
/// delete-mode and makes it draggable into the delete drop zone.
class DraggableCategoryItem extends StatefulWidget {
  const DraggableCategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.isDark,
    required this.jiggle,
    required this.onTap,
    required this.onDragStarted,
    required this.onDragEnded,
  });

  final CategoryModel category;
  final bool isSelected;
  final bool isDark;

  /// True while delete-mode is active (any custom item is being dragged).
  final bool jiggle;
  final VoidCallback onTap;
  final VoidCallback onDragStarted;
  final VoidCallback onDragEnded;

  @override
  State<DraggableCategoryItem> createState() => _DraggableCategoryItemState();
}

class _DraggableCategoryItemState extends State<DraggableCategoryItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _jiggleCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 140),
  );

  @override
  void didUpdateWidget(covariant DraggableCategoryItem old) {
    super.didUpdateWidget(old);
    if (widget.jiggle && !_jiggleCtrl.isAnimating) {
      _jiggleCtrl.repeat(reverse: true);
    } else if (!widget.jiggle && _jiggleCtrl.isAnimating) {
      _jiggleCtrl.stop();
      _jiggleCtrl.value = 0;
    }
  }

  @override
  void dispose() {
    _jiggleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = CategoryItemWidget(
      category: widget.category,
      isSelected: widget.isSelected,
      isDark: widget.isDark,
      onTap: widget.onTap,
    );

    return LongPressDraggable<CategoryModel>(
      data: widget.category,
      onDragStarted: () {
        HapticFeedback.selectionClick();
        widget.onDragStarted();
      },
      onDragEnd: (_) => widget.onDragEnded(),
      onDraggableCanceled: (_, __) => widget.onDragEnded(),
      feedback: Material(
        color: Colors.transparent,
        child: Transform.scale(scale: 1.12, child: item),
      ),
      childWhenDragging: Opacity(opacity: 0.25, child: item),
      child: AnimatedBuilder(
        animation: _jiggleCtrl,
        builder: (_, child) => Transform.rotate(
          angle: widget.jiggle ? (_jiggleCtrl.value - 0.5) * 0.1 : 0, // ±0.05 rad
          child: child,
        ),
        child: item,
      ),
    );
  }
}
