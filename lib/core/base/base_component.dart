import 'package:flame/components/component.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';

import 'model/coordinate.dart';

abstract class BaseComponent extends Component {
  void render(Canvas canvas);
  void update(double value);
  Coordinate coordinate;

  Logger logger = Logger();
}
