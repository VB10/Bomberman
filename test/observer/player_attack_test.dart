import 'package:bomberman/product/manager/player_attack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final playerAction = PlayerActioneer();
  setUp(() {});
  test('Sample Test', () {
    final manager1 = PlayerManager(id: 'vb1');
    final manager2 = PlayerManager(id: 'vb2');
    final manager3 = PlayerManager(id: 'vb3');
    final manager4 = PlayerManager(id: 'vb4');

    playerAction.attach(manager1);
    playerAction.attach(manager2);
    playerAction.attach(manager3);
    playerAction.attach(manager4);

    playerAction.position = 100;

    playerAction.position = 150;

    expect(playerAction.position, 150);
  });
}
