import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/models/wallet.dart';
import 'package:qwid/providers/API/auth.dart';
import 'package:qwid/screens/home/pages/home/home_page.dart';
import 'package:qwid/screens/home/pages/beneficiary/beneficiary_page.dart';
import 'package:qwid/screens/home/pages/settings/settings_page.dart';
import 'package:qwid/screens/home/pages/virtual%20card/virtual_card_page.dart';
// import 'package:qwid/screens/home/pages/virtual%20card/virtual_card_page.dart';
import 'package:qwid/screens/onboarding/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }

  Wallet? _displayedWallet;
  Wallet? get displayedWallet => _displayedWallet;
  set displayedWallet(Wallet? val) {
    _displayedWallet = val;
    notifyListeners();
  }

  List<Widget> tabs = [
    const HomePage(),
    // const WalletPage(),
    const VirtualCardPage(),
    const BeneficiaryPage(),
    const SettingsPage(),
  ];

  List<String> tabTitles = [
    'Dashboard',
    // 'Wallet',
    'Virtual Card',
    'Beneficiary',
    'Settings',
  ];

  Timer? _timer;
  Timer? get timer => _timer;
  set timer(Timer? val) {
    _timer = val;
    notifyListeners();
  }

  bool loggedIn = false;
  bool? _timing;
  bool? get timing => _timing;
  set timing(bool? val) {
    _timing = val;
    notifyListeners();
  }

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> initializeTimer(BuildContext context) async {
    timing = true;
    if (_timer != null) {
      _timer?.cancel();
    }

    timer = Timer(
      const Duration(minutes: 5),
      () {
        if (loggedIn) {
          // logOutUser(context);
        }
      },
    );
  }

  Future<void> logOutUser(BuildContext context) async {
    AuthAPI auth = Provider.of<AuthAPI>(context, listen: false);
    _timer?.cancel();
    timer = null;
    loggedIn = false;
    await auth.logout(context);
    // Popping all routes and pushing welcome screen
    await navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (_) => false,
    );
  }

  void handleUserInteraction(BuildContext context) {
    if (timing ?? true) initializeTimer(context);
  }

  Future getTiming(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    timing = preferences.getBool('auto-lock') ?? true;
    preferences.setBool('auto-lock', timing!);
    if (timing!) {
      initializeTimer(context);
    }
    debugPrint(timing.toString());
  }
}
