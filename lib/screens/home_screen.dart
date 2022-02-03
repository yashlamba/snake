import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snakegame/model/snake_model.dart';
import 'package:snakegame/utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Snake snake = Snake();
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(
        const Duration(milliseconds: 100),
        (Timer t) => setState(() {
              snake.update();
            }));
    super.initState();
  }

  void _keyHandler(RawKeyEvent event) {
    setState(() {
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        if (snake.direction != "UP") {
          snake.direction = "DOWN";
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        if (snake.direction != "DOWN") {
          snake.direction = "UP";
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        if (snake.direction != "LEFT") {
          snake.direction = "RIGHT";
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        if (snake.direction != "RIGHT") {
          snake.direction = "LEFT";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final game_utils = Utils();
    Utils.init(context);
    // snake.utils = game_utils;
    return Center(
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: _keyHandler,
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              if (snake.direction != "LEFT") {
                snake.direction = "RIGHT";
              }
            } else if (details.primaryVelocity! < 0) {
              if (snake.direction != "RIGHT") {
                snake.direction = "LEFT";
              }
            }
          },
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              if (snake.direction != "UP") {
                snake.direction = "DOWN";
              }
            } else if (details.primaryVelocity! < 0) {
              if (snake.direction != "DOWN") {
                snake.direction = "UP";
              }
            }
          },
          child: Container(
            height: Utils.gridSize,
            width: Utils.gridSize,
            color: Colors.grey[200],
            child: Stack(
              children:
                  snake.toWidgets() + [snake.food.toPositioned(Colors.red)],
            ),
          ),
        ),
      ),
    );
  }
}
