import 'package:flutter/material.dart';

class StudyItemProvider with ChangeNotifier {

  bool _visible = false;

  bool get visible => _visible;

  void toggle() {
    _visible = !_visible;
    notifyListeners();
  }

}