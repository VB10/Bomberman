import 'dart:ui';

abstract class BoxModel {
  double get boxSize;
}

class BoxModelUtil with BoxModel {
  final Size screenSize;

  BoxModelUtil(this.screenSize);
  double get boxSize => screenSize.width * 0.1;
}
