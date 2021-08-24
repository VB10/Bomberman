import 'dart:async';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../../../core/asset/image/image_load_manager.dart';
import '../../../product/manager/model/player_attack_observer.dart';
import '../../bomb/bomb_game.dart';

class Rock extends Component {
  final BombGame game;
  Sprite fireBackgroundSprite;
  Rect rect = Rect.zero;
  double get speed => 10.0 * 5;
  PlayerAttack attackModel;
  Offset targetLocation;

  Rock(this.game) {
    fireBackgroundSprite = Sprite(ImageLoad.instance.fire);
    setTargetLocation();

    attackModel = PlayerAttack(
      '$this',
      listen: (model) {
        changeRect(model.damagePosition);
      },
    );
  }

  double get boxSize => game.screenSize.width * 0.1;

  List<double> values = [];
  // int i = 0;
  @override
  void render(Canvas canvas) {
    if (rect == Rect.zero) return;
    fireBackgroundSprite.renderRect(canvas, rect);
  }

  void setTargetLocation() {
    var x = game.screenSize.width;
    var y = 50.0;
    targetLocation = Offset(x, y);
  }

  double left = 1;
  var i = 2;
  Timer _timer;
  void changeRect(Rect rect2) {
    if (_timer != null) {
      reset();
    }
    left += rect2.center.dy;

    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      i++;
      left -= i * 1;
      rect = Rect.fromLTWH(rect2.center.dx, left, 5, 15);

      if (left < 20) {
        timer.cancel();
        reset();
      }
    });
  }

  void reset() {
    _timer.cancel();
    left = 1;
    resetRect();
  }

  void resetRect() {
    rect = Rect.zero;
  }

  @override
  void update(double t) {}
}
