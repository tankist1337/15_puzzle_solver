import '../tile.dart';

class Node implements Comparable<Node> {
  final Node? parent;
  final Tile tile;
  final int g;
  final int h;
  late final int f;

  Node({required this.tile, required this.g, required this.h, this.parent}) {
    f = g + h;
  }

  @override
  int compareTo(Node node) {
    return f - node.f;
  }
}
