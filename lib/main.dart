import 'package:flutter/material.dart';
import 'package:twenty_forty_eight/game_board.dart';
import 'package:twenty_forty_eight/grid_properties.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048 Game',
      // home: GameBoard(),
      home: TwentyFortyEight(),
    );
  }
}

class TwentyFortyEight extends StatefulWidget {
  @override
  TwentyFortyEightState createState() => TwentyFortyEightState();
}

class TwentyFortyEightState extends State<TwentyFortyEight> {
  final GlobalKey<GameBoardState> gameBoardKey = GlobalKey();
  var score = 0;
  var bestScore = 0;

  startNewGame() {
    print('new game');
    gameBoardKey.currentState?.resetGame();
    setState(() {
      if (score > bestScore) {
        bestScore = score;
      }
      score = 0;
    });
  }

  void updateScore(int numToAdd){
    setState(() {
      score += numToAdd;
    });
  }

  void onGameOver(){
    print('Game Over');
    _gameOverPopup(context);

    setState(() {
      if (score > bestScore) {
        bestScore = score;
      }
    });
  }

  void _gameOverPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startNewGame();
              },
              child: Text('Restart'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tan,
        body: Center(
            child: Container(
                margin:
                    EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(
                        //     left: 0.0, top: 50.0, right: 0.0, bottom: 0.0),
                        child: Text('2048',
                            style: TextStyle(
                              fontSize: 64,
                            )),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 5, top: 10, right: 5, bottom: 10),
                            padding: EdgeInsets.only(
                                left: 15, top: 5, right: 15, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: lightBrown,
                            ),
                            child: Column(children: [
                              Text('Score',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  )),
                              Text(score.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ))
                            ]),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 5, top: 10, right: 10, bottom: 10),
                            padding: EdgeInsets.only(
                                left: 15, top: 5, right: 15, bottom: 5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: lightBrown,
                            ),
                            child: Column(children: [
                              Text('Best',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  )),
                              Text(bestScore.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ))
                            ]),
                          )
                        ],
                      ),
                    ],
                  ),
                  Text('Join the numbers and get to the 2048 tile!'),
                  GameBoard(key: gameBoardKey,
                    updateScore: updateScore,
                    onGameOver: onGameOver,),
                  ElevatedButton(
                    onPressed: () => startNewGame(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greyText,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Button border radius
                      ),
                    ),
                    child: Text('New Game',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        )),
                  ),
                ]))));
  }
}
