import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool val) {
    _loading = val;
    notifyListeners();
  }
}
