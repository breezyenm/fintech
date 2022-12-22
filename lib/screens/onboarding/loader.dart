import 'package:qwid/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/providers/API/account.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/brain/account_provider.dart';
import 'package:qwid/providers/brain/home_provider.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/skeletons/home.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool done = false;
  @override
  Widget build(BuildContext context) {
    return Consumer4<WalletAPI, WalletData, AccountAPI, AccountProvider>(
        builder: (context, api, data, accountAPI, accountPro, child) {
      return FutureBuilder(
        future: mounted && !done
            ? Future.wait([
                if (data.wallets.isEmpty) api.getUserWallet(context),
                if (accountPro.virtualAccounts == null)
                  accountAPI.getUsersVirtualWallets(context)
              ])
            : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            done = true;
          }
          if (data.wallets.isNotEmpty && accountPro.virtualAccounts != null) {
            Provider.of<HomeProvider>(context, listen: false).loggedIn = true;
            return const Home();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(
                  CustomColors.primary,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
