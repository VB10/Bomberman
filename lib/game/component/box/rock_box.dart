import 'dart:ui';

import 'package:bomberman/core/asset/image/image_load_manager.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../../../core/base/base_component.dart';
import '../../bomb/bomb_game.dart';

class RockBox extends BaseComponent {
  final BombGame game;
  Rect bombermanRect;
  Paint bombermanPaint;
  Sprite backgroundSprite;

  double get boxSize => game.screenSize.width * 0.1;

  RockBox(this.game) {
    bombermanRect = Rect.fromLTWH(0, 0, boxSize, boxSize);
    bombermanPaint = Paint();
    bombermanPaint.color = Colors.black;
    backgroundSprite = Sprite(ImageLoad.instance.wallImage);
  }
  @override
  void render(Canvas canvas) {
    // canvas.drawRect(bombermanRect, bombermanPaint);
    // backgroundSprite.renderRect(canvas, Rect.fromLTWH(0, 0, 100, 100));
  }

  void drawAllScreenBox(Canvas canvas) {
    final headerRowLength = game.screenSize.width / boxSize;
    final headerColumnLength = game.screenSize.height / boxSize;

    for (var i = 0; i < headerColumnLength; i++) {
      final rect = Rect.fromLTWH(0, boxSize * i, boxSize, boxSize);
      final rect2 = Rect.fromLTWH(
          game.screenSize.width - boxSize, boxSize * i, boxSize, boxSize);
      backgroundSprite.renderRect(canvas, rect);
      backgroundSprite.renderRect(canvas, rect2);
    }

    for (var i = 0; i < headerRowLength; i++) {
      final rect = Rect.fromLTWH(boxSize * i, 0, boxSize, boxSize);
      backgroundSprite.renderRect(canvas, rect);
      final rect2 = Rect.fromLTWH(
          boxSize * i, game.screenSize.height - boxSize, boxSize, boxSize);
      backgroundSprite.renderRect(canvas, rect2);
    }
  }

  @override
  void update(double value) {
    // TODO: implement update
  }
}
