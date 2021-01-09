import 'dart:math';
import 'dart:ui';

import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/components/joystick/joystick_directional.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

import '../component/backgorund/rock_box_background.dart';
import '../component/backgorund/rock_box_random_backgorund.dart';
import '../component/bomberman/bomberman.dart';
import '../component/box/rock_box.dart';
import '../component/layer/backgorund_layer_wall.dart';
import '../component/player/player.dart';

class BombGame extends BaseGame with TapDetector, MultiTouchDragDetector {
  Size screenSize;
  List<Bomberman> bombermans = [];
  Player player;
  double get characterHeight => screenSize.width * 0.1;

  RockBox box;
  BackgroundLayer layer;

  double get randomWidthNumber => Random().nextDouble() * (screenSize.width - characterHeight);
  double get randomHeightNumber => Random().nextDouble() * (screenSize.width - characterHeight);

  final joystick = JoystickComponent(
    directional: JoystickDirectional(),
    actions: [],
  );

  BombGame() {
    Flame.util.initialDimensions().then((value) {
      screenSize = value;
      box = RockBox(this);
      player = Player(screenSize);
      joystick.addObserver(player);
      final backgorundBox = BackgroundComponent(box);
      final randomBox = RockBoxRandomComponent(screenSize);
      add(randomBox);
      add(backgorundBox);

      add(player);
      add(joystick);
    });
  }

  @override
  void onReceiveDrag(DragEvent drag) {
    joystick.onReceiveDrag(drag);
    super.onReceiveDrag(drag);
  }

  @override
  Color backgroundColor() => Colors.green[900];

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
}
