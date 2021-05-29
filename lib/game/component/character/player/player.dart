import 'dart:math';
import 'dart:ui';

import 'package:flame/components/joystick/joystick_component.dart';
import 'package:flame/components/joystick/joystick_events.dart';
import 'package:flame/sprite.dart';

import '../../../../core/asset/image/image_load_manager.dart';
import '../../../../core/base/base_component.dart';
import '../../../../product/manager/model/player_attack_model.dart';
import '../../../../product/manager/model/player_attack_observer.dart';
import '../../../../product/manager/player_fire.dart';
import '../../../../product/model/box_model.dart';
import '../../box/rock_component.dart';

class Player extends BaseComponent implements JoystickListener {
  final double speed = 159;
  double currentSpeed = 0;
  double radAngle = 0;
  bool _move = false;
  BoxModelUtil _boxModelUtil;

  List<Rock> items = [];

  final Rock component;

  Sprite backgroundSprite;

  final attack = PlayerAttack('Player vb');

  final void Function(Rect rect) onStartAttack;

  Size screenSize;

  Rect _rect;
  final PlayerAttackManagers managers;
  Rect get rect => _rect;
  List<Rect> boxItems = [];

  Player(this.screenSize, this.component, this.onStartAttack, this.managers) {
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
    if (event.id == 2 && event.event == ActionEvent.UP) {
      managers.model = PlayerAttackModel(Rect.fromLTWH(_rect.left, _rect.top, 30, 30), 10);
    }
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

    if (!boolBoxRectangle(newPosition)) {
      return;
    }

    if (boxItems.contains((Rect element) => element.top > newPosition.top + _boxModelUtil.boxSize)) {
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

    _rect = newPosition;
  }

  bool boolBoxRectangle(Rect newPosition) {
    return newPosition.right < screenSize.width - _boxModelUtil.boxSize &&
        newPosition.left > _boxModelUtil.boxSize &&
        newPosition.top > _boxModelUtil.boxSize &&
        newPosition.bottom < screenSize.height - _boxModelUtil.boxSize;
  }
}
