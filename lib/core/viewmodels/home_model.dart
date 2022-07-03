import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier {
  int gridCount = 1;

  void alterGridCount(){
    gridCount = gridCount == 1 ? 2 : 1;
    notifyListeners();
  }
}
