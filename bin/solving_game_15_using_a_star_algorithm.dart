import 'tile/solver/tile_solver.dart';
import 'tile/tile.dart';
import 'tile/tile_display.dart';

void main(List<String> arguments) {
  List<List<int>> matrix = [
    [1, 3, 13, 8],
    [4, 12, 5, 9],
    [14, 6, 7, 2],
    [0, 10, 15, 11]
  ];

  Tile tile = Tile(matrix);
  tile.setStrategyDisplay(ConsoleTileDisplay());

  TileSolver tileSolver = TileSolverImpl();

  List<Tile> solutionPath = tileSolver.getSolution(tile);

  // todo: ADD SolutionPathConsoleDisplay!!!!!!!!
  //

  // Stopwatch stopwatch = Stopwatch();
  // stopwatch.start();
  // String solutionPathString = "";

  // for (int k = 0; k < solutionPath.length; k++) {
  //   for (int i = 0; i < solutionPath[k].getRowLength(); i++) {
  //     for (int j = 0; j < solutionPath[k].getColumnLength(0); j++) {
  //       if (k == solutionPath.length - 1) {
  //       } else {
  //         if (solutionPath[k].getElementFromCell(Cell(i, j)) != 0 &&
  //             solutionPath[k].getElementFromCell(Cell(i, j)) !=
  //                 solutionPath[k + 1].getElementFromCell(Cell(i, j))) {
  //           if (k == solutionPath.length - 2) {
  //             solutionPathString +=
  //                 "${solutionPath[k].getElementFromCell(Cell(i, j))}";
  //           } else {
  //             solutionPathString +=
  //                 "${solutionPath[k].getElementFromCell(Cell(i, j))} => ";
  //           }
  //         }
  //       }
  //     }
  //   }
  // }

  // stopwatch.stop();
  // print(
  //     "Time in minutes: ${(stopwatch.elapsed.inSeconds / 60 / 60).toStringAsFixed(0)}:${(stopwatch.elapsed.inSeconds / 60).toStringAsFixed(0)}:${stopwatch.elapsed.inSeconds - int.parse((stopwatch.elapsed.inSeconds / 60 / 60).toStringAsFixed(0)) * 60 * 60 - int.parse((stopwatch.elapsed.inSeconds / 60).toStringAsFixed(0)) * 60}");
  // print("\nSteps count: ${solutionPath.length - 2}");

  // print("=================================================================");
  // print("\nSolution: ");
  // print("$solutionPathString\n");
  // print("=================================================================");
}
