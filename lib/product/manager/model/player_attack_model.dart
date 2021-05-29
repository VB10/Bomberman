import 'dart:ui';

class PlayerAttackModel {
  final Rect damagePosition;
  final double damage;

  final double _distance = 20;
  PlayerAttackModel(this.damagePosition, this.damage);

  bool isNestedRect(Rect position) {
    return position.center.dx - damagePosition.center.dx < _distance;
  }
}
