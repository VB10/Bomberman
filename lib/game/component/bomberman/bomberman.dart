import 'dart:ui';

import 'package:bomberman/core/base/base_component.dart';
import 'package:bomberman/core/base/model/coordinate.dart';
import 'package:bomberman/game/bomb/bomb_game.dart';
import 'package:flutter/material.dart';

class Bomberman extends BaseComponent {
  final BombGame game;
  Rect bombermanRect;
  Paint bombermanPaint;

  Bomberman(this.game, Coordinate coordinate) {
    bombermanRect = Rect.fromLTWH(coordinate.x, coordinate.y,
        game.screenSize.width * 0.1, game.screenSize.width * 0.1);
    bombermanPaint = Paint();
    bombermanPaint.color = Colors.red;
  }
  @override
  void render(Canvas canvas) {
    canvas.drawRect(bombermanRect, bombermanPaint);
  }

  @override
  void update(double value) {
    // TODO: implement update
  }
}
