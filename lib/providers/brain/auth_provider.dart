import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qwid/models/user.dart';

class AuthProvider extends ChangeNotifier {
  // List<String> genders = ['Male', 'Female', 'Prefer not to say'];
  // String _gender = 'Male';

  // List<String> providers = ['Individual', 'Company'];
  // String _provider = 'Individual';

  int _resend = 0;

  int get resend => _resend;
  set resend(int val) {
    _resend = val;
    notifyListeners();
  }

  reduce() async {
    if (resend > 0) {
      await Future.delayed(
          const Duration(
            seconds: 1,
          ), () {
        resend -= 1;
      });
      reduce();
    } else {
      return;
    }
  }

  // String get provider => _provider;
  // set provider(String val) {
  //   _provider = val;
  //   notifyListeners();
  // }

  // String get gender => _gender;
  // set gender(String val) {
  //   _gender = val;
  //   notifyListeners();
  // }

  // bool _agree = false;
  // bool get agree => _agree;
  // set agree(bool val) {
  //   _agree = val;
  //   notifyListeners();
  // }

  // bool _loading = false;
  // bool get loading => _loading;
  // set loading(bool val) {
  //   _loading = val;
  //   notifyListeners();
  // }

  // User _user = User();
  // User get user => _user;
  // set user(User val) {
  //   _user = val;
  //   notifyListeners();
  // }
}
