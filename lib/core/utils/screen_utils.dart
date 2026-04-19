import 'dart:math' as math;

import 'package:flutter/material.dart';

class ScreenUtils {
  ScreenUtils._();

  static const double _designWidth = 375;
  static const double _designHeight = 812;

  static double _screenWidth = _designWidth;
  static double _screenHeight = _designHeight;

  static double get screenWidth => _screenWidth;

  static double get screenHeight => _screenHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    _screenWidth = size.width;
    _screenHeight = size.height;
  }

  static double setWidth(num width) => width * (_screenWidth / _designWidth);

  static double setHeight(num height) =>
      height * (_screenHeight / _designHeight);

  static double setRadius(num radius) {
    final widthScale = _screenWidth / _designWidth;
    final heightScale = _screenHeight / _designHeight;
    return radius * math.min(widthScale, heightScale);
  }

  static double setSp(num size) {
    final widthScale = _screenWidth / _designWidth;
    final heightScale = _screenHeight / _designHeight;
    return size * math.min(widthScale, heightScale);
  }
}

extension ScreenSizeExtension on num {
  double get w => ScreenUtils.setWidth(this);

  double get h => ScreenUtils.setHeight(this);

  double get r => ScreenUtils.setRadius(this);

  double get sp => ScreenUtils.setSp(this);
}
