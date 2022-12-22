import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/bottom_sheets/card_options.dart';
import 'package:qwid/bottom_sheets/create_card_sheet.dart';
import 'package:qwid/models/virtual_card.dart';
import 'package:qwid/providers/API/card.dart';
import 'package:qwid/providers/data/card.dart';

class CardButton extends StatefulWidget {
  final VirtualCard card;
  const CardButton({Key? key, required this.card}) : super(key: key);

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer2<CardAPI, CardData>(builder: (context, api, data, chi9ld) {
      return IconButton(
        icon: loading
            ? const SizedBox(
                height: 12,
                width: 12,
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 1.2,
                  valueColor: AlwaysStoppedAnimation(
                    CustomColors.primary,
                  ),
                ),
              )
            : const Icon(
                Icons.more_vert,
                color: CustomColors.labelText,
              ),
        onPressed: () async {
          String? action = await showModalBottomSheet<String>(
            isScrollControlled: true,
            context: context,
            builder: (context) => CardOptions(
              virtualCard: widget.card,
              context: context,
            ),
          );
          if (action != null) {
            setState(() {
              loading = true;
            });
            switch (action) {
              case 'new':
                data.clear();
                await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => CreateCard(
                    context: context,
                  ),
                );
                if (data.virtualCardCur != null) {
                  bool success = await api.createVirtualCard(
                    context,
                  );
                  if (success) {
                    setState(() {});
                  }
                }
                if (mounted) {
                  setState(() {
                    loading = false;
                  });
                }
                break;
              case 'freeze':
                data.clear();
                bool success = await api.toggleActivation(
                  context,
                  'freeze',
                );
                if (success) {
                  await api.getVirtualCards(context);
                  data.virtualCard = data.virtualCards?.firstWhere((element) =>
                      element.virtualCardId == widget.card.virtualCardId);
                }

                // if (mounted) {
                //   setState(() {
                //   });
                // }
                break;
              case 'deactivate':
                data.clear();
                bool success = await api.toggleActivation(
                  context,
                  'activate',
                );
                if (success) {
                  await api.getVirtualCards(context);
                  data.virtualCard = data.virtualCards?.firstWhere((element) =>
                      element.virtualCardId == widget.card.virtualCardId);
                }
                break;
            }

            setState(() {
              loading = false;
            });
          }
        },
      );
    });
  }
}
