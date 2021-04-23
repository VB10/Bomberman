import '../../../core/model/observer/observer_manager.dart';
import 'player_attack_model.dart';

typedef PlayerAttackCallBack = void Function(PlayerAttackModel model);

class PlayerAttack extends Observer<PlayerAttackModel> {
  final String name;
  final PlayerAttackCallBack listen;
  PlayerAttack(this.name, {this.listen});

  @override
  void update(PlayerAttackModel model) {
    listen(model);
  }
}
