import 'package:solving_game_15_using_a_star_algorithm/tile/solver/solution_path_display.dart';
import 'package:solving_game_15_using_a_star_algorithm/tile/solver/tile_solver.dart';
import 'package:solving_game_15_using_a_star_algorithm/tile/tile.dart';

void main(List<String> arguments) {
  // List<List<int>> startMatrix = [
  //   [4, 1, 5],
  //   [3, 7, 2],
  //   [6, 8, 0]
  // ];

  // List<List<int>> resultMatrix = [
  //   [1, 2, 3],
  //   [4, 5, 6],
  //   [7, 8, 0]
  // ];

  // Tile startTile = MultiArrayTile(startMatrix);
  // Tile resultTile = MultiArrayTile(resultMatrix);

  List<int> startList = arguments[0].split(" ").map(int.parse).toList();

  // List<int> startList = [14, 2, 8, 7, 9, 12, 13, 4, 1, 3, 5, 10, 6, 0, 15, 11];
  List<int> resultList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];

  Tile startTile = ListTile(startList);
  Tile resultTile = ListTile(resultList);

  TileSolver tileSolver = TileSolverImpl();

  Stopwatch stopwatch = Stopwatch();
  stopwatch.start();

  List<Tile> solutionPath = tileSolver.getSolution(startTile, resultTile);

  stopwatch.stop();

  SolutionPathDisplay solutionPathDisplay = SolutionPathConsoleDisplay();

  int hour = stopwatch.elapsed.inHours;
  int minutes = stopwatch.elapsed.inMinutes - hour * 60;
  int seconds = stopwatch.elapsed.inSeconds - minutes * 60;

  print(
      "time: ${hour != 0 ? "$hour h, " : ""}${minutes != 0 ? "$minutes m, " : ""}$seconds s");

  solutionPathDisplay.display(solutionPath);
}
