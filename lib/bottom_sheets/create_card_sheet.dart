import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/bottom_sheets/general_sheet.dart';
import 'package:qwid/models/virtual_card_cur.dart';
import 'package:qwid/providers/API/card.dart';
import 'package:qwid/providers/data/card.dart';
import 'package:qwid/providers/data/wallet.dart';

class CreateCard<String> extends GeneralSheet {
  CreateCard({Key? key, required BuildContext context, Function()? onPressed})
      : super(
          key: key,
          subtitle: 'Select currency',
          title: 'Create Virtual Card',
          buttonText: 'Create',
          body: [
            Consumer2<CardData, WalletData>(
              builder: (context, data, walletData, chi9ld) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Consumer<CardAPI>(builder: (context, api, chi9ld) {
                        return FutureBuilder<List<VirtualCardCur>?>(
                            future: data.virtualCardCurs != null
                                ? null
                                : api.listVirtualCards(
                                    context,
                                  ),
                            builder: (context, snapshot) {
                              return LabelledDropdown(
                                icon: data.virtualCardCurs != null
                                    ? null
                                    : const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          strokeWidth: 1.2,
                                          valueColor: AlwaysStoppedAnimation(
                                              CustomColors.primary),
                                        ),
                                      ),
                                hint: 'Select currency',
                                items: (data.virtualCardCurs ?? [])
                                    .map((e) => e.cur!)
                                    .toList(),
                                onChanged: (value) {
                                  data.virtualCardCur =
                                      (data.virtualCardCurs ?? []).firstWhere(
                                          (element) => element.cur == value);
                                },
                                label: 'CURRENCY',
                                value: data.virtualCardCur?.cur,
                              );
                            });
                      }),
                      const SizedBox(
                        height: 8,
                      ),
                      if (data.virtualCardCur != null)
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
                                      '${walletData.wallets.firstWhere((element) => element.cur == data.virtualCardCur?.cur).balance?.toStringAsFixed(2)} ${data.virtualCardCur?.cur}',
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
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'CARD COLOR',
                          style: CustomTextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.labelText.withOpacity(0.5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 28,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              data.color = data.presets.keys.toList()[index];
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: data.presets.keys
                                              .toList()
                                              .indexOf(data.color) !=
                                          index
                                      ? Colors.transparent
                                      : CustomColors.labelText.withOpacity(0.5),
                                ),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                height: 24,
                                width: 24,
                                decoration: BoxDecoration(
                                  color: data.presets.values.toList()[index],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 24,
                          ),
                          itemCount: data.presets.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          onPressed: () {
            if (Provider.of<CardData>(
                  context,
                  listen: false,
                ).virtualCardCur !=
                null) {
              Navigation.pop(
                context,
              );
            }
          },
        );
}
