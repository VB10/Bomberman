import 'dart:ui';

abstract class BoxModel {
  double get boxSize;
  double get boxHeight;
}

class BoxModelUtil with BoxModel {
  final Size screenSize;

  BoxModelUtil(this.screenSize);
  @override
  double get boxSize => screenSize.width * 0.1;

  @override
  double get boxHeight => screenSize.height * 0.1;
}
