import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/statement.dart';
import 'package:qwid/models/transaction.dart';
import 'package:qwid/models/wallet.dart';

class WalletData extends ChangeNotifier {
  List<Wallet> wallets = [];

  File? _purposeFile;
  File? get purposeFile => _purposeFile;
  set purposeFile(File? val) {
    _purposeFile = val;
    notifyListeners();
  }

  List<Transaction> transactions = [];
  // List<Transaction> _transactions = [];
  // List<Transaction> get transactions => _transactions;
  // set transactions(List<Transaction> val) {
  //   _transactions = val;
  //   notifyListeners();
  // }
  List<Statement>? _statements;
  List<Statement>? get statements => _statements;
  set statements(List<Statement>? val) {
    _statements = val;
    notifyListeners();
  }
  // Map<String, List<Statement>>? _statements;
  // Map<String, List<Statement>>? get statements => _statements;
  // set statements(Map<String, List<Statement>>? val) {
  //   _statements = val;
  //   notifyListeners();
  // }

  int limit = 20;

  Wallet? _wallet;
  Wallet? get wallet => _wallet;
  set wallet(Wallet? val) {
    _wallet = val;
    notifyListeners();
  }

  Country? _country;
  Country? get country => _country;
  set country(Country? val) {
    _country = val;
    notifyListeners();
  }

  Country? _toCountry;
  Country? get toCountry => _toCountry;
  set toCountry(Country? val) {
    _toCountry = val;
    notifyListeners();
  }

  Wallet? _toWallet;
  Wallet? get toWallet => _toWallet;
  set toWallet(Wallet? val) {
    _toWallet = val;
    notifyListeners();
  }

  String? _beneficiaryCur;
  String? get beneficiaryCur => _beneficiaryCur;
  set beneficiaryCur(String? val) {
    _beneficiaryCur = val;
    notifyListeners();
  }

  int? method;

  String? year;

  String? fromCur;

  String? toCur;

  TextEditingController amount = TextEditingController();
  TextEditingController fromAmount = TextEditingController();
  TextEditingController toAmount = TextEditingController();
  TextEditingController beneficiaryEmail = TextEditingController();
  // TextEditingController fromCur = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  // TextEditingController dob = TextEditingController();
  // TextEditingController address = TextEditingController();
  // TextEditingController phone = TextEditingController();
  // TextEditingController resetCode = TextEditingController();
  // TextEditingController newPassword = TextEditingController();
  // TextEditingController code = TextEditingController();
  // TextEditingController password = TextEditingController();
  // TextEditingController referral = TextEditingController();
  // TextEditingController companyName = TextEditingController();

  clear() {
    amount.clear();
    fromAmount.clear();
    toAmount.clear();
    beneficiaryEmail.clear();
    fromCur = null;
    toCur = null;
    year = null;
  }
}
