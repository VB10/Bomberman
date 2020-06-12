import 'package:bomberman/core/asset/image/image_load_manager.dart';
import 'package:bomberman/game/bomb/bomb_game.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ImageLoad.instance.loadImageAll();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  BombGame bombGame = BombGame();
  runApp(bombGame.widget);
}
