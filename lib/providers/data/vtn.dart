import 'package:flutter/material.dart';
import 'package:qwid/models/country.dart';
import 'package:qwid/models/purpose.dart';
import 'package:qwid/models/source.dart';
import 'package:qwid/models/state.dart';

class VTNData extends ChangeNotifier {
  List<Country> _countries = [];
  List<Country> get countries => _countries;
  set countries(List<Country> val) {
    _countries = val;
    notifyListeners();
  }

  List<States> _states = [];
  List<States> get states => _states;
  set states(List<States> val) {
    _states = val;
    notifyListeners();
  }

  List<String> _cities = [];
  List<String> get cities => _cities;
  set cities(List<String> val) {
    _cities = val;
    notifyListeners();
  }

  Country? _country;
  Country? get country => _country;
  set country(Country? val) {
    _country = val;
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

  List<Purpose> purposes = [
    {"Id": "7", "Name": "BUSINESS"},
    {"Id": "39", "Name": "SALARY"},
    {"Id": "36", "Name": "PAYMENT FOR SERVICE RENDERED"},
    {"Id": "2", "Name": "EDUCATION"},
    {"Id": "33", "Name": "BILL PAYMENT"},
    {"Id": "1", "Name": "FAMILY MAINTENANCE"},
    {"Id": "9", "Name": "INVESTMENT"},
    {"Id": "2", "Name": "EDUCATION"},
    {"Id": "4", "Name": "CHARITY"},
    {"Id": "3", "Name": "EXPENSES"},
    {"Id": "8", "Name": "SHOPPING"},
    {"Id": "11", "Name": "GENERAL"},
  ].map((e) => Purpose.fromMap(e)).toList();
  List<Source> sources = [
    {"Id": "2", "Name": "BUSINESS"},
    {"Id": "10", "Name": "SAVINGS OR ACCUMULATED"},
    {"Id": "15", "Name": "GIFT OR INHERITANCE"},
    {"Id": "3", "Name": "EMPLOYEES SALARY"},
    {"Id": "16", "Name": "PROCEEDS OF SALE"}
  ].map((e) => Source.fromMap(e)).toList();
  String? currency;
  String? purposeTest;
  String? sourceTest;
  Purpose? purpose;
  Source? source;

  clear() {
    _country = null;
    _city = null;
    _state = null;
    purpose = null;
    source = null;
    // currency = null;
  }
}
