import 'dart:math';
import 'dart:ui';

import 'package:bomberman/core/base/model/coordinate.dart';
import 'package:bomberman/game/component/bomberman/bomberman.dart';
import 'package:bomberman/game/component/box/rock_box.dart';
import 'package:flame/flame.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

class BombGame extends Game with TapDetector {
  Size screenSize;
  List<Bomberman> bombermans;

  double get characterHeight => screenSize.width * 0.1;

  BombGame() {
    init();
  }

  RockBox box;
  Future<void> init() async {
    bombermans = [];
    final size = await Flame.util.initialDimensions();
    screenSize = size;
    box = RockBox(this);

    spawnBomberman();
  }

  @override
  void render(Canvas canvas) {
    Rect backgroundRect =
        Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.green[900];
    canvas.drawRect(backgroundRect, backgroundPaint);
    box.drawAllScreenBox(canvas);
    bombermans.forEach((element) {
      element.render(canvas);
    });
  }

  @override
  void update(double value) {
    bombermans.forEach((element) {
      element.update(value);
    });
  }

  void spawnBomberman() {
    bombermans.add(
      Bomberman(
        this,
        Coordinate(randomWidthNumber, randomHeightNumber),
      ),
    );
  }

  @override
  void onTapDown(TapDownDetails details) {
    bombermans.forEach((element) {
      element.onTapDown();
    });
  }

  @override
  void onTapUp(TapUpDetails details) {
    bombermans.forEach((element) {
      element.onTapUp();
    });
  }

  double get randomWidthNumber =>
      Random().nextDouble() * (screenSize.width - characterHeight);
  double get randomHeightNumber =>
      Random().nextDouble() * (screenSize.width - characterHeight);
}
