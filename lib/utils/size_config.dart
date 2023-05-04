
import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? _screenWidth;
  static double? _screenHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData!.size.width;
    _screenHeight = _mediaQueryData!.size.height;
  }

  static double getFullWidth() {
    return _screenWidth!;
  }

  static double getFullHeight() {
    return _screenHeight!;
  }

  static calculateHorizontal(double size) {
    return (size / 320) * _screenWidth!;
  }

  static calculateVertical(double size) {
    return (size / 844) * _screenHeight!;
  }
}
