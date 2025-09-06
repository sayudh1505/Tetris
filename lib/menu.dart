import 'package:flutter/material.dart';
import 'package:tetris_1/main.dart';
import 'menuButton.dart';
import 'settings.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final settings = Settings();
  GameSpeed currentSpeed = GameSpeed.SPEED_1X;

  void changeGameSpeed() {
    setState(() {
      if (currentSpeed == GameSpeed.SPEED_1X) {
        currentSpeed = GameSpeed.SPEED_2X;
      } else if (currentSpeed == GameSpeed.SPEED_2X) {
        currentSpeed = GameSpeed.SPEED_3X;
      } else {
        currentSpeed = GameSpeed.SPEED_1X;
      }
    });
  }

  String getGameSpeed() {
    switch (currentSpeed) {
      case GameSpeed.SPEED_1X:
        return '1';
      case GameSpeed.SPEED_2X:
        return '2';
      case GameSpeed.SPEED_3X:
        return '3';
    }
  }

  void onPlayClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    settings.setupPlayingField(screenWidth, screenHeight);

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Tetris',
            style: TextStyle(
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 8.0,
                  offset: Offset(2.0, 2.0),
                )
              ],
            ),
          ),
          MenuButton(onPlayClicked),
          SizedBox(height: 20),
          SizedBox(
            width: 160,
            height: 40,
            child: ElevatedButton(
              onPressed: changeGameSpeed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              child: Text('Game Speed: x${getGameSpeed()}'),
            ),
          ),
        ],
      ),
    );
  }
}
