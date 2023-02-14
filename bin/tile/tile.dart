import 'cell.dart';
import 'tile_display.dart';

class Tile {
  final List<List<int>> _matrix;
  TileDisplay _tileDisplay = ConsoleTileDisplay();

  Tile(this._matrix);

  // todo: reconsider this decision
  factory Tile.fromSource(Tile source) {
    return Tile(source._matrix.map((e) => e.toList()).toList());
  }

  void setTileDisplay(TileDisplay newTileDisplay) {
    _tileDisplay = newTileDisplay;
  }

  int getRowLength() {
    return _matrix.length;
  }

  int getColumnLength(int rowNumber) {
    return _matrix[rowNumber].length;
  }

  int getElementFromCell(Cell cell) {
    return _matrix[cell.x][cell.y];
  }

  void display() {
    _tileDisplay.display(this);
  }

  bool compare(Tile tile) {
    return getDifferencesNumber(tile) == 0;
  }

  int getDifferencesNumber(Tile tile) {
    int number = 0;

    for (int i = 0; i < tile.getRowLength(); i++) {
      for (int j = 0; j < tile.getColumnLength(0); j++) {
        if (getElementFromCell(Cell(i, j)) !=
            tile.getElementFromCell(Cell(i, j))) {
          number++;
        }
      }
    }

    return number;
  }

  void setStrategyDisplay(TileDisplay strategy) {
    _tileDisplay = strategy;
  }

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
    return cell.x < 0 &&
        cell.x >= getRowLength() &&
        cell.y < 0 &&
        cell.y >= getColumnLength(0);
  }

  Cell? getCellFromElement(int element) {
    for (int i = 0; i < getRowLength(); i++) {
      for (int j = 0; j < getColumnLength(0); j++) {
        Cell cell = Cell(i, j);
        if (getElementFromCell(cell) == element) {
          return cell;
        }
      }
    }
    return null;
  }
}
