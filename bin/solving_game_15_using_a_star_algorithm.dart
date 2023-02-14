import 'tile/solver/solution_path_display.dart';
import 'tile/solver/tile_solver.dart';
import 'tile/tile.dart';

void main(List<String> arguments) {
  List<List<int>> startMatrix = [
    [1, 6, 8],
    [2, 5, 4],
    [3, 7, 0]
  ];

  List<List<int>> resultMatrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 0]
  ];

  Tile startTile = Tile(startMatrix);
  Tile resultTile = Tile(resultMatrix);

  TileSolver tileSolver = TileSolverImpl();

  List<Tile> solutionPath = tileSolver.getSolution(startTile, resultTile);

  SolutionPathDisplay solutionPathDisplay = SolutionPathConsoleDisplay();

  solutionPathDisplay.display(solutionPath);
}
