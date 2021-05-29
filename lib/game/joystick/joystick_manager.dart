import 'package:flame/components/joystick/joystick_action.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../../core/asset/image/image_load_manager.dart';

class JoystickManager {
  List<JoystickAction> actions;

  JoystickManager() {
    actions = [_normalButton, _gunButton, _moveButton];
  }

  final _normalButton = JoystickAction(
    actionId: 1,
    size: 50,
    sprite: Sprite(ImageLoad.instance.vb10),
    margin: EdgeInsets.all(50),
    color: Colors.blue,
  );

  final _gunButton = JoystickAction(
    actionId: 2,
    size: 50,
    sprite: Sprite(ImageLoad.instance.gunShot),
    margin: EdgeInsets.only(right: 50, bottom: 120),
  );

  final _moveButton = JoystickAction(
    actionId: 3,
    size: 50,
    margin: EdgeInsets.only(bottom: 50, right: 120),
    enableDirection: true,
  );
}
