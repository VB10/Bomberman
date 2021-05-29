import 'dart:math';
import 'dart:ui';

import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/base/model/coordinate.dart';
import '../../product/manager/player_fire.dart';
import '../component/backgorund/rock_box_background.dart';
import '../component/backgorund/rock_box_random_backgorund.dart';
import '../component/backgorund/win_background.dart';
import '../component/box/rock_box.dart';
import '../component/box/rock_component.dart';
import '../component/character/monster/monster_car.dart';
import '../component/character/player/player.dart';
import '../joystick/joystick_manager.dart';

class BombGame extends BaseGame with TapDetector, MultiTouchDragDetector {
  final Size screenSize;
  Player player;

  double get characterHeight => screenSize.width * 0.1;
  Rock normalRock;
  RockBox box;
  BackgroundComponent backgroundComponent;

  final playerGameManager = PlayerAttackManagers();

  double get randomWidthNumber => Random().nextDouble() * (screenSize.width - characterHeight);
  double get randomHeightNumber => Random().nextDouble() * (screenSize.width - characterHeight);
  final joystick = JoystickComponent(actions: JoystickManager().actions);

  BombGame(this.screenSize) {
    box = RockBox(this);
    normalRock = Rock(this);
    player = Player(screenSize, normalRock, (rect) {}, playerGameManager);
    joystick.addObserver(player);
    final backgorundBox = BackgroundComponent(box);
    final randomBox = RockBoxRandomComponent(screenSize);
    final monsterCar = MonsterCarPlayer(
      listen: (data) {
        if (data) {
          final winnerCompponent = WinBackgroundComponent(screenSize);

          add(winnerCompponent);
        }
      },
      coordinate: Coordinate(screenSize.width - characterHeight * 3.5, characterHeight * 1.5),
      monsterSize: Size(characterHeight * 2, characterHeight * 2),
      screenSize: screenSize,
    );
    add(randomBox);
    add(normalRock);
    add(backgorundBox);
    add(monsterCar);
    player.boxItems = randomBox.boxItems;

    playerGameManager.attach(monsterCar.attackModel);
    playerGameManager.attach(normalRock.attackModel);

    add(player);
    add(joystick);
  }

  @override
  void onReceiveDrag(DragEvent drag) {
    joystick.onReceiveDrag(drag);
    super.onReceiveDrag(drag);
  }

  @override
  Color backgroundColor() => Colors.green[900];
}
