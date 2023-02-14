import 'tile/solver/solution_path_display.dart';
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

  SolutionPathDisplay solutionPathDisplay = SolutionPathConsoleDisplay();

  solutionPathDisplay.display(solutionPath);
}
