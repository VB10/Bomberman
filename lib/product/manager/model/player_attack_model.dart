import 'dart:ui';

class PlayerAttackModel {
  final Rect damagePosition;
  final double damage;

  PlayerAttackModel(this.damagePosition, this.damage);

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is PlayerAttackModel && other.damagePosition == damagePosition && other.damage == damage;
  // }

  // @override
  // int get hashCode => damagePosition.hashCode ^ damage.hashCode;
}
