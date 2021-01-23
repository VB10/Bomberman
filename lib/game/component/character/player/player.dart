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

  Player(this.screenSize) {
    _boxModelUtil = BoxModelUtil(screenSize);
    backgroundSprite = Sprite(ImageLoad.instance.humanCar);
  }

  @override
  void render(Canvas canvas) {
    if (_rect != null) {
      canvas.save();
      canvas.translate(_rect.center.dx, _rect.center.dy);
      canvas.rotate(radAngle == 0.0 ? 0.0 : radAngle + (pi / 2));
      canvas.translate(-_rect.center.dx, -_rect.center.dy);
      drawPlayerCar(canvas: canvas, rect: _rect);
      canvas.restore();
    }
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
    _rect = Rect.fromLTWH(_boxModelUtil.boxSize, screenSize.height - _boxModelUtil.boxSize * 2, _boxModelUtil.boxSize, _boxModelUtil.boxSize);
    super.resize(size);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN) {}
  }

  @override
  void joystickChangeDirectional(JoystickDirectionalEvent event) {
    _move = event.directional != JoystickMoveDirectional.IDLE;
    if (_move) {
      radAngle = event.radAngle;
      currentSpeed = speed * event.intensity;
    }
  }

  void moveFromAngle(double dtUpdate) {
    final nextX = (currentSpeed * dtUpdate) * cos(radAngle);
    final nextY = (currentSpeed * dtUpdate) * sin(radAngle);

    final nextPoint = Offset(nextX, nextY);
    final diffBase = Offset(_rect.center.dx + nextPoint.dx, _rect.center.dy + nextPoint.dy) - _rect.center;

    final newPosition = _rect.shift(diffBase);
    if (newPosition.right < screenSize.width - _boxModelUtil.boxSize && newPosition.left > _boxModelUtil.boxSize) {
      _rect = newPosition;
    }
  }
}
