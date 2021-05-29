import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';

import '../../../core/asset/image/image_load_manager.dart';
import '../../../product/model/box_model.dart';

class RockBoxRandomComponent extends BoxModelUtil with Component {
  Sprite backgroundSprite;
  List<double> _pointValues = [];
  List<Rect> boxItems = [];

  @override
  final Size screenSize;

  RockBoxRandomComponent(this.screenSize) : super(screenSize) {
    backgroundSprite = Sprite(ImageLoad.instance.wallImage);
    _pointValues = List.generate(columnListLength, (index) => index * boxSize);
    for (var i = 0; i < columnListLength - 1; i++) {
      final rect = Rect.fromLTWH(boxSize * 2.5, _pointValues[i] + boxSize * 3, boxSize, boxSize);
      boxItems.add(rect);
    }

    for (var i = 0; i < columnListLength - 1; i++) {
      final rect = Rect.fromLTWH(boxSize * 5, _pointValues[i] - boxSize, boxSize, boxSize);
      boxItems.add(rect);
    }
  }

  int get columnListLength => (screenSize.height ~/ boxSize);

  @override
  void render(Canvas c) {
    _drawMapBox(c);
  }

  void _drawMapBox(Canvas canvas) {
    for (var item in boxItems) {
      backgroundSprite.renderRect(canvas, item);
    }
  }

  @override
  void update(double t) {}
}
