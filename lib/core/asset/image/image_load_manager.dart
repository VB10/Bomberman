import 'package:flame/flame.dart';

class ImageLoad {
  static ImageLoad _instance;
  static ImageLoad get instance {
    _instance ??= ImageLoad._init();
    return _instance;
  }

  ImageLoad._init();

  String get wallImage => 'wall-1'.toPNG;
  String get fire => 'fire-1'.toPNG;
  String get gunShot => 'gunshot'.toPNG;
  String get agileFly => 'agile-fly-1'.toPNG;
  String get vb10 => 'vb10'.toPNG;
  String get winner => 'winner'.toPNG;

  final String humanCar = 'car/humanCar'.toPNG;
  final String monsterCar = 'car/monsterCar'.toPNG;

  Future<void> loadImageAll() async {
    await Flame.images.loadAll(<String>[wallImage, humanCar, monsterCar]);
  }
}

extension on String {
  String get toPNG => '$this.png';
}
