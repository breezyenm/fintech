import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/bottom_sheets/general_sheet.dart';
import 'package:qwid/models/virtual_card.dart';
import 'package:qwid/providers/data/wallet.dart';

class FundCard<String> extends GeneralSheet {
  FundCard({
    Key? key,
    required VirtualCard virtualCard,
    required BuildContext context,
  }) : super(
          key: key,
          subtitle: 'Enter amount',
          title: 'Fund card',
          buttonText: 'Pay with wallet',
          body: [
            Consumer<WalletData>(
              builder: (context, data, chi9ld) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LabelledTextField(
                        label: 'AMOUNT',
                        controller: data.amount,
                        type: TextInputType.number,
                        textInputAction: TextInputAction.done,
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
                                    '${data.wallets.firstWhere((element) => element.cur?.toLowerCase() == virtualCard.virtualCardCur?.toLowerCase()).balance?.toStringAsFixed(2)} ${virtualCard.virtualCardCur}',
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
              },
            ),
          ],
          onPressed: () {
            Navigation.popWithResult(
              context,
              Provider.of<WalletData>(context, listen: false).amount.text,
            );
          },
        );
}
