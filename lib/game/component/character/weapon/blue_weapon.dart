import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/base/base_component.dart';
import '../../../bomb/bomb_game.dart';

class BlueWeapon extends BaseComponent {
  final BombGame game;
  Rect bombermanRect;
  Paint bombermanPaint;
  double xPosition = 0;

  BlueWeapon(
    this.game,
  ) {
    xPosition = coordinate.x;
    bombermanPaint = Paint();
    bombermanPaint.color = Colors.black;
  }

  double get boxSize => game.screenSize.width * 0.12;

  void onTapDown() {}

  void onTapUp() {
    if (game.screenSize.width * 0.8 > xPosition) {
      if (game.screenSize.width * 0.8 > xPosition + 10) {
        xPosition += 10;
      } else {
        xPosition += game.screenSize.width * 0.8 - xPosition;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(bombermanRect, bombermanPaint);
  }

  @override
  void update(double value) {
    bombermanRect = Rect.fromLTWH(xPosition, coordinate.y, game.screenSize.width * 0.1, game.screenSize.width * 0.1);
  }
}
