import 'package:flutter/widgets.dart';

class SizeConfig {
  static double? _screenWidth;
  static double? _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double? heightMultiplier;
  static double? widthMultiplier;

  void init(BoxConstraints constraints, Orientation orientation) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    _blockWidth = _screenWidth! / 100;
    _blockHeight = _screenHeight! / 100;

    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}
