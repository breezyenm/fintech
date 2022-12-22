import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/models/virtual_card.dart';
import 'package:qwid/models/wallet.dart';
import 'package:qwid/providers/API/card.dart';
import 'package:qwid/providers/brain/account_provider.dart';
import 'package:qwid/providers/brain/card_provider.dart';
import 'package:qwid/providers/data/card.dart';
import 'package:qwid/screens/home/components/currency_item.dart';
import 'package:qwid/screens/home/components/info_card.dart';
import 'package:qwid/screens/home/components/transaction_list.dart';
import 'package:qwid/screens/home/components/virtual_account_card.dart';
import 'package:qwid/screens/home/components/wallet_actions.dart';

class WalletPage extends StatelessWidget {
  final Wallet wallet;
  const WalletPage({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(builder: (context, accountPro, chi9ld) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Wallet',
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          children: [
            CurrencyItem(
              wallet: wallet,
            ),
            const SizedBox(
              height: 16,
            ),
            // SizedBox(
            //   height: 200,
            //   child: RotatedBox(
            //     quarterTurns: -1,
            //     child: ListWheelScrollView(
            //       renderChildrenOutsideViewport: true,
            //       clipBehavior: Clip.none,
            //       // overAndUnderCenterOpacity: 0.5,
            //       onSelectedItemChanged: (value) {
            //         walletPro.activeCurrency = value;
            //       },
            //       itemExtent: MediaQuery.of(context).size.width * 0.7,
            //       children: [
            //         CurrencyItem(
            //           active: walletPro.activeCurrency == 0,
            //           currency: 'US Dollar',
            //           cur: 'USD',
            //           balance: '97.21 USD',
            //         ),
            //         CurrencyItem(
            //           active: walletPro.activeCurrency == 1,
            //           currency: 'EURO',
            //           cur: 'EUR',
            //           balance: '97.21 USD',
            //         ),
            //         CurrencyItem(
            //           active: walletPro.activeCurrency == 2,
            //           currency: 'Great Britain Pound',
            //           cur: 'GBP',
            //           balance: '97.21 USD',
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            WalletActions(
              wallet: wallet,
              scale: 1.2,
            ),
            const SizedBox(
              height: 16,
            ),
            // if (
            //     (accountPro.virtualAccounts ?? [])
            //         .where((element) =>
            //             element.cur?.toLowerCase() == wallet.cur?.toLowerCase())
            //         .isNotEmpty)
            VirtualWalletCard(
              wallet: wallet,
              // active: true,
              virtualAccount: (accountPro.virtualAccounts ?? [])
                      .where((element) =>
                          element.cur?.toLowerCase() ==
                          wallet.cur?.toLowerCase())
                      .isNotEmpty
                  ? (accountPro.virtualAccounts ?? []).firstWhere(
                      (element) =>
                          element.cur?.toLowerCase() ==
                          wallet.cur?.toLowerCase(),
                    )
                  : null,
            ),
            // if ((accountPro.virtualAccounts ?? [])
            //     .where((element) =>
            //         element.cur?.toLowerCase() == wallet.cur?.toLowerCase())
            //     .isNotEmpty)
            // if (wallet.cur == 'USD')
            //   const SizedBox(
            //     height: 16,
            //   ),
            // if (wallet.cur == 'USD')
            //   Consumer3<CardAPI, CardData, CardProvider>(
            //       builder: (context, api, data, pro, chi9ld) {
            //     return FutureBuilder<List<VirtualCard>?>(
            //         future: api.getVirtualCardsWithCur(
            //           context,
            //           wallet.cur!,
            //         ),
            //         builder: (context, snapshot) {
            //           return pro.loading
            //               ? const SizedBox(
            //                   height: 96,
            //                   child: Center(
            //                     child: SizedBox(
            //                       height: 12,
            //                       width: 12,
            //                       child: CircularProgressIndicator.adaptive(
            //                         strokeWidth: 1.2,
            //                         valueColor: AlwaysStoppedAnimation(
            //                           CustomColors.primary,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               : InfoCard(
            //                   centered: true,
            //                   title: 'VIRTUAL CARD STATUS',
            //                   subWidget: data.virtualCards == null
            //                       ? const Align(
            //                           alignment: Alignment.centerLeft,
            //                           child: Padding(
            //                             padding: EdgeInsets.all(8.0),
            //                             child: SizedBox(
            //                               height: 12,
            //                               width: 12,
            //                               child: CircularProgressIndicator
            //                                   .adaptive(
            //                                 strokeWidth: 1.2,
            //                                 valueColor: AlwaysStoppedAnimation(
            //                                   CustomColors.primary,
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         )
            //                       : null,
            //                   info: data.virtualCards == null
            //                       ? 'Loading'
            //                       : data.virtualCards!
            //                               .where((element) =>
            //                                   element.virtualCardData != null)
            //                               .toList()
            //                               .isEmpty
            //                           ? 'Not Available'
            //                           : 'Active',
            //                   infoColor: data.virtualCards == null
            //                       ? CustomColors.labelText.withOpacity(0.5)
            //                       : data.virtualCards!
            //                               .where((element) =>
            //                                   element.virtualCardData != null)
            //                               .toList()
            //                               .isEmpty
            //                           ? CustomColors.orange.withOpacity(0.5)
            //                           : CustomColors.green.withOpacity(0.5),
            //                   subInfo: data.virtualCards == null
            //                       ? null
            //                       : data.virtualCards!
            //                               .where((element) =>
            //                                   element.virtualCardData != null)
            //                               .toList()
            //                               .isEmpty
            //                           ? 'Create virtual card'
            //                           : 'View card details',
            //                   subInfoFunction: data.virtualCards == null
            //                       ? null
            //                       : () async {
            //                           if ((data.virtualCards
            //                                       ?.where((element) =>
            //                                           element.virtualCardData !=
            //                                           null)
            //                                       .toList() ??
            //                                   [])
            //                               .isEmpty) {
            //                             pro.loading = true;
            //                             data.virtualCards = null;
            //                             await api.createVirtualCard(context);
            //                           }
            //                           pro.loading = false;
            //                         },
            //                 );
            //         });
            //   }),
            const SizedBox(
              height: 16,
            ),
            TransactionList(
              wallet: wallet,
            )
          ],
        ),
      );
    });
  }
}
