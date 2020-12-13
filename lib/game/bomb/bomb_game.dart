import 'dart:math';
import 'dart:ui';

import 'package:bomberman/core/base/model/coordinate.dart';
import 'package:bomberman/game/component/bomberman/bomberman.dart';
import 'package:bomberman/game/component/box/rock_box.dart';
import 'package:bomberman/game/component/player/player.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/joystick/joystick_action.dart';
import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/components/joystick/joystick_directional.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/layer/layer.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class BombGame extends BaseGame with TapDetector, MultiTouchDragDetector {
  Size screenSize;
  List<Bomberman> bombermans = [];
  final player = Player();
  double get characterHeight => screenSize.width * 0.1;

  final joystick = JoystickComponent(
    directional: JoystickDirectional(),
    actions: [],
  );

  BombGame() {
    // init();

    Flame.util.initialDimensions().then((value) {
      screenSize = value;
      box = RockBox(this);
      joystick.addObserver(player);
      var x = BackgorundComponent(box);
      add(x);
      add(player);
      add(joystick);
    });

    // add();
    // add(box);
    // spawnBomberman();
    // box.drawAllScreenBox(canvas
  }

  @override
  void onReceiveDrag(DragEvent drag) {
    joystick.onReceiveDrag(drag);
    super.onReceiveDrag(drag);
  }

  RockBox box;
  Future<void> init() async {
    bombermans = [];
    final size = await Flame.util.initialDimensions();
    screenSize = size;
    box = RockBox(this);

    spawnBomberman();
  }

  BackgroundLayer layer;
  void addScreen() {
    Rect backgroundRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.green[900];
    // layer = BackgroundLayer();
    // add(BackgroundLayer());
    // var x = Canvas(BackgroundLayer());
    // add(LayerGame());
    // canvas.drawRect(backgroundRect, backgroundPaint);
    // box.drawAllScreenBox(canvas);
    // bombermans.forEach((element) {
    //   element.render(canvas);
    // });
  }

  // @mustCallSuper
  // void render(Canvas canvas) {
  //   Rect backgroundRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
  //   Paint backgroundPaint = Paint();
  //   backgroundPaint.color = Colors.green[900];
  //   canvas.drawRect(backgroundRect, backgroundPaint);
  //   box.drawAllScreenBox(canvas);
  //   bombermans.forEach((element) {
  //     element.render(canvas);
  //   });
  // }

  // @override
  // void update(double value) {
  //   bombermans.forEach((element) {
  //     element.update(value);
  //   });
  // }

  @override
  Color backgroundColor() => Colors.green[900];

  void spawnBomberman() {
    bombermans.add(
      Bomberman(
        this,
        Coordinate(randomWidthNumber, randomHeightNumber),
      ),
    );

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

  double get randomWidthNumber => Random().nextDouble() * (screenSize.width - characterHeight);
  double get randomHeightNumber => Random().nextDouble() * (screenSize.width - characterHeight);
}

class LayerGame extends Game {
  Layer gameLayer;
  Layer backgroundLayer;

  // @override
  // Future<void> onLoad() async {
  // final playerSprite = Sprite(await images.load('player.png'));
  // final enemySprite = Sprite(await images.load('enemy.png'));
  // final backgroundSprite = Sprite(await images.load('background.png'));

  // gameLayer = GameLayer(playerSprite, enemySprite);
  // backgroundLayer = BackgroundLayer(backgroundSprite);
  // }

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

class BackgroundLayer extends PreRenderedLayer {
  final List<Bomberman> wallItems;

  BackgroundLayer(this.wallItems) {
    preProcessors.add(ShadowProcessor());
  }

  @override
  void drawLayer() {
    wallItems.map((e) {
      e.render(canvas);
    });
  }
}

class BackgorundComponent extends Component {
  BackgroundLayer layer;

  final RockBox box;

  BackgorundComponent(this.box);
  @override
  void render(Canvas c) {
    box.drawAllScreenBox(c);
  }

  @override
  void update(double t) {}
}
