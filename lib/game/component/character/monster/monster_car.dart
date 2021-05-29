import 'dart:ui';

import 'package:flame/sprite.dart';

import '../../../../core/asset/image/image_load_manager.dart';
import '../../../../core/base/base_component.dart';
import '../../../../core/base/model/coordinate.dart';
import '../../../../core/extension/number/number_extension.dart';
import '../../../../product/manager/model/player_attack_observer.dart';

class MonsterCarPlayer extends BaseComponent {
  Sprite backgroundSprite;
  final Size screenSize;
  Rect bombermanRect;

  final Size monsterSize;

  final int _positionYMaxiumum = 4;

  Offset targetLocation;
  int position = 0;
  bool _isAttacked = false;
  bool _isFirstPlay = true;

  PlayerAttack attackModel;
  double speet = 2;
  void setTargetLocation() {
    targetLocation = Offset(coordinate.x, (15.0).randomToMax);
  }

  MonsterCarPlayer({this.screenSize, Coordinate coordinate, this.monsterSize}) {
    attackModel = PlayerAttack(
      'monster',
      listen: (model) {
        if (model.isNestedRect(bombermanRect)) {
          _changeAtackState();
        }
        print(model);
      },
    );
    backgroundSprite = Sprite(ImageLoad.instance.monsterCar);
    this.coordinate = coordinate;
    bombermanRect = Rect.fromLTWH(coordinate.x, coordinate.y, monsterSize.width, monsterSize.height);
    setTargetLocation();
  }

  @override
  void render(Canvas canvas) {
    backgroundSprite.renderRect(canvas, bombermanRect);
  }

  @override
  void update(double value) {
    moveMonsterAxisY(value);
  }

  void moveMonsterAxisY(double value) {
    var stepDistance = 10 * value;
    var toTarget = targetLocation - Offset(bombermanRect.left, bombermanRect.top);
    if (stepDistance < toTarget.distance) {
      var stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      bombermanRect = bombermanRect.shift(stepToTarget);
    } else {
      bombermanRect = bombermanRect.shift(toTarget);
      setTargetLocation();
    }
  }
}

extension on MonsterCarPlayer {
  void _changeAtackState() {
    _isAttacked = true;
  }
}
