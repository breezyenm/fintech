import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/option_button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/bank.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/bank_card.dart';
import 'package:qwid/screens/home/components/info_card.dart';
import 'package:qwid/screens/home/pages/wallet/transactions/withdraw/add_bank.dart';

import 'summary.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({Key? key}) : super(key: key);

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  List<Bank>? banks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Withdraw',
        ),
      ),
      body: Consumer<WalletData>(builder: (context, data, chi9ld) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoCard(
              title: 'YOU ARE WITHDRAWING',
              info:
                  '${(int.tryParse(data.amount.text) ?? 0)} ${data.wallet?.cur ?? data.fromCur}',
              subInfo: 'BALANCE: ${data.wallet?.balance}',
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
                    'Select Bank',
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
                    'Which account do you want to withdraw to?',
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: OptionButton(
                onPressed: () async {
                  await Navigation.push(
                    const AddBank(),
                    context,
                  );
                },
                text: 'New Bank',
                subtext: 'Add a new bank to withdraw your funds',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                return FutureBuilder<List<Bank>>(
                    future: api.getUserBanks(data.wallet?.cur, context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        banks = snapshot.data ?? [];
                      }
                      return banks == null
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 12,
                                width: 12,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 1.2,
                                  valueColor: AlwaysStoppedAnimation(
                                    CustomColors.primary,
                                  ),
                                ),
                              ),
                            )
                          : (banks ?? []).isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      const Text(
                                        'Empty',
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
                                        "You've not added any bank, add one now to continue",
                                        style: CustomTextStyle(
                                          color: CustomColors.text
                                              .withOpacity(0.5),
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 32,
                                      ),
                                      child: Text(
                                        'Your Banks',
                                        style: CustomTextStyle(
                                          color: CustomColors.text,
                                          fontFamily: 'Montserrat',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 44),
                                        // itemBuilder: (context, index) => Container(),
                                        itemBuilder: (context, index) =>
                                            BankCard(
                                          bank: snapshot.data![index],
                                          onTap: () {
                                            Navigation.push(
                                              WithdrawSummary(
                                                bank: snapshot.data![index],
                                              ),
                                              context,
                                            );
                                          },
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 16,
                                        ),
                                        itemCount: snapshot.data?.length ?? 0,
                                      ),
                                    ),
                                  ],
                                );
                    });
              }),
            ),
          ],
        );
      }),
    );
  }
}
