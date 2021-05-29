import 'dart:math';

extension RandomNumberExtension on double {
  double get randomToMax {
    return Random().nextInt(toInt()).toDouble();
  }
}
