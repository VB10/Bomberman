import 'dart:math';
import 'dart:ui';

import 'package:flame/components/joystick/joystick_action.dart';
import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/base/model/coordinate.dart';
import '../component/backgorund/rock_box_background.dart';
import '../component/backgorund/rock_box_random_backgorund.dart';
import '../component/box/rock_box.dart';
import '../component/box/rock_component.dart';
import '../component/character/bomberman/bomberman.dart';
import '../component/character/monster/monster_car.dart';
import '../component/character/player/player.dart';
import '../component/layer/backgorund_layer_wall.dart';

class BombGame extends BaseGame with TapDetector, MultiTouchDragDetector {
  Size screenSize;
  List<Bomberman> bombermans = [];
  Player player;
  double get characterHeight => screenSize.width * 0.1;
  Rock normalRock;
  RockBox box;
  BackgroundLayer layer;

  double get randomWidthNumber => Random().nextDouble() * (screenSize.width - characterHeight);
  double get randomHeightNumber => Random().nextDouble() * (screenSize.width - characterHeight);
  final joystick = JoystickComponent(
    actions: [
      JoystickAction(
        actionId: 1,
        size: 50,
        margin: const EdgeInsets.all(50),
        color: const Color(0xFF0000FF),
      ),
      JoystickAction(
        actionId: 2,
        size: 50,

        color: const Color(0xFF00FF00),
        // spritePressed: ,
        margin: const EdgeInsets.only(
          right: 50,
          bottom: 120,
        ),
      ),
      JoystickAction(
        actionId: 3,
        size: 50,
        margin: const EdgeInsets.only(bottom: 50, right: 120),
        enableDirection: true,
      ),
    ],
  );

  BombGame() {
    Flame.util.initialDimensions().then((value) {
      screenSize = value;
      box = RockBox(this);
      normalRock = Rock(this);
      player = Player(screenSize, normalRock, (rect) {
        normalRock.changeRect(rect);
      });
      // final bomberMan = Bomberman(this, Coordinate(screenSize.width - characterHeight * 3, characterHeight * 1.5));
      joystick.addObserver(player);
      final backgorundBox = BackgroundComponent(box);
      final randomBox = RockBoxRandomComponent(screenSize);
      final monsterCar = MonsterCarPlayer(
        coordinate: Coordinate(screenSize.width - characterHeight * 3.5, characterHeight * 1.5),
        monsterSize: Size(characterHeight * 2, characterHeight * 2),
        screenSize: screenSize,
      );

      add(randomBox);
      add(normalRock);
      add(backgorundBox);
      add(monsterCar);
      player.boxItems = randomBox.boxItems;
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
