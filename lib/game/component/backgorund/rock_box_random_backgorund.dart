import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';

import '../../../core/asset/image/image_load_manager.dart';
import '../../../core/extension/number/number_extension.dart';
import '../../../product/model/box_model.dart';
import '../layer/backgorund_layer_wall.dart';

class RockBoxRandomComponent extends BoxModelUtil with Component {
  BackgroundLayer layer;
  Sprite backgroundSprite;
  List<double> _pointValues = [];

  final Size screenSize;

  RockBoxRandomComponent(this.screenSize) : super(screenSize) {
    backgroundSprite = Sprite(ImageLoad.instance.wallImage);
    _pointValues = List.generate(columnListLength(), (index) => index * boxSize);
  }

  int columnListLength() => (screenSize.height ~/ boxSize);

  @override
  void render(Canvas c) {
    _drawMapBox(c);
  }

  void _drawMapBox(Canvas canvas) {
    for (var i = 0; i < columnListLength() - 1; i++) {
      final rect = Rect.fromLTWH(boxSize * 2.5, _pointValues[i] + boxSize * 3, boxSize, boxSize);
      backgroundSprite.renderRect(canvas, rect);
    }
  }

  @override
  void update(double t) {}
}
