import 'package:flutter/material.dart';

import 'package:monikid/core/utils/screen_utils.dart';

/// A reusable popup menu button with consistent styling across the app.
/// 
/// Features:
/// - Rounded border radius (25.r)
/// - Generic type support
/// - Customizable child or icon
/// - Consistent offset and styling
class AppPopupMenuButton<T> extends StatelessWidget {
  const AppPopupMenuButton({
    super.key,
    required this.itemBuilder,
    required this.onSelected,
    this.child,
    this.icon,
    this.offset = const Offset(0, 40),
    this.initialValue,
    this.onOpened,
    this.onCanceled,
    this.enabled = true,
    this.elevation,
    this.color,
    this.shape,
    this.constraints,
    this.position,
    this.clipBehavior = Clip.none,
  }) : assert(
          child != null || icon != null,
          'Either child or icon must be provided',
        );

  /// Called when the button is pressed to create the items to show in the menu.
  final PopupMenuItemBuilder<T> itemBuilder;

  /// Called when the user selects a value from the popup menu.
  final PopupMenuItemSelected<T>? onSelected;

  /// If provided, [child] is the widget used for this button.
  final Widget? child;

  /// If provided, the [icon] is used for this button.
  final Widget? icon;

  /// The offset applied relative to the initial position.
  final Offset offset;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  final T? initialValue;

  /// Called when the popup menu is shown.
  final VoidCallback? onOpened;

  /// Called when the user dismisses the popup menu without selecting an item.
  final VoidCallback? onCanceled;

  /// Whether this popup menu button is interactive.
  final bool enabled;

  /// The z-coordinate at which to place the menu when open.
  final double? elevation;

  /// The background color used for the menu.
  final Color? color;

  /// The shape used for the menu. Defaults to rounded rectangle with 25.r radius.
  final ShapeBorder? shape;

  /// Optional size constraints for the menu.
  final BoxConstraints? constraints;

  /// Whether the popup menu is positioned over or under the popup menu button.
  final PopupMenuPosition? position;

  /// The clip behavior for the menu.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      offset: offset,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
      itemBuilder: itemBuilder,
      onSelected: onSelected,
      initialValue: initialValue,
      onOpened: onOpened,
      onCanceled: onCanceled,
      enabled: enabled,
      elevation: elevation,
      color: color,
      constraints: constraints,
      position: position,
      clipBehavior: clipBehavior,
      icon: icon,
      child: child,
    );
  }
}
