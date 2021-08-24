import 'package:bomberman/core/model/observer/observer_manager.dart';
import 'package:logger/logger.dart';

class PlayerManager extends Observer<PlayerAttackNotification> {
  String id = '';
  PlayerManager({this.id});
  @override
  void update(PlayerAttackNotification notification) {
    print('$id');
  }
}

class PlayerAttackNotification {
  final String damage;
  final String message;
  final double position;

  PlayerAttackNotification(this.position, {this.damage, this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlayerAttackNotification && other.damage == damage && other.message == message;
  }

  @override
  int get hashCode => damage.hashCode ^ message.hashCode;
}

class PlayerActioneer extends Subject<PlayerManager> {
  final List<PlayerManager> _managers = [];
  final logger = Logger();
  double _position;

  bool _isPlayerActionEnded = false;

  double get position => _position;

  set position(double position) {
    if (_isPlayerActionEnded) {
      logger.i('Action has ended');
    } else {
      logger.wtf('$position newww');
      _position = position;
      notifyObserver();
    }
  }

  @override
  void attach(PlayerManager observer) {
    _managers.add(observer);
  }

  @override
  void detattach(PlayerManager observer) {
    _managers.remove(observer);
  }

  @override
  void notifyObserver() {
    final data = PlayerAttackNotification(position, damage: '100', message: 'test');
    _managers.forEach((element) {
      element.update(data);
    });
  }
}
