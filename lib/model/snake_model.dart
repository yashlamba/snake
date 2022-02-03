import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snakegame/utils.dart';

class XY {
  int x = 0;
  int y = 0;

  XY(this.x, this.y);
  XY.fromXY(XY other) {
    x = other.x;
    y = other.y;
  }

  XY operator +(XY other) {
    return XY((x + other.x) % 50, (y + other.y) % 50);
  }

  bool isEqual(XY other) {
    return (other.x == x) && (other.y == y);
  }

  Widget toPositioned(Color color) {
    return Positioned(
      top: Utils.blockSize * y,
      left: Utils.blockSize * x,
      height: Utils.blockSize,
      width: Utils.blockSize,
      child: Container(
        color: color,
      ),
    );
  }
}

class Snake {
  List<XY> snake = [XY(0, 0), XY(0, 1), XY(0, 2)];
  String direction = "RIGHT";
  // late Utils utils;
  Map<String, XY> directions = {
    "UP": XY(0, -1),
    "DOWN": XY(0, 1),
    "RIGHT": XY(1, 0),
    "LEFT": XY(-1, 0)
  };

  gameOver() {
    snake = [XY(0, 0), XY(0, 1), XY(0, 2)];
    direction = "RIGHT";
    updateFood();
  }

  XY food = XY(10, 10);
  void update() {
    for (int i = 1; i < snake.length; i++) {
      if (snake[0].isEqual(snake[i])) {
        gameOver();
      }
    }
    for (int i = snake.length - 1; i >= 0; i--) {
      if (i == 0) {
        snake[i] += directions[direction]!;
        if (snake[i].isEqual(food)) {
          updateFood();
          // updateSnake();
          eatFood();
        }
        continue;
      }
      snake[i] = snake[i - 1];
    }
  }

  void eatFood() {
    snake.add(XY.fromXY(snake[snake.length - 1]));
  }

  List<Widget> toWidgets() {
    return snake.map((e) => e.toPositioned(Colors.blue)).toList();
  }

  updateFood() {
    var rng = Random();
    var newFood;
    while (true) {
      newFood = XY(rng.nextInt(50), rng.nextInt(50));
      for (XY element in snake) {
        if (newFood.isEqual(element)) {
          continue;
        }
      }
      break;
    }
    food = newFood;
  }
}
