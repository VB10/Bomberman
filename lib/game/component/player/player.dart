import 'dart:math';
import 'dart:ui';

import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/components/joystick/joystick_events.dart';
import 'package:flame/palette.dart';

import '../../../core/base/base_component.dart';
import '../../../product/model/box_model.dart';

class Player extends BaseComponent implements JoystickListener {
  final _whitePaint = BasicPalette.white.paint;
  final _bluePaint = Paint()..color = const Color(0xFF0000FF);
  final _greenPaint = Paint()..color = const Color(0xFF00FF00);
  final double speed = 159;
  double currentSpeed = 0;
  double radAngle = 0;
  bool _move = false;
  Paint _paint;
  BoxModelUtil _boxModelUtil;

  Size screenSize;

  Rect _rect;

  Player(this.screenSize) {
    _paint = _whitePaint;
    _boxModelUtil = BoxModelUtil(screenSize);
  }

  @override
  void render(Canvas canvas) {
    if (_rect != null) {
      canvas.save();
      canvas.translate(_rect.center.dx, _rect.center.dy);
      canvas.rotate(radAngle == 0.0 ? 0.0 : radAngle + (pi / 2));
      canvas.translate(-_rect.center.dx, -_rect.center.dy);
      canvas.drawRect(_rect, _paint);
      canvas.restore();
    }
  }

  @override
  void update(double dt) {
    if (_move) moveFromAngle(dt);
  }

  @override
  void resize(Size size) {
    _rect = Rect.fromLTWH(_boxModelUtil.boxSize, this.screenSize.height - _boxModelUtil.boxSize * 2, _boxModelUtil.boxSize, _boxModelUtil.boxSize);
    super.resize(size);
  }

  @override
  void joystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN) {
      if (event.id == 1) {
        _paint = _paint == _whitePaint ? _bluePaint : _whitePaint;
      }
      if (event.id == 2) {
        _paint = _paint == _whitePaint ? _greenPaint : _whitePaint;
      }
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

  void moveFromAngle(double dtUpdate) {
    final double nextX = (currentSpeed * dtUpdate) * cos(radAngle);
    final double nextY = (currentSpeed * dtUpdate) * sin(radAngle);

    final Offset nextPoint = Offset(nextX, nextY);
    final Offset diffBase = Offset(_rect.center.dx + nextPoint.dx, _rect.center.dy + nextPoint.dy) - _rect.center;

    final Rect newPosition = _rect.shift(diffBase);
    if (newPosition.right < screenSize.width - _boxModelUtil.boxSize && newPosition.left > _boxModelUtil.boxSize) {
      _rect = newPosition;
    }
  }
}
