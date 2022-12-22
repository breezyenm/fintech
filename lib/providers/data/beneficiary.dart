import 'package:flutter/material.dart';
import 'package:qwid/models/beneficiary.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/currency.dart';
import 'package:qwid/models/nig_bank.dart';
import 'package:qwid/models/state.dart';

class BeneficiaryData extends ChangeNotifier {
  List<Beneficiary>? beneficiaries;
  late GlobalKey<FormState> formKey;
  List<States> states = [];
  // List<States> get states => _states;
  // set states(List<States> val) {
  //   _states = val;
  //   notifyListeners();
  // }

  List<String> cities = [];
  // List<String> get cities => _cities;
  // set cities(List<String> val) {
  //   _cities = val;
  //   notifyListeners();
  // }
  // String? currency;

  Country? _country;
  Country? get country => _country;
  set country(Country? val) {
    _country = val;
    notifyListeners();
  }

  Country? _bankCountry;
  Country? get bankCountry => _bankCountry;
  set bankCountry(Country? val) {
    _bankCountry = val;
    notifyListeners();
  }

  Currency? _currency;
  Currency? get currency => _currency;
  set currency(Currency? val) {
    _currency = val;
    notifyListeners();
  }

  States? _state;
  States? get state => _state;
  set state(States? val) {
    _state = val;
    notifyListeners();
  }

  String? _city;
  String? get city => _city;
  set city(String? val) {
    _city = val;
    notifyListeners();
  }

  States? _bankState;
  States? get bankState => _bankState;
  set bankState(States? val) {
    _bankState = val;
    notifyListeners();
  }

  String? _bankCity;
  String? get bankCity => _bankCity;
  set bankCity(String? val) {
    _bankCity = val;
    notifyListeners();
  }

  String? _beneficiaryType;
  String? get beneficiaryType => _beneficiaryType;
  set beneficiaryType(String? val) {
    _beneficiaryType = val;
    notifyListeners();
  }

  String? _accountType;
  String? get accountType => _accountType;
  set accountType(String? val) {
    _accountType = val;
    notifyListeners();
  }

  TextEditingController accountName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController accountNo = TextEditingController();
  TextEditingController sortCode = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController swift = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController bankAddress = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController bankZipcode = TextEditingController();
  TextEditingController routingNo = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController cpf = TextEditingController();
  TextEditingController idType = TextEditingController();
  NigBank? _bank;
  NigBank? get bank => _bank;
  set bank(NigBank? val) {
    _bank = val;
    notifyListeners();
  }

  Map<String, String> accountTypes = {
    'Checkings': '1',
    'Savings': '2',
    'Ordinary': '3',
  };

  Map<String, String> beneficiaryTypes = {
    'Individual Beneficiary': '1',
    'Business Beneficiary': '2',
  };
  // String? accountType = 'Savings';
  clear() {
    accountName.clear();
    email.clear();
    accountNo.clear();
    mobile.clear();
    swift.clear();
    routingNo.clear();
    bank = NigBank();
    cpf.clear();
    idType.clear();
    accountType = null;
    bankCountry = null;
    country = null;
    state = null;
    city = null;
    beneficiaryType = null;
    address.clear();
    bankAddress.clear();
    zipcode.clear();
    bankZipcode.clear();
    currency = null;
    bankName.clear();
  }

  List<NigBank> nigBanks = [];
}
