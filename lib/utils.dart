import 'package:flutter/material.dart';
import 'dart:math';

class Utils {
  static late double gridSize;
  static late double blockSize;
  static double maxSize = 500;

  static void init(BuildContext context) {
    double width = MediaQuery.of(context).size.width.floor().toDouble();
    double height = MediaQuery.of(context).size.height.floor().toDouble();

    if (width > height) {
      gridSize = min(maxSize, height);
    } else {
      gridSize = min(width, maxSize);
    }

    blockSize = gridSize / 50;
  }
}
