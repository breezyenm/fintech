import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/bottom_sheets/options_sheet.dart';
import 'package:qwid/providers/data/wallet.dart';

class MethodSheet extends OptionsSheet {
  MethodSheet(
      {Key? key, required BuildContext context, required Widget summaryPage})
      : super(
          context: context,
          key: key,
          title: 'Payment method',
          subtitle: 'How do you want to pay?',
          options: {
            'Bank Transfer': 'Send money to a bank account',
            'Wallet': 'Send money from your wallet',
            // 'Blinqpay': 'Send money using blinqpay checkout',
          },
          optionsAction: {
            'Bank Transfer': () {
              Provider.of<WalletData>(context, listen: false).method = 3;
              Navigation.push(
                summaryPage,
                context,
              );
            },
            'Wallet': () {
              Provider.of<WalletData>(context, listen: false).method = 1;
              Navigation.push(
                summaryPage,
                context,
              );
            },
            // 'Blinqpay': () {},
          },
        );
}
