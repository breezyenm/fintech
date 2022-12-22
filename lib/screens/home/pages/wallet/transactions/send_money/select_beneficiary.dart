import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/beneficiary.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/info_card.dart';
import 'package:qwid/screens/home/pages/beneficiary/beneficiary_page.dart';

import 'more_information.dart';

class SelectBeneficiary extends StatelessWidget {
  const SelectBeneficiary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send money',
        ),
      ),
      body: Consumer3<WalletData, VTNData, VTNAPI>(
          builder: (context, data, vtnData, vtn, chi9ld) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoCard(
              title: 'YOU ARE SENDING',
              info: '${data.amount.text} ${data.wallet?.cur ?? data.fromCur}',
              subInfo:
                  'BALANCE: ${data.wallet?.balance?.toStringAsFixed(2) ?? 0} ${data.wallet?.cur}',
              // action: () {},
              // actionText: 'EDIT',
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Beneficiary',
                    style: CustomTextStyle(
                      color: CustomColors.text,
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Who do you want to send to?',
                    style: CustomTextStyle(
                      color: CustomColors.text.withOpacity(0.5),
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: BeneficiaryPage(
                onTap: (Beneficiary beneficiary) {
                  Navigation.push(
                    MoreInformation(
                      beneficiary: beneficiary,
                    ),
                    context,
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
