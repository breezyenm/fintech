import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/bottom_sheets/convert_sheet_widget.dart';
import 'package:qwid/bottom_sheets/send_sheet.dart';
import 'package:qwid/bottom_sheets/topup_sheet.dart';
import 'package:qwid/bottom_sheets/withdraw_sheet.dart';
import 'package:qwid/models/wallet.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/wallet_action.dart';

class WalletActions extends StatelessWidget {
  final Wallet wallet;
  final double scale;
  const WalletActions({Key? key, this.scale = 1, required this.wallet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletData>(builder: (context, data, chi9ld) {
      return Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: WalletAction(
              onPressed: () {
                data.clear();
                data.wallet = wallet;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => TopupSheet(
                    context: context,
                  ),
                );
              },
              scale: scale,
              title: 'Top-up',
              icon: 'add',
              textColor: const Color(0xff095203),
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: WalletAction(
              onPressed: () {
                data.clear();
                data.wallet = wallet;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => SendSheet(
                    context: context,
                  ),
                );
              },
              scale: scale,
              title: 'Send',
              icon: 'send',
              textColor: CustomColors.darkPrimary,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: WalletAction(
              onPressed: () {
                data.clear();
                data.wallet = wallet;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => WithdrawSheet(
                    context: context,
                  ),
                );
              },
              scale: scale,
              title: 'Withdraw',
              icon: 'withdraw',
              textColor: CustomColors.black,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: WalletAction(
              onPressed: () {
                data.clear();
                data.wallet = wallet;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => BottomSheet(
                    onClosing: () {},
                    key: key,
                    backgroundColor: CustomColors.white,
                    enableDrag: false,
                    builder: (context) => const ConvertSheetWidget(),
                  ),
                );
              },
              scale: scale,
              title: 'Convert',
              icon: 'convert',
              textColor: const Color(0xffBC953B),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      );
    });
  }
}
