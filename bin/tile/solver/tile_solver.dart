import '../cell.dart';
import '../tile.dart';
import '../tile_controller.dart';
import 'node.dart';

abstract class TileSolver {
  List<Tile> getSolution(Tile startTile, Tile resultTile);
}

class TileSolverImpl implements TileSolver {
  @override
  List<Tile> getSolution(Tile startTile, Tile resultTile) {
    List<Tile> solutionList = List.empty(growable: true);

    Node startNode = Node(
        tile: startTile, g: 0, h: _getManhattanDistance(startTile, resultTile));

    List<Node> openList = List.empty(growable: true);
    List<Node> closedList = List.empty(growable: true);

    openList.add(startNode);

    int steps = 0;
    while (openList.isNotEmpty) {
      print(steps++);
      Node currentNode = _getOptimalNode(openList);

      openList.remove(currentNode);
      closedList.add(currentNode);

      if (_getOffsideCellsCount(currentNode.tile) == 0) {
        Node? pathNode = currentNode;

        while (pathNode != null) {
          solutionList.add(pathNode.tile);
          pathNode = pathNode.parent;
        }

        return List.from(solutionList.reversed);
      }

      List<Node> children = _generateChildren(currentNode, resultTile);

      children:
      for (Node child in children) {
        for (Node closedNode in closedList) {
          if (closedNode.tile.compare(child.tile)) {
            continue children;
          }
        }

        for (Node openNode in openList) {
          if (openNode.g < child.g && openNode.tile.compare(child.tile)) {
            continue children;
          }
        }

        openList.add(child);
      }
    }

    return solutionList;
  }

  int _getOffsideCellsCount(Tile tile) {
    int number = 0;

    // todo: rempove resultMatrix from this method
    List<List<int>> resultMatrix = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 0]
    ];
    Tile resultTile = Tile(resultMatrix);

    number = tile.getDifferencesNumber(resultTile);

    return number;
  }

  int _getManhattanDistance(Tile startTile, Tile resultTile) {
    int distance = 0;

    for (int i = 0; i < startTile.getRowLength(); i++) {
      for (int j = 0; j < startTile.getColumnLength(0); j++) {
        Cell? cell = startTile
            .getCellFromElement(resultTile.getElementFromCell(Cell(i, j)));

        if (cell == null) {
          continue;
        }

        distance += (cell.x - i).abs() + (cell.y - j).abs();
      }
    }

    return distance;
  }

  Node _getOptimalNode(List<Node> openList) {
    Node optimalNode = openList.first;
    for (Node node in openList) {
      if (node.f < optimalNode.f) {
        optimalNode = node;
      }
    }
    return optimalNode;
  }

  List<Node> _generateChildren(Node currentNode, Tile resultTile) {
    List<Node> children = List.empty(growable: true);

    TileController tileController = TileControllerImpl();

    var leftTile = Tile.fromSource(currentNode.tile);
    var rightTile = Tile.fromSource(currentNode.tile);
    var upTile = Tile.fromSource(currentNode.tile);
    var downTile = Tile.fromSource(currentNode.tile);

    // todo: make more readable
    if (tileController.move(MoveDirection.left, leftTile)) {
      children.add(Node(
          tile: leftTile,
          g: currentNode.g + 1,
          h: _getManhattanDistance(currentNode.tile, resultTile),
          parent: currentNode));
    }
    if (tileController.move(MoveDirection.right, rightTile)) {
      children.add(Node(
          tile: rightTile,
          g: currentNode.g + 1,
          h: _getManhattanDistance(currentNode.tile, resultTile),
          parent: currentNode));
    }
    if (tileController.move(MoveDirection.up, upTile)) {
      children.add(Node(
          tile: upTile,
          g: currentNode.g + 1,
          h: _getManhattanDistance(currentNode.tile, resultTile),
          parent: currentNode));
    }
    if (tileController.move(MoveDirection.down, downTile)) {
      children.add(Node(
          tile: downTile,
          g: currentNode.g + 1,
          h: _getManhattanDistance(currentNode.tile, resultTile),
          parent: currentNode));
    }

    return children;
  }
}
