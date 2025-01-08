import 'dart:math';
import 'package:twenty_forty_eight/models/game_tile.dart';

class GameState {
  List<List<GameTile>> grid;
  
  GameState() : grid = List.generate(4, (_) => List.generate(4, (_) => GameTile(0,0,0)));

  void addNewTile() {
    List<GameTile> emptyTiles = [];
    grid.forEach((row) {
      row.forEach((tile) {
        if (tile.isEmpty) {
          emptyTiles.add(tile);
        }
      });
    });

    if (emptyTiles.isNotEmpty) {
      final randomTile = (emptyTiles..shuffle()).first;
      randomTile.value = (Random().nextBool() ? 2 : 4);
    }
  }

  void startGame() {
    int initialTiles = Random().nextBool() ? 3 : 4;
    for (int i = 0; i < initialTiles; i++) {
      addNewTile();
    }
  }
}