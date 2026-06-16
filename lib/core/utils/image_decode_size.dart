import 'package:flutter/widgets.dart';

/// Converts a widget's display size (logical pixels) into the physical pixel
/// size that an image should be decoded to.
///
/// Decoding an image at its display size — instead of its full source
/// resolution — sharply reduces memory use with no visible quality loss,
/// because the result still matches the device's physical pixel density.
///
/// [displaySize] is the width (or height) the widget actually paints, in
/// logical pixels. Pass the box size for fixed widgets (e.g. an avatar `32.r`),
/// or the screen width for full-width images.
/// Returns null when the resolved size is not yet positive (e.g. ScreenUtil
/// not initialized, so `.w`/`.r` evaluate to 0). A null cacheWidth disables
/// resize-on-decode for that frame and avoids the `cacheWidth > 0` assertion.
int? decodePixelsFor(BuildContext context, double displaySize) {
  final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
  final pixels = (displaySize * devicePixelRatio).ceil();
  return pixels > 0 ? pixels : null;
}
