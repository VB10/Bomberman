import 'dart:async';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

import '../../../core/asset/image/image_load_manager.dart';
import '../../bomb/bomb_game.dart';

class Rock extends Component {
  final BombGame game;
  Rect bombermanRect;
  Paint bombermanPaint;
  Sprite backgroundSprite;

  Paint redRock;

  Rect rect = Rect.zero;
  double get speed => 10.0 * 5;

  Offset targetLocation;

  int elapsedSecs = 0;

  Rock(this.game) {
    backgroundSprite = Sprite(ImageLoad.instance.wallImage);
    backgroundSprite.paint.color = Color(0xff503456);
    redRock = Paint();
    redRock.color = Color(0xFFFF0000);
    setTargetLocation();
  }

  double get boxSize => game.screenSize.width * 0.1;

  List<double> values = [];
  // int i = 0;
  @override
  void render(Canvas canvas) {
    if (rect == Rect.zero) return;
    canvas.drawRect(rect, redRock);
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
      print('$left - ${rect2.center.dx} ${rect2.center.dy} ${rect2.top}');

      i++;
      left -= i * 1;
      rect = Rect.fromLTWH(rect2.center.dx, left, 5, 15);

      if (left < 20) {
        timer.cancel();
        reset();
      }
    });

    for (i = 0; i < 8; i++) {
      // changeWithDuration(() {});

      // Future.delayed(Duration(milliseconds: 1000)).then((value) {
      //   left += i * 1;
      //   rect = Rect.fromLTWH(left, 50, 50, 50);
      //   // rect = rect.translate(left, 50);
      //   // update(50);
      //   if (i == 7) {
      //     if (left > 350) {
      //       left = 1;
      //     } else {
      //       i = 0;
      //     }
      //     // rect = Rect.zero;
      //   }
      // });
    }

    // Future.delayed(Duration(milliseconds: 100)).then((value) {
    //   // this.rect = rect.translate(rect.center.dx, rect.center.dy);
    //   resetRect();
    // });
  }

  void reset() {
    _timer.cancel();
    left = 1;
    resetRect();
  }

  void changeWithDuration(VoidCallback onOk) {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      left += i * 1;
      rect = Rect.fromLTWH(left, 50, 50, 50);
      // rect = rect.translate(left, 50);
      // update(50);
      print(i);
      if (i == 8) {
        print('ok');
        i = 1;
        // if (left > 350) {
        //   left = 1;
        // } else {
        //   // onOk();
        //   i = 1;
        // }
        // rect = Rect.zero;
      }
    });
  }

  void resetRect() {
    rect = Rect.zero;
  }

  double flyingSpriteIndex = 0;

  @override
  void update(double t) {}
}
