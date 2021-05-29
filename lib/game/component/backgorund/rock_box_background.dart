import 'package:flame/components/component.dart';
import 'package:flutter/painting.dart';

import '../box/rock_box.dart';

class BackgroundComponent extends Component {
  final RockBox box;

  BackgroundComponent(this.box);
  @override
  void render(Canvas c) {
    box.drawAllScreenBox(c);
  }

  @override
  void update(double t) {}
}
