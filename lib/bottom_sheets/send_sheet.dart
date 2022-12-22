import 'package:flutter/material.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/bottom_sheets/bank_transfer_sheet.dart';
import 'package:qwid/bottom_sheets/internal_transfer_sheet.dart';
import 'package:qwid/bottom_sheets/options_sheet.dart';

class SendSheet extends OptionsSheet {
  SendSheet({Key? key, required BuildContext context})
      : super(
          context: context,
          key: key,
          title: 'Select transfer type',
          subtitle: 'Are you sending to a qwid user or an external account',
          options: {
            'Internal Transfer': 'Send money to a qwid account',
            'Bank Transfer': 'Send money to an external bank account',
          },
          optionsAction: {
            'Internal Transfer': () {
              Navigation.pop(context);
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => InternalTransferSheet(
                  context: context,
                ),
              );
            },
            'Bank Transfer': () {
              Navigation.pop(context);
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => BankTransferSheet(
                  context: context,
                ),
              );
            },
          },
        );
}
