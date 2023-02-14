import 'cell.dart';
import 'tile.dart';

abstract class TileController {
  bool move(MoveDirection direction, Tile tile);
}

enum MoveDirection { up, down, right, left }

class TileControllerImpl implements TileController {
  @override
  bool move(MoveDirection direction, Tile tile) {
    // Get empty cell
    Cell? cellA = tile.getCellFromElement(0);

    if (cellA == null) {
      return false;
    }

    switch (direction) {
      case MoveDirection.up:
        return tile.swap(cellA, Cell(cellA.x, cellA.y + 1));
      case MoveDirection.down:
        return tile.swap(cellA, Cell(cellA.x, cellA.y - 1));
      case MoveDirection.right:
        return tile.swap(cellA, Cell(cellA.x - 1, cellA.y));
      case MoveDirection.left:
        return tile.swap(cellA, Cell(cellA.x + 1, cellA.y));
    }
  }
}
