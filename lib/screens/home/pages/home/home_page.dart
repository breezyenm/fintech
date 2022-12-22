import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/providers/brain/account_provider.dart';
import 'package:qwid/providers/brain/home_provider.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/alert.dart';
import 'package:qwid/screens/home/components/transaction_list.dart';
import 'package:qwid/screens/home/components/virtual_account_card.dart';
import 'package:qwid/screens/home/components/wallet_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Consumer<HomeProvider>(builder: (context, homePro, chi9ld) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        children: [
          const Alert(),
          const SizedBox(
            height: 16,
          ),
          Consumer<WalletData>(
            builder: (context, data, chi9ld) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: data.wallets
                      .map(
                        (e) => WalletCard(
                          wallet: e,
                          // flag: e.flag!,
                          // currency: e.currency!,
                          // balance: e.balance!.toStringAsFixed(2),
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Consumer2<HomeProvider, AccountProvider>(
              builder: (context, homePro, accountPro, chi9ld) {
            return VirtualWalletCard(
              wallet: homePro.displayedWallet!,
              virtualAccount: (accountPro.virtualAccounts ?? [])
                      .where((element) =>
                          element.cur == homePro.displayedWallet?.cur)
                      .isEmpty
                  ? null
                  : (accountPro.virtualAccounts ?? []).firstWhere(
                      (element) => element.cur == homePro.displayedWallet?.cur),
            );
            // : InfoCard(
            //     title: 'VIRTUAL ACCOUNT',
            //     info: accountPro.virtualAccounts
            //             .firstWhere((element) =>
            //                 element.cur == homePro.displayedWallet?.cur)
            //             .accountNo ??
            //         '',
            //     copyable: true,
            //     subInfo: accountPro.virtualAccounts
            //             .firstWhere((element) =>
            //                 element.cur == homePro.displayedWallet?.cur)
            //             .bankName ??
            //         '',
            //   );
          }),
          // const SizedBox(
          //   height: 16,
          // ),
          // InfoCard(
          //   title: 'VIRTUAL CARD STATUS',
          //   info: 'Active',
          //   infoColor: CustomColors.green.withOpacity(0.5),
          //   subInfo: 'View card details',
          //   subInfoFunction: () {},
          // ),
          const SizedBox(
            height: 24,
          ),
          const TransactionList(),
        ],
      ),
    );
    // });
  }
}
