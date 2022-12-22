import 'package:flutter/material.dart';
import 'package:qwid/models/virtual_account.dart';
import 'package:qwid/models/virtual_accounts.dart';
import 'package:qwid/models/wallet.dart';

class AccountProvider extends ChangeNotifier {
  int _page = 0;
  int get page => _page;
  set page(int val) {
    _page = val;
    notifyListeners();
  }

  VirtualAccounts? _virtualAccountToBeAdded;
  VirtualAccounts? get virtualAccountToBeAdded => _virtualAccountToBeAdded;
  set virtualAccountToBeAdded(VirtualAccounts? val) {
    _virtualAccountToBeAdded = val;
    notifyListeners();
  }

  Wallet? _wallet;
  Wallet? get wallet => _wallet;
  set wallet(Wallet? val) {
    _wallet = val;
    notifyListeners();
  }

  List<VirtualAccount>? virtualAccounts;
  List<VirtualAccounts> virtualAccountsToBeAdded = [];
  // Wallet? wallet;
  // List<VirtualAccount>? get virtualAccounts => _virtualAccounts;
  // set virtualAccounts(List<VirtualAccount>? val) {
  //   _virtualAccounts = val;
  //   notifyListeners();
  // }
}
