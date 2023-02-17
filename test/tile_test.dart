import 'package:solving_game_15_using_a_star_algorithm/tile/cell.dart';
import 'package:solving_game_15_using_a_star_algorithm/tile/tile.dart';
import 'package:test/test.dart';

void main() {
  test('MultiArrayTile column length', () {
    final list = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 0]
    ];

    final Tile tile = MultiArrayTile(list);

    expect(tile.getColumnLength(), 3);
  });

  test("ListTile column length", () {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tile = ListTile(list);

    expect(tile.getColumnLength(), 3);
  });

  test("ListTile getElementFromCell", (() {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tile = ListTile(list);

    expect(tile.getElementFromCell(Cell(-1, 0)), null);
  }));
}
