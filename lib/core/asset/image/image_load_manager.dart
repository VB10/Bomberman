import 'package:flame/flame.dart';

class ImageLoad {
  static ImageLoad _instance;
  static ImageLoad get instance {
    if (_instance == null) {
      _instance = ImageLoad._init();
    }
    return _instance;
  }

  ImageLoad._init();

  String wallImage = 'wall-1.png';
  String agileFly = 'agile-fly-1.png';

  final String humanCar = 'car/humanCar.png';
  final String monsterCar = 'car/monsterCar.png';

  Future<void> loadImageAll() async {
    await Flame.images.loadAll(<String>[wallImage, humanCar, monsterCar]);
  }
}
