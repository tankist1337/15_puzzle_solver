import 'tile/solver/solution_path_display.dart';
import 'tile/solver/tile_solver.dart';
import 'tile/tile.dart';

void main(List<String> arguments) {
  List<List<int>> startMatrix = [
    [5, 1, 9, 3],
    [11, 13, 6, 8],
    [14, 10, 4, 15],
    [0, 12, 7, 2]
  ];

  List<List<int>> resultMatrix = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 0]
  ];

  Tile startTile = Tile(startMatrix);
  Tile resultTile = Tile(resultMatrix);

  TileSolver tileSolver = TileSolverImpl();

  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();

  List<Tile> solutionPath = tileSolver.getSolution(startTile, resultTile);

  stopwatch.stop();

  SolutionPathDisplay solutionPathDisplay = SolutionPathConsoleDisplay();

  int hour =
      int.parse((stopwatch.elapsed.inSeconds / 60 / 60).toStringAsFixed(0));
  int minutes =
      int.parse((stopwatch.elapsed.inSeconds / 60).toStringAsFixed(0));
  int seconds = stopwatch.elapsed.inSeconds - hour * 60 * 60 - minutes * 60;

  print(
      "${hour != 0 ? "$hour h, " : ""}${minutes != 0 ? "$minutes m, " : ""}$seconds s");

  solutionPathDisplay.display(solutionPath);
}
