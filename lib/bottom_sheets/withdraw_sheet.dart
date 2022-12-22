import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/bottom_sheets/general_sheet.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/pages/wallet/transactions/withdraw/select_bank.dart';

class WithdrawSheet extends GeneralSheet {
  WithdrawSheet({Key? key, required BuildContext context})
      : super(
          key: key,
          subtitle: 'Enter amount and select currency',
          title: 'Withdraw',
          buttonText: 'Select Bank Account',
          body: [
            Consumer<WalletData>(builder: (context, data, chi9ld) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LabelledTextField(
                      label: 'AMOUNT',
                      controller: data.amount,
                      type: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    LabelledDropdown(
                      hint: 'Select currency',
                      label: 'CURRENCY',
                      items: data.wallets
                          .map((e) => e.cur!.toUpperCase())
                          .toList(),
                      onChanged: (value) {
                        data.fromCur = value;
                        data.wallet = data.wallets
                            .firstWhere((element) => element.cur == value);
                      },
                      value: data.wallet?.cur,
                      //   prefix: CircleAvatar(
                      //   radius: 12,
                      //   backgroundColor: CustomColors.stroke,
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(12),
                      //     child: SvgPicture.network(
                      //       e.flag,
                      //       width: 24,
                      //       height: 24,
                      //       alignment: Alignment.center,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Bal: ',
                              style: CustomTextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.labelText,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '${data.wallet?.balance?.toStringAsFixed(2)} ${data.wallet?.cur}',
                              style: const CustomTextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
          onPressed: () {
            Navigation.push(
              const SelectBank(),
              context,
            );
          },
        );
}
