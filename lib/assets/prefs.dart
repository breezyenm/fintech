// import 'package:shared_preferences/shared_preferences.dart';

// class Prefs {
//   SharedPreferences _prefs;

//   Prefs._();
//   static final Prefs instance = Prefs._();

//   Future<SharedPreferences> get init async {
//     if (_prefs == null) {
//       _prefs = await SharedPreferences.getInstance();
//     }
//     return _prefs;
//   }

//   bool get firstTime => _prefs.getBool('firstTime') ?? true;

//   void setFirstTime(bool value) => _prefs.setBool('firstTime', value);

//   String get pin => _prefs.getString('pin');

//   void setPin(String value) => _prefs.setString('pin', value);
// }
