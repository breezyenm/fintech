import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  int _activeCurrency = 0;
  int get activeCurrency => _activeCurrency;
  set activeCurrency(int val) {
    _activeCurrency = val;
    notifyListeners();
  }

  Map<int, String> transactionType = {
    1: 'deposit',
    2: 'withdrawal',
    3: 'withdrawal',
    4: 'withdrawal',
    5: 'deposit',
    6: 'conversion',
    7: 'conversion',
  };

  Map<String, Color> transactionColors = {
    'deposit': const Color(0xffD9FDEF),
    'withdrawal': const Color(0xffFEFCE4),
    'conversion': const Color(0xffFEE4E9),
  };
}
