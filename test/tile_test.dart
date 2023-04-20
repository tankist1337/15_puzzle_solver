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

    expect(tile.getElementFromCell(Cell(3, 3)), null);
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

    expect(tile.isCellOutside(Cell(4, 4)), true);
  });

  test("ListTile getOneLine()", () {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tile = ListTile(list);

    expect(tile.getOneLine(), "1 2 3 4 5 6 7 8 0 ");
  });

  test("ListTile correct swap(cellA, cellB) version", () {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tile = ListTile(list);

    final Cell cellA = Cell(1, 1);
    final Cell cellB = Cell(1, 2);

    tile.swap(cellA, cellB);

    expect(tile.getOneLine(), "1 2 3 4 8 6 7 5 0 ");
  });

  test("ListTile swap(cellA, cellB) with cells less then 0", () {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tile = ListTile(list);

    final Cell cellA = Cell(-1, 1);
    final Cell cellB = Cell(1, 2);

    tile.swap(cellA, cellB);

    expect(tile.getOneLine(), "1 2 3 4 5 6 7 8 0 ");
  });

  test("ListTile swap(cellA, cellB) with cells more then tile size", () {
    final list = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tile = ListTile(list);

    final Cell cellA = Cell(1, 1);
    final Cell cellB = Cell(1, tile.getColumnLength());

    tile.swap(cellA, cellB);

    expect(tile.getOneLine(), "1 2 3 4 5 6 7 8 0 ");
  });
  test("ListTile compare(tile) == true", () {
    final listA = [1, 2, 3, 4, 5, 6, 7, 8, 0];
    final listB = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tileA = ListTile(listA);
    final Tile tileB = ListTile(listB);

    expect(tileA.compare(tileB), true);
  });

  test("ListTile compare(tile) == false", () {
    final listA = [1, 2, 3, 4, 5, 6, 7, 8, 0];
    final listB = [5, 1, 8, 4, 2, 6, 7, 3, 0];

    final Tile tileA = ListTile(listA);
    final Tile tileB = ListTile(listB);

    expect(tileA.compare(tileB), false);
  });

  test("ListTile getDifferencesNumber(tile)", () {
    final listA = [1, 2, 3, 4, 5, 6, 7, 8, 0];
    final listB = [5, 1, 8, 4, 2, 6, 7, 3, 0];

    final Tile tileA = ListTile(listA);
    final Tile tileB = ListTile(listB);

    expect(tileA.getDifferencesNumber(tileB), 5);
  });

  test("ListTile getCellFromElement(int? element) correct", () {
    final listA = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tileA = ListTile(listA);

    expect(tileA.getCellFromElement(6)?.getString(), Cell(2, 1).getString());
  });

  test("ListTile getCellFromElement(int? element) null", () {
    final listA = [1, 2, 3, 4, 5, 6, 7, 8, 0];

    final Tile tileA = ListTile(listA);

    expect(tileA.getCellFromElement(10)?.getString(), null);
  });
}
