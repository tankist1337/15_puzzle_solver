import 'cell.dart';
import 'tile.dart';

abstract class TileDisplay {
  void display(Tile tile);
}

class ConsoleTileDisplay implements TileDisplay {
  @override
  void display(Tile tile) {
    for (int i = 0; i < tile.getRowLength(); i++) {
      String line = "";
      for (int j = 0; j < tile.getColumnLength(); j++) {
        line += "${tile.getElementFromCell(Cell(i, j))}\t";
      }
      print(line);
    }
  }
}
