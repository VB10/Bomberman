import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';

import '../../../core/asset/image/image_load_manager.dart';

class WinBackgroundComponent extends Component {
  Sprite winBackgroundSprite;
  Rect rect;
  final Size screenSize;
  WinBackgroundComponent(this.screenSize) {
    winBackgroundSprite = Sprite(ImageLoad.instance.winner);
    rect = Rect.fromLTWH(screenSize.width * 0.2, screenSize.height * 0.25, screenSize.width * 0.6, screenSize.height * 0.4);
  }
  @override
  void render(Canvas c) {
    winBackgroundSprite.renderRect(c, rect);
  }

  @override
  void update(double t) {}
}
