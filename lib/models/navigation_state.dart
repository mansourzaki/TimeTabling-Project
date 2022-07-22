import 'package:flutter/material.dart';

class NavigationScreenState extends ChangeNotifier {
  int index = 0;

  NavigationScreenState();
  void jumpToNewScreen(int i) {
    index = i;
    print(i);
    ChangeNotifier();
  }
}
