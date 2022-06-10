import 'package:flutter/material.dart';

class AnimationProvider extends ChangeNotifier {
  double scale = 0.0;

  void increment() {
    scale = scale + 0.1;
    notifyListeners();
  }
}
