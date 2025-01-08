import 'package:flutter/material.dart';
import 'package:twenty_forty_eight/game_state.dart';
import 'package:twenty_forty_eight/models/game_tile.dart';
import 'package:twenty_forty_eight/grid_properties.dart';

typedef IntCallback = void Function(int);

class GameBoard extends StatefulWidget {
  final VoidCallback onGameOver;
  final IntCallback updateScore;

  GameBoard({required this.onGameOver, required this.updateScore, Key? key}) : super(key: key);

  @override
  GameBoardState createState() => GameBoardState();
}

class GameBoardState extends State<GameBoard> with TickerProviderStateMixin{
  GameState? gameState;
  final int swipeThreshold = 20;
  bool isSwiping = false;
  bool isGameOver = false;
  int score = 0;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    gameState = GameState();
    gameState?.startGame();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500), // Adjust duration as needed
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
  }

  void onSwipeEnd(DragEndDetails details) {
    isSwiping = false;
    _controller.reset();
  }

  void resetGame() {
    print('resetGame called');
    setState(() {
      gameState = GameState();
      gameState?.startGame();
    });
  }

  // movements part
  void moveLeft() {
    if (isSwiping) {
      return;
    }
    isSwiping = true;
    _controller.forward();
    print('left');
    setState(() {
      for (var i = 0; i < gameState!.grid.length; i++) {
        // Slide tiles to the left
        List<GameTile> newRow =
        gameState!.grid[i].where((tile) => !tile.isEmpty).toList();

        // Merge tiles with the same value
        for (int j = 0; j < newRow.length - 1; j++) {
          if (newRow[j].value == newRow[j + 1].value) {
            newRow[j].value *= 2;
            widget.updateScore(newRow[j].value);
            newRow.removeAt(j + 1);
          }
        }

        // Fill the rest of the row with empty tiles
        while (newRow.length < 4) {
          newRow.add(GameTile(0, 0, 0));
        }

        gameState!.grid[i] = newRow;
      }
      if (IsGameContinue()){
        gameState!.addNewTile();
      } else {
        isGameOver = true;
      }
    });
  }

  void moveRight() {
    if (isSwiping) {
      return;
    }
    isSwiping = true;
    _controller.forward();
    print('right');
    setState(() {
      for (var i = 0; i < gameState!.grid.length; i++) {
        // Slide tiles to the right
        List<GameTile> newRow =
        gameState!.grid[i].where((tile) => !tile.isEmpty).toList();

        // Merge tiles with the same value
        for (int j = newRow.length - 1; j > 0; j--) {
          if (newRow[j].value == newRow[j - 1].value) {
            newRow[j].value *= 2;
            widget.updateScore(newRow[j].value);
            newRow.removeAt(j - 1);
          }
        }

        // Fill the rest of the row with empty tiles
        while (newRow.length < 4) {
          newRow.insert(0, GameTile(0, 0, 0));
        }

        gameState!.grid[i] = newRow;
      }
      if (IsGameContinue()){
        gameState!.addNewTile();
      } else {
        isGameOver = true;
      }
    });
  }

  void moveUp() {
    if (isSwiping) {
      return;
    }
    isSwiping = true;
    _controller.forward();
    print('up');
    setState(() {
      for (var col = 0; col < gameState!.grid[0].length; col++) {
        // Slide tiles up
        List<GameTile> newColumn = gameState!.grid
            .map((row) => row[col])
            .where((tile) => !tile.isEmpty)
            .toList();

        // Merge tiles with the same value
        for (int i = 0; i < newColumn.length - 1; i++) {
          if (newColumn[i].value == newColumn[i + 1].value) {
            newColumn[i].value *= 2;
            widget.updateScore(newColumn[i].value);
            newColumn.removeAt(i + 1);
          }
        }

        // Fill the rest of the column with empty tiles
        while (newColumn.length < 4) {
          newColumn.add(GameTile(0, 0, 0));
        }

        // Update the transposed column back to the grid
        for (int i = 0; i < gameState!.grid.length; i++) {
          gameState!.grid[i][col] = newColumn[i];
        }
      }
      if (IsGameContinue()){
        gameState!.addNewTile();
      } else {
        isGameOver = true;
      }
    });
  }

  void moveDown() {
    if (isSwiping) {
      return;
    }
    isSwiping = true;
    print('down');
    _controller.forward();
    setState(() {
      for (var col = 0; col < gameState!.grid[0].length; col++) {
        // Slide tiles down
        List<GameTile> newColumn = gameState!.grid
            .map((row) => row[col])
            .where((tile) => !tile.isEmpty)
            .toList();

        // Merge tiles with the same value
        for (int i = newColumn.length - 1; i > 0; i--) {
          if (newColumn[i].value == newColumn[i - 1].value) {
            newColumn[i].value *= 2;
            widget.updateScore(newColumn[i].value);
            newColumn.removeAt(i - 1);
          }
        }

        // Fill the rest of the column with empty tiles
        while (newColumn.length < 4) {
          newColumn.insert(0, GameTile(0, 0, 0));
        }

        // Update the transposed column back to the grid
        for (int i = 0; i < gameState!.grid.length; i++) {
          gameState!.grid[i][col] = newColumn[i];
        }
      }
      if (IsGameContinue()){
        gameState!.addNewTile();
      } else {
        isGameOver = true;
      }
    });
  }

  void onSwipe(DragUpdateDetails details) {
    // Horizontal swipe
    if (details.delta.dx.abs() > details.delta.dy.abs() &&
        details.delta.dx.abs() > swipeThreshold) {
      if (details.delta.dx > 0) {
        moveRight();
      } else {
        moveLeft();
      }
    }
    // Vertical swipe
    else if (details.delta.dy.abs() > swipeThreshold) {
      if (details.delta.dy > 0) {
        moveDown();
      } else {
        moveUp();
      }
    }
  }

  bool IsGameContinue() {
    // check if there is any empty tile if there is then continue
    for (var i = 0; i < gameState!.grid.length; i++) {
      for (var j = 0; j < gameState!.grid.length; j++){
        if (gameState!.grid[i][j].isEmpty) {
          return true;
        }

        if (j < 3 && gameState!.grid[i][j].value == gameState!.grid[i][j + 1].value) {
          return true;
        }
        if (i < 3 && gameState!.grid[i][j].value == gameState!.grid[i + 1][j].value) {
          return true;
        }
      }
    }

    widget.onGameOver();
    return false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double gridSize = MediaQuery.of(context).size.width - 10 * 2;
    double tileSize = (gridSize - 20) / 4; // Adjusted tile size with a small gap

    return Container(
      width: gridSize,
      height: gridSize,
      margin: EdgeInsets.only(left: 0, right: 0, top: 50, bottom: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: darkBrown,
      ),
      child: GestureDetector(
        onPanUpdate: (details) => onSwipe(details),
        onPanEnd: (details) => onSwipeEnd(details),
        child: Stack(
          children: [
            // Render the tiles based on the current game state
            for (int row = 0; row < 4; row++)
              Positioned(
                top: row * (tileSize + 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int col = 0; col < 4; col++)
                      SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(-_animation.value * tileSize * col, 0),
                          end: Offset(0, 0),
                        ).animate(_controller),
                        child: Container(
                          width: tileSize,
                          height: tileSize,
                          margin: EdgeInsets.only(left: 2.5, right: 2.5, top: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                            color: gameState!.grid[row][col].isNotEmpty
                                ? gameState!.grid[row][col].color
                                : lightBrown,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              gameState!.grid[row][col].isNotEmpty
                                  ? '${gameState!.grid[row][col].value}'
                                  : '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

}