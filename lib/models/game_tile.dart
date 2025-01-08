import 'package:flutter/material.dart';
import 'package:twenty_forty_eight/grid_properties.dart';

class GameTile {
  final int x;
  final int y;
  int value;
  Color? color;
  int? prevX;
  int? prevY;

  GameTile(this.x, this.y, this.value) {
    setColor();
  }

  bool get isEmpty => value == 0;

  bool get isNotEmpty {
    setColor();
    return value != 0;
  }

  void setColor() {
    if (this.value == 0) {
      color = lightBrown;
    } else {
      color = numTileColor[this.value];
    }
  }
}
