import '../../core/model/observer/observer_manager.dart';
import 'model/player_attack_model.dart';
import 'model/player_attack_observer.dart';

class PlayerAttackManagers extends Subject<PlayerAttack> {
  final List<PlayerAttack> _players = [];

  final double monsterHealth;

  PlayerAttackModel _model;

  PlayerAttackModel get model => _model;

  set model(PlayerAttackModel model) {
    _model = model;
    notifyObserver();
  }

  PlayerAttackManagers({this.monsterHealth = 100});

  @override
  void attach(PlayerAttack observer) {
    _players.add(observer);
  }

  @override
  void detattach(PlayerAttack observer) {
    _players.remove(observer);
  }

  @override
  void notifyObserver() {
    _players.forEach((element) {
      element.update(model);
    });
  }
}
