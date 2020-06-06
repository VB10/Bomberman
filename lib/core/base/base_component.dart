import 'package:bomberman/core/base/model/coordinate.dart';
import 'package:flutter/rendering.dart';

abstract class BaseComponent {
  void render(Canvas canvas);
  void update(double value);
  Coordinate coordinate;
}
