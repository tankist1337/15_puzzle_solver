import 'tile/solver/solution_path_display.dart';
import 'tile/solver/tile_solver.dart';
import 'tile/tile.dart';
import 'tile/tile_display.dart';

void main(List<String> arguments) {
  List<List<int>> matrix = [
    [8, 3, 6],
    [1, 7, 5],
    [2, 4, 0]
  ];

  Tile tile = Tile(matrix);
  tile.setStrategyDisplay(ConsoleTileDisplay());

  TileSolver tileSolver = TileSolverImpl();

  List<Tile> solutionPath = tileSolver.getSolution(tile);

  SolutionPathDisplay solutionPathDisplay = SolutionPathConsoleDisplay();

  solutionPathDisplay.display(solutionPath);
}
