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

  test("ListTile getElementFromCell with incorrect arguments", (() {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tile = ListTile(list);

    expect(tile.getElementFromCell(Cell(-1, 0)), null);
  }));

  test("ListTile getElementFromCell from the 3x3 tile", (() {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tile = ListTile(list);

    expect(tile.getElementFromCell(Cell(1, 1)), 5);
  }));
  test("ListTile getElementFromCell from the 4x4 tile", (() {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];

    final Tile tile = ListTile(list);

    expect(tile.getElementFromCell(Cell(1, 1)), 6);
  }));

  test("ListTile isCellOutside() == false", () {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];

    final Tile tile = ListTile(list);

    expect(tile.isCellOutside(Cell(1, 1)), false);
  });
  test("ListTile isCellOutside() == true", () {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];

    final Tile tile = ListTile(list);

    expect(tile.isCellOutside(Cell(-1, 1)), true);
  });
}
