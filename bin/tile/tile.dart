import 'cell.dart';
import 'tile_display.dart';

abstract class Tile {
  int getRowLength();

  int getColumnLength();

  int getElementFromCell(Cell cell);

  void setStrategyDisplay(TileDisplay strategy);

  void display();

  bool compare(Tile tile);

  int getDifferencesNumber(Tile tile);

  bool swap(Cell cellA, Cell cellB);

  Cell? getCellFromElement(int element);

  Tile clone();
}

class MultiArrayTile implements Tile {
  final List<List<int>> _matrix;
  TileDisplay _tileDisplay = ConsoleTileDisplay();

  MultiArrayTile(this._matrix);

  // todo: reconsider this decision
  factory MultiArrayTile.fromSource(MultiArrayTile source) {
    return MultiArrayTile(source._matrix.map((e) => e.toList()).toList());
  }

  @override
  int getRowLength() {
    return _matrix.length;
  }

  @override
  int getColumnLength() {
    return _matrix[0].length;
  }

  @override
  int getElementFromCell(Cell cell) {
    return _matrix[cell.x][cell.y];
  }

  @override
  void display() {
    _tileDisplay.display(this);
  }

  @override
  bool compare(Tile tile) {
    return getDifferencesNumber(tile) == 0;
  }

  @override
  int getDifferencesNumber(Tile tile) {
    int number = 0;

    for (int i = 0; i < tile.getRowLength(); i++) {
      for (int j = 0; j < tile.getColumnLength(); j++) {
        if (getElementFromCell(Cell(i, j)) !=
            tile.getElementFromCell(Cell(i, j))) {
          number++;
        }
      }
    }

    return number;
  }

  @override
  void setStrategyDisplay(TileDisplay strategy) {
    _tileDisplay = strategy;
  }

  @override
  bool swap(Cell cellA, Cell cellB) {
    if (_isCellOutside(cellA) || _isCellOutside(cellB)) {
      return false;
    } else {
      int temporary = _matrix[cellA.x][cellA.y];
      _matrix[cellA.x][cellA.y] = _matrix[cellB.x][cellB.y];
      _matrix[cellB.x][cellB.y] = temporary;
      return true;
    }
  }

  bool _isCellOutside(Cell cell) {
    return cell.x < 0 ||
        cell.x >= getRowLength() ||
        cell.y < 0 ||
        cell.y >= getColumnLength();
  }

  @override
  Cell? getCellFromElement(int element) {
    for (int i = 0; i < getRowLength(); i++) {
      for (int j = 0; j < getColumnLength(); j++) {
        Cell cell = Cell(i, j);
        if (getElementFromCell(cell) == element) {
          return cell;
        }
      }
    }
    return null;
  }

  @override
  Tile clone() {
    return MultiArrayTile(_matrix.map((e) => e.toList()).toList());
  }
}
