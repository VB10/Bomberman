import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/asset/image/image_load_manager.dart';
import 'game/bomb/bomb_game.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ImageLoad.instance.loadImageAll();

  var flameUtil = Util();

  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  final size = await Flame.util.initialDimensions();
  var bombGame = BombGame(size);
  runApp(bombGame.widget);
}
