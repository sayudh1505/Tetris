import 'dart:async';

enum LastButtonPressed { LEFT, RIGHT, ROTATE_LEFT, ROTATE_RIGHT, NONE }

enum MoveDir { LEFT, RIGHT, DOWN }

enum GameSpeed { SPEED_1X, SPEED_2X, SPEED_3X }

class Settings {
  static final Settings _instance = Settings._internal();

  // Game settings
  int gameSpeed; // Can change during the game
  int boardWidth;
  int boardHeight;

  // Dimensions
  double pointSize; // Calculated relative to board width
  double pixelWidth;
  double pixelHeight; // Must be 2x pixelWidth

  Timer? timer;
  bool _hasBeenCalculated = false;

  /// Factory constructor for singleton instance
  factory Settings() => _instance;

  /// Private constructor with default values
  Settings._internal()
      : gameSpeed = 400,
        boardWidth = 10,
        boardHeight = 20,
        pointSize = 20,
        pixelWidth = 200,
        pixelHeight = 400;

  /// Called once to compute the board size
  void setupPlayingField(double screenWidth, double screenHeight) {
    if (_hasBeenCalculated) return;

    _hasBeenCalculated = true;

    const double userInputSize = 250.0;
    double newHeight = screenHeight - userInputSize;
    double newWidth = newHeight / 2.0;

    pixelHeight = newHeight;
    pixelWidth = newWidth;
    pointSize = pixelWidth / boardWidth;

    print(
        'calculated -> new height: $pixelHeight, new width: $pixelWidth, point size: $pointSize');
  }

  /// Adjusts game speed based on selected difficulty
  void changeGameSpeed(GameSpeed newSpeed) {
    switch (newSpeed) {
      case GameSpeed.SPEED_1X:
        gameSpeed = 400;
        break;
      case GameSpeed.SPEED_2X:
        gameSpeed = 300;
        break;
      case GameSpeed.SPEED_3X:
        gameSpeed = 200;
        break;
    }
  }
}
