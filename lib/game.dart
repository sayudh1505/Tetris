import 'package:flutter/material.dart';
import 'helper.dart';
import 'dart:async';
import 'blocks/block.dart';
import 'blocks/alivePoint.dart';
import 'scoreDisplay.dart';
import 'userInput.dart';
import 'settings.dart';

class Game extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Game();
}

class _Game extends State<Game> {
  LastButtonPressed performAction = LastButtonPressed.NONE;
  Block? currentBlock;
  List<AlivePoint> alivePoints = [];
  int score = 0;
  var settings = Settings();

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void onActionButtonPressed(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;
    });
  }

  void startGame() {
    setState(() {
      currentBlock = getRandomBlock();
    });

    settings.timer = Timer.periodic(
      Duration(milliseconds: settings.gameSpeed),
      onTimeTick,
    );
  }

  void checkForUserInput() {
    if (performAction != LastButtonPressed.NONE && currentBlock != null) {
      setState(() {
        switch (performAction) {
          case LastButtonPressed.LEFT:
            currentBlock!.move(MoveDir.LEFT);
            break;
          case LastButtonPressed.RIGHT:
            currentBlock!.move(MoveDir.RIGHT);
            break;
          case LastButtonPressed.ROTATE_LEFT:
            currentBlock!.rotateLeft();
            break;
          case LastButtonPressed.ROTATE_RIGHT:
            currentBlock!.rotateRight();
            break;
          default:
            break;
        }

        performAction = LastButtonPressed.NONE;
      });
    }
  }

  void saveOldBlock() {
    currentBlock!.points.forEach((point) {
      AlivePoint newPoint = AlivePoint(point.x, point.y, currentBlock!.color);
      setState(() {
        alivePoints.add(newPoint);
      });
    });
  }

  bool isAboveOldBlock() {
    bool retVal = false;
    alivePoints.forEach((oldPoint) {
      if (oldPoint.checkIfPointsCollide(currentBlock!.points)) {
        retVal = true;
      }
    });

    return retVal;
  }

  void removeRow(int row) {
    setState(() {
      alivePoints.removeWhere((point) => point.y == row);

      for (var point in alivePoints) {
        if (point.y < row) {
          point.y += 1;
        }
      }

      score += 1;
    });
  }

  void removeFullRows() {
    for (int currentRow = 0; currentRow < settings.boardHeight; currentRow++) {
      int counter = alivePoints.where((point) => point.y == currentRow).length;

      if (counter >= settings.boardWidth) {
        removeRow(currentRow);
      }
    }
  }

  bool playerLost() {
    return alivePoints.any((point) => point.y <= 0);
  }

  void onTimeTick(Timer time) {
    if (currentBlock == null || playerLost()) return;

    removeFullRows();

    if (currentBlock!.isAtBottom() || isAboveOldBlock()) {
      saveOldBlock();

      setState(() {
        currentBlock = getRandomBlock();
      });
    } else {
      setState(() {
        currentBlock!.move(MoveDir.DOWN);
      });
      checkForUserInput();
    }
  }

  Widget drawTetrisBlocks() {
    if (currentBlock == null) return SizedBox.shrink();

    List<Positioned> visiblePoints = [];

    // currentBlock
    for (var point in currentBlock!.points) {
      visiblePoints.add(
        Positioned(
          child: getTetrisPoint(currentBlock!.color),
          left: point.x * settings.pointSize,
          top: point.y * settings.pointSize,
        ),
      );
    }

    // old blocks
    for (var point in alivePoints) {
      visiblePoints.add(
        Positioned(
          child: getTetrisPoint(point.color),
          left: point.x * settings.pointSize,
          top: point.y * settings.pointSize,
        ),
      );
    }

    return Stack(children: visiblePoints);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(
          child: Container(
            width: settings.pixelWidth,
            height: settings.pixelHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child:
                (!playerLost()) ? drawTetrisBlocks() : getGameOverText(score),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ScoreDisplay(score),
            UserInput(onActionButtonPressed),
          ],
        )
      ],
    );
  }
}
