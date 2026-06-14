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
int decodePixelsFor(BuildContext context, double displaySize) {
  final devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
  return (displaySize * devicePixelRatio).ceil();
}
