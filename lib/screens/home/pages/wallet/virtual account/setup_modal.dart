import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/providers/brain/account_provider.dart';
import 'package:qwid/screens/home/pages/wallet/virtual%20account/select_currency.dart';

class SetupModal extends StatelessWidget {
  const SetupModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIcon(
            height: 120,
            icon: 'save',
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'SETUP VIRTUAL ACCOUNT',
            style: CustomTextStyle(
              color: CustomColors.labelText,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            'Receive money and credit your wallet quick and easy with your own virtual account\n\nThis works just like any regular bank account you will get an IBAN which enables you to send and recieve GBP, EUR, USD payments',
            style: CustomTextStyle(
              color: CustomColors.labelText,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomButton(
            text: 'Continue',
            onPressed: () async {
              Navigation.pop(context);
              await showDialog(
                context: context,
                builder: (context) => const SelectCurrency(),
              );
            },
          ),
        ],
      ),
    );
  }
}
