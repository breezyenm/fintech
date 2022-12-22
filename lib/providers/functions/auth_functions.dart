import 'package:flutter/material.dart';

class AuthFunctions extends ChangeNotifier {
  reduce({required int number, required Function() function}) async {
    int no = number;
    if (no > 0) {
      await Future.delayed(
          const Duration(
            seconds: 1,
          ), () {
        no -= 1;
        function;
      });
      reduce(
        number: number,
        function: function,
      );
    } else {
      return;
    }
  }
}
