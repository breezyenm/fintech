import 'package:flutter/material.dart';
import 'package:qwid/assets/confirm.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/bottom_sheets/options_sheet.dart';
import 'package:qwid/models/virtual_card.dart';

class CardOptions<String> extends OptionsSheet {
  CardOptions({
    Key? key,
    required BuildContext context,
    required VirtualCard virtualCard,
  }) : super(
          context: context,
          key: key,
          title: 'Virtual card options',
          options: {
            'New card': 'Create a new virtual card',
            '${!virtualCard.virtualCardFreeze! ? 'Freeze' : 'Activate'} card':
                '${!virtualCard.virtualCardFreeze! ? 'Freeze' : 'Activate'} your ${virtualCard.virtualCardCur} card',
            '${virtualCard.virtualCardStatus == 1 ? 'Deactivate' : 'Activate'} card':
                '${virtualCard.virtualCardStatus == 1 ? 'Deactivate' : 'Activate'} your ${virtualCard.virtualCardCur} card',
          },
          optionsAction: {
            'New card': () async {
              Navigation.popWithResult(context, 'new');
            },
            '${!virtualCard.virtualCardFreeze! ? 'Freeze' : 'Activate'} card':
                () async {
              await confirm(
                context: context,
                content:
                    'Are you sure you want to ${!virtualCard.virtualCardFreeze! ? 'freeze' : 'activate'} this card?',
                yes: !virtualCard.virtualCardFreeze! ? 'Freeze' : 'Activate',
                no: 'Cancel',
              ).then((value) {
                if (value) {
                  Navigation.popWithResult(context, 'freeze');
                }
              });
            },
            '${virtualCard.virtualCardStatus == 1 ? 'Deactivate' : 'Activate'} card':
                () async {
              await confirm(
                context: context,
                content:
                    'Are you sure you want to ${virtualCard.virtualCardStatus == 1 ? 'deactivate' : 'activate'} this card?',
                yes: virtualCard.virtualCardStatus == 1
                    ? 'Deactivate'
                    : 'Activate',
                yesDestructive: virtualCard.virtualCardStatus == 1,
                no: 'Cancel',
              ).then((value) {
                if (value) {
                  Navigation.popWithResult(context, 'deactivate');
                }
              });
            },
          },
        );
}
