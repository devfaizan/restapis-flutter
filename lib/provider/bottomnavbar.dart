import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentPageIndex = 0;
  int get getCurrentPageIndex => currentPageIndex;

  void setCurrentIndex(int index) {
    currentPageIndex = index;
    notifyListeners();
  }
}
