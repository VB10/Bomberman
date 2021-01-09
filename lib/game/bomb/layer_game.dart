import 'dart:ui';

import 'package:flame/game/game.dart';
import 'package:flame/layer/layer.dart';

class LayerGame extends Game {
  Layer gameLayer;
  Layer backgroundLayer;

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    gameLayer.render(canvas);
    backgroundLayer.render(canvas);
  }

  @override
  Color backgroundColor() => const Color(0xFF38607C);
}
