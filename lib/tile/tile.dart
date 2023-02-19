import 'dart:math';

import 'cell.dart';
import 'tile_display.dart';

abstract class Tile<T> {
  int getRowLength();

  int getColumnLength();

  int? getElementFromCell(Cell cell);

  void setStrategyDisplay(TileDisplay strategy);

  void display();

  bool compare(T tile);

  int getDifferencesNumber(T tile);

  bool swap(Cell cellA, Cell cellB);

  Cell? getCellFromElement(int? element);

  T clone();

  String getOneLine();

  bool isCellOutside(Cell cell);
}

class MultiArrayTile implements Tile<MultiArrayTile> {
  final List<List<int>> _matrix;
  TileDisplay _tileDisplay = ConsoleTileDisplay();

  MultiArrayTile(this._matrix);

  @override
  int getRowLength() {
    return _matrix.length;
  }

  @override
  int getColumnLength() {
    return _matrix[0].length;
  }

  @override
  int? getElementFromCell(Cell cell) {
    if (isCellOutside(cell)) {
      return null;
    } else {
      return _matrix[cell.x][cell.y];
    }
  }

  @override
  void display() {
    _tileDisplay.display(this);
  }

  @override
  bool compare(MultiArrayTile tile) {
    return getDifferencesNumber(tile) == 0;
  }

  @override
  int getDifferencesNumber(MultiArrayTile tile) {
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
    if (isCellOutside(cellA) || isCellOutside(cellB)) {
      return false;
    } else {
      int temporary = _matrix[cellA.x][cellA.y];
      _matrix[cellA.x][cellA.y] = _matrix[cellB.x][cellB.y];
      _matrix[cellB.x][cellB.y] = temporary;
      return true;
    }
  }

  @override
  bool isCellOutside(Cell cell) {
    return cell.x < 0 ||
        cell.x >= getRowLength() ||
        cell.y < 0 ||
        cell.y >= getColumnLength();
  }

  @override
  Cell? getCellFromElement(int? element) {
    if (element == null) {
      return null;
    }

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
  MultiArrayTile clone() {
    return MultiArrayTile(_matrix.map((e) => e.toList()).toList());
  }

  @override
  String getOneLine() {
    String oneLine = "";

    for (List<int> row in _matrix) {
      for (int element in row) {
        oneLine += "$element ";
      }
    }

    return oneLine;
  }
}

class ListTile implements Tile<ListTile> {
  final List<int> _boardState;
  late final int _size;

  TileDisplay _tileDisplay = ConsoleTileDisplay();

  ListTile(this._boardState) {
    _size = sqrt(_boardState.length).toInt();
  }

  @override
  void setStrategyDisplay(TileDisplay strategy) {
    _tileDisplay = strategy;
  }

  @override
  ListTile clone() {
    return ListTile(_boardState.toList());
  }

  @override
  bool compare(ListTile tile) {
    return getOneLine() == tile.getOneLine();
  }

  @override
  void display() {
    _tileDisplay.display(this);
  }

  @override
  Cell? getCellFromElement(int? element) {
    if (element == null) {
      return null;
    }

    int index = _boardState.indexOf(element);
    if (index == -1) {
      return null;
    }

    return Cell((index % _size) - 1, ((index / _size).floor()));
  }

  @override
  int getColumnLength() {
    return _size;
  }

  @override
  int getRowLength() {
    return _size;
  }

  @override
  int? getElementFromCell(Cell cell) {
    if (isCellOutside(cell)) {
      return null;
    } else {
      return _boardState[cell.x + cell.y * _size];
    }
  }

  @override
  bool swap(Cell cellA, Cell cellB) {
    if (isCellOutside(cellA) || isCellOutside(cellB)) {
      return false;
    } else {
      int temporary = _boardState[cellA.x + cellA.y * _size];
      _boardState[cellA.x + cellA.y * _size] =
          _boardState[cellB.x + cellB.y * _size];
      _boardState[cellB.x + cellB.y * _size] = temporary;
      return true;
    }
  }

  @override
  String getOneLine() {
    String oneLine = "";

    for (int element in _boardState) {
      oneLine += "$element ";
    }

    return oneLine;
  }

  @override
  int getDifferencesNumber(ListTile tile) {
    int number = 0;

    for (int i = 0; i < pow(_size, 2); i++) {
      if (_boardState[i] !=
          tile.getElementFromCell(Cell((i % _size), ((i / _size).floor())))) {
        number++;
      }
    }

    return number;
  }

  @override
  bool isCellOutside(Cell cell) {
    return cell.x < 0 || cell.y < 0 || cell.x >= _size || cell.y >= _size;
  }
}
