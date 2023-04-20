import '../cell.dart';
import '../tile.dart';

abstract class SolutionPathDisplay {
  void display(List<Tile> solutionPath);
}

class SolutionPathConsoleDisplay implements SolutionPathDisplay {
  @override
  void display(List<Tile> solutionPath) {
    String solutionPathString = "";

    solutionPathString = _convertPathListToString(solutionPath);

    print("=================================================================");
    print("\nSolution: ");
    print("$solutionPathString\n"); // 3 => 5 => 6 => 2 => 1 => 5 => ... => 2
    print("=================================================================");
  }

  String _convertPathListToString(List<Tile> solutionPath) {
    String solutionPathString = "";

    for (int k = 0; k < solutionPath.length; k++) {
      Tile step = solutionPath[k];
      for (int i = 0; i < step.getRowLength(); i++) {
        for (int j = 0; j < step.getColumnLength(); j++) {
          if (k == solutionPath.length - 1) {
            continue;
          } else {
            if (_isShiftedCell(step, solutionPath[k + 1], Cell(i, j))) {
              if (k == solutionPath.length - 2) {
                solutionPathString += "${step.getElementFromCell(Cell(i, j))}";
              } else {
                solutionPathString +=
                    "${step.getElementFromCell(Cell(i, j))} => ";
              }
            }
          }
        }
      }
    }

    return solutionPathString;
  }

  // Check to see if the cell is moved and do not count 0, as it is a void in 15 game
  bool _isShiftedCell(Tile tileA, Tile tileB, Cell cell) {
    return tileA.getElementFromCell(cell) != 0 &&
        tileA.getElementFromCell(cell) != tileB.getElementFromCell(cell);
  }
}
