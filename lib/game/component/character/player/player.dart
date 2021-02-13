import 'dart:math';
import 'dart:ui';

import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/components/joystick/joystick_events.dart';
import 'package:flame/sprite.dart';

import '../../../../core/asset/image/image_load_manager.dart';
import '../../../../core/base/base_component.dart';
import '../../../../product/model/box_model.dart';

class Player extends BaseComponent implements JoystickListener {
  final double speed = 159;
  double currentSpeed = 0;
  double radAngle = 0;
  bool _move = false;
  BoxModelUtil _boxModelUtil;

  Sprite backgroundSprite;

  Size screenSize;

  Rect _rect;
  List<Rect> boxItems = [];

  // List<Rect> get _boxUnique => List.;

  Player(this.screenSize) {
    _boxModelUtil = BoxModelUtil(screenSize);
    backgroundSprite = Sprite(ImageLoad.instance.humanCar);
  }

  @override
  void render(Canvas canvas) {
    if (_rect == null) return;
    canvas.save();
    canvas.translate(_rect.center.dx, _rect.center.dy);
    canvas.rotate(radAngle == 0.0 ? 0.0 : radAngle + (pi / 2));
    canvas.translate(-_rect.center.dx, -_rect.center.dy);
    drawPlayerCar(canvas: canvas, rect: _rect);
    canvas.restore();
  }

  void drawPlayerCar({Canvas canvas, Rect rect}) {
    backgroundSprite.renderRect(canvas, rect);
  }

  @override
  void update(double dt) {
    if (_move) moveFromAngle(dt);
  }

  @override
  void resize(Size size) {
    _rect = Rect.fromLTWH(_boxModelUtil.boxSize, _boxModelUtil.boxSize * 2, _boxModelUtil.boxSize, _boxModelUtil.boxSize);
    super.resize(size);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.MOVE) {
      _move = true;
      radAngle = event.radAngle;
      currentSpeed = speed * event.intensity;
    } else {
      _move = false;
    }
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    _move = event.directional != JoystickMoveDirectional.IDLE;
    if (_move) {
      radAngle = event.radAngle;
      currentSpeed = speed * event.intensity;
    }
  }

  bool isMoveOnX = true;
  bool isMoveBoxY = true;
  void moveFromAngle(double dtUpdate) {
    isMoveOnX = true;
    isMoveBoxY = true;
    final nextX = (currentSpeed * dtUpdate) * cos(radAngle);
    final nextY = (currentSpeed * dtUpdate) * sin(radAngle);

    final nextPoint = Offset(nextX, nextY);
    final diffBase = Offset(_rect.center.dx + nextPoint.dx, _rect.center.dy + nextPoint.dy) - _rect.center;

    final newPosition = _rect.shift(diffBase);
    for (var item in boxItems) {
      // if (item.center.distance) {

      // }
      // print('${item.left}} - ${newPosition.right}');

      // if ( item.left<newPosition.center.distance<item.right) {

      // }
      // print('${item.center.dx} - ${newPosition.center.dx}');
    }

    // _rect = newPosition;

    if (!boolBoxRectangle(newPosition)) {
      return;
    }

    if (boxItems.first.top > newPosition.top + _boxModelUtil.boxSize) {
    } else {
      boxItems.forEach((element) {
        if (!isMoveOnX) {
          return;
        }
        if (newPosition.overlaps(element)) {
          isMoveOnX = false;
        }
      });

      if (isMoveOnX) {
      } else {
        return;
      }
    }

    // boxItems.forEach((element) {
    //   if (!isMoveOnX && !isMoveBoxY) {
    //     return;
    //   }
    //   if (element.left < newPosition.right && element.right > newPosition.right) {
    //     isMoveOnX = false;
    //     isMoveBoxY = false;
    //     if (element.top > newPosition.top) {
    //       isMoveBoxY = true;
    //       isMoveOnX = true;
    //       // _rect = newPosition;
    //     }
    //   }
    // });

    // if (isMoveBoxY && isMoveOnX) {
    //   _rect = newPosition;
    // }
    _rect = newPosition;
  }

  bool boolBoxRectangle(Rect newPosition) {
    return newPosition.right < screenSize.width - _boxModelUtil.boxSize &&
        newPosition.left > _boxModelUtil.boxSize &&
        newPosition.top > _boxModelUtil.boxSize &&
        newPosition.bottom < screenSize.height - _boxModelUtil.boxSize;
  }
}
