import 'package:flame/components/component.dart';
import 'package:flutter/painting.dart';

import '../box/rock_box.dart';
import '../layer/backgorund_layer_wall.dart';

class BackgroundComponent extends Component {
  BackgroundLayer layer;

  final RockBox box;

  BackgroundComponent(this.box);
  @override
  void render(Canvas c) {
    box.drawAllScreenBox(c);
  }

  @override
  void update(double t) {}
}
