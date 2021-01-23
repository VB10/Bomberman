import 'dart:ui';

import 'package:flame/sprite.dart';

import '../../../../core/asset/image/image_load_manager.dart';
import '../../../../core/base/base_component.dart';
import '../../../../core/base/model/coordinate.dart';

class MonsterCarPlayer extends BaseComponent {
  Sprite backgroundSprite;
  final Size screenSize;
  Rect bombermanRect;

  final Size monsterSize;

  MonsterCarPlayer({this.screenSize, Coordinate coordinate, this.monsterSize}) {
    backgroundSprite = Sprite(ImageLoad.instance.monsterCar);
    this.coordinate = coordinate;
    bombermanRect = Rect.fromLTWH(coordinate.x, coordinate.y, monsterSize.width, monsterSize.height);
  }

  @override
  void render(Canvas canvas) {
    backgroundSprite.renderRect(canvas, bombermanRect);
  }

  @override
  void update(double value) {}
}
