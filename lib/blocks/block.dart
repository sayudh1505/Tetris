import 'package:tetris_1/settings.dart';

import 'point.dart';
import 'package:flutter/material.dart';
import '../game.dart';

class Block {
  List<Point> points = List.generate(
      4, (_) => Point(0, 0)); // Safer than List.filled for mutable objects
  late Point rotationCenter;
  late Color color;

  void move(MoveDir dir) {
    switch (dir) {
      case MoveDir.LEFT:
        for (var p in points) {
          p.x -= 1;
        }
        break;
      case MoveDir.RIGHT:
        for (var p in points) {
          p.x += 1;
        }
        break;
      case MoveDir.DOWN:
        for (var p in points) {
          p.y += 1;
        }
        break;
    }
  }

  void rotateRight() {
    for (var point in points) {
      int x = point.x;
      point.x = rotationCenter.x - (point.y - rotationCenter.y);
      point.y = rotationCenter.y + (x - rotationCenter.x);
    }
  }

  void rotateLeft() {
    for (var point in points) {
      int x = point.x;
      point.x = rotationCenter.x + (point.y - rotationCenter.y);
      point.y = rotationCenter.y - (x - rotationCenter.x);
    }
  }

  bool isAtBottom() {
    return points.any((point) => point.y >= Settings().boardHeight - 1);
  }
}
