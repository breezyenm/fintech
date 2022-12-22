import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends ChangeNotifier {
  int _art = 1;
  int get art => _art;
  set art(int val) {
    _art = val;
    notifyListeners();
  }

  List<String> text = [
    'No more\nhidden fees',
    'All currency\nsupport',
    'Flashy fast\nEasu to use',
  ];
  List<String> subText = [
    'Send money abroad and save up to\n85% compared to your bank',
    'Send money abroad and save up to\n85% compared to your bank',
    'Sending money abroad\ncan be faster than you think',
  ];

  bool? isFirst;
  Future<bool> check() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('isFirst') == null) {
      preferences.setBool('isFirst', false);
      isFirst = true;
    } else {
      isFirst = false;
    }
    return isFirst!;
  }
}
