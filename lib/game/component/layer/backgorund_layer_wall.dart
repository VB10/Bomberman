import 'package:flame/layer/layer.dart';

import '../character/bomberman/bomberman.dart';

class BackgroundLayer extends PreRenderedLayer {
  final List<Bomberman> wallItems;

  BackgroundLayer(this.wallItems) {
    preProcessors.add(ShadowProcessor());
  }

  @override
  void drawLayer() {
    wallItems.map((e) {
      e.render(canvas);
    });
  }
}
