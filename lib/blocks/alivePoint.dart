import 'point.dart';
import 'package:flutter/material.dart';

class AlivePoint extends Point {
  Color color;

  AlivePoint(int x, int y, this.color) : super(x, y);

  // Add method if needed
  bool checkIfPointsCollide(List<Point> otherPoints) {
    for (var p in otherPoints) {
      if (p.x == x && p.y == y) {
        return true;
      }
    }
    return false;
  }
}
