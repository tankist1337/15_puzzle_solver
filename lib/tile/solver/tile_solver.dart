import 'package:collection/collection.dart';

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

    HeapPriorityQueue<Node> openHeap = HeapPriorityQueue();
    List<Node> closedList = List.empty(growable: true);

    openHeap.add(startNode);

    int steps = 0; // for testing
    while (openHeap.isNotEmpty) {
      steps++;
      Node currentNode = openHeap.removeFirst();
      print(
          "g: ${currentNode.g}| h: ${currentNode.h} | f: ${currentNode.f}"); // for testing

      closedList.add(currentNode);

      if (currentNode.tile.getOneLine() == resultTile.getOneLine()) {
        Node? pathNode = currentNode;

        while (pathNode != null) {
          solutionList.add(pathNode.tile);
          pathNode = pathNode.parent;
        }

        print("Steps: $steps"); // for testing

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

        // for (Node openNode in openList) {
        //   if (openNode.g < child.g && openNode.tile.compare(child.tile)) {
        //     continue children;
        //   }
        // }

        openHeap.add(child);
      }
    }

    return solutionList;
  }

  int _getOffsideCellsCount(Tile tile, Tile resultTile) {
    int number = 0;

    number = tile.getDifferencesNumber(resultTile);

    return number;
  }

  int _getManhattanDistance(Tile startTile, Tile resultTile) {
    int distance = 0;

    for (int i = 0; i < startTile.getRowLength(); i++) {
      for (int j = 0; j < startTile.getColumnLength(); j++) {
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

    var leftTile = currentNode.tile.clone();
    var rightTile = currentNode.tile.clone();
    var upTile = currentNode.tile.clone();
    var downTile = currentNode.tile.clone();

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
