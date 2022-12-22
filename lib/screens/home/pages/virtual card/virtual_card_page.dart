import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/bottom_sheets/create_card_sheet.dart';
import 'package:qwid/bottom_sheets/fund_card.dart';
import 'package:qwid/providers/API/card.dart';
import 'package:qwid/providers/data/card.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/info_card.dart';
import 'package:qwid/screens/home/components/virtual_card.dart';
import 'package:qwid/screens/home/components/wallet_action.dart';
import 'package:qwid/screens/home/pages/virtual%20card/virtual_card_details.dart';
import 'package:qwid/screens/home/pages/virtual%20card/virtual_card_transactions.dart';

class VirtualCardPage extends StatefulWidget {
  const VirtualCardPage({Key? key}) : super(key: key);

  @override
  State<VirtualCardPage> createState() => _VirtualCardPageState();
}

class _VirtualCardPageState extends State<VirtualCardPage> {
  bool loading = false;
  // @override
  // void initState() {
  //   Provider.of<CardData>(context, listen: false).virtualCards = null;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CardData, CardAPI>(builder: (context, data, api, chi9ld) {
      return FutureBuilder(
          future: (data.virtualCards?.where(
                          (element) => element.virtualCardData != null) ??
                      [])
                  .isNotEmpty
              ? null
              : api.getVirtualCards(context),
          builder: (context, snapshot) {
            return Scaffold(
              body: data.virtualCards == null
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1.2,
                        valueColor: AlwaysStoppedAnimation(
                          CustomColors.primary,
                        ),
                      ),
                    )
                  : (data.virtualCards?.where((element) =>
                                  element.virtualCardData != null) ??
                              [])
                          .isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                "You've not created any card",
                                style: CustomTextStyle(
                                  color: CustomColors.text.withOpacity(0.5),
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              CustomButton(
                                text:
                                    loading ? 'loading' : 'Create virtual card',
                                onPressed: () async {
                                  setState(() {
                                    loading = true;
                                  });
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
                                      data.virtualCards = null;
                                    }
                                  }
                                  if (mounted) {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            if ((data.virtualCardCurs ?? []).length > 1)
                              // SizedBox(
                              //   height: 48,
                              //   width: double.infinity,
                              //   child: ListView.separated(
                              //     padding: const EdgeInsets.all(16),
                              //     scrollDirection: Axis.horizontal,
                              //     itemBuilder: (context, index) => Center(
                              //       child: Text(
                              //         (data.virtualCardCurs ?? [])[index].cur!,
                              //         style: CustomTextStyle(
                              //           color: data.cur ==
                              //                   (data.virtualCardCurs ??
                              //                           [])[index]
                              //                       .cur
                              //               ? CustomColors.primary
                              //               : CustomColors.labelText,
                              //         ),
                              //       ),
                              //     ),
                              //     separatorBuilder: (context, index) =>
                              //         const VerticalDivider(),
                              //     itemCount: data.virtualCardCurs?.length ?? 0,
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: (data.virtualCardCurs ?? [])
                                      .map(
                                        (e) => Expanded(
                                          child: Center(
                                            child: Text(
                                              e.cur!,
                                              style: CustomTextStyle(
                                                color: data.cur == e.cur
                                                    ? CustomColors.primary
                                                    : CustomColors.labelText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            Expanded(
                              child: ListView(
                                children: [
                                  SizedBox(
                                    height: (MediaQuery.of(context).size.width -
                                            56) *
                                        9 /
                                        16,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      itemBuilder: (context, index) =>
                                          VirtualCardItem(
                                        virtualCard: (data.virtualCards
                                                ?.where((element) =>
                                                    element.virtualCardData !=
                                                    null)
                                                .where((element) =>
                                                    element.virtualCardCur ==
                                                    data.cur)
                                                .toList() ??
                                            [])[index],
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        width: 16,
                                      ),
                                      itemCount: (data.virtualCards
                                                  ?.where((element) =>
                                                      element.virtualCardData !=
                                                      null)
                                                  .where((element) =>
                                                      element.virtualCardCur ==
                                                      data.cur)
                                                  .toList() ??
                                              [])
                                          .length,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  if (!data.virtualCard!.virtualCardFreeze! &&
                                      data.virtualCard?.virtualCardStatus == 1)
                                    Column(
                                      children: [
                                        InfoCard(
                                          centered: true,
                                          title: 'BALANCE',
                                          info: (data.virtualCard ??
                                                      data.virtualCards!
                                                          .firstWhere((element) =>
                                                              element
                                                                  .virtualCardData !=
                                                              null))
                                                  .virtualCardBalance ??
                                              '',
                                          // '${data.virtualCards?.map((e) => e.virtualCardBalance,).reduce((value, element) => (int.parse(value ?? '0') + int.parse(element ?? '0')).toString())} USD',
                                          subInfo: 'View card details',
                                          subInfoFunction: () {
                                            Navigation.push(
                                              VirtualCardDetails(
                                                virtualCard: data.virtualCard ??
                                                    data.virtualCards!
                                                        .firstWhere((element) =>
                                                            element
                                                                .virtualCardData !=
                                                            null),
                                              ),
                                              context,
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: loading
                                                    ? const SizedBox(
                                                        height: 40,
                                                        child: Center(
                                                          child: SizedBox(
                                                            height: 12,
                                                            width: 12,
                                                            child:
                                                                CircularProgressIndicator
                                                                    .adaptive(
                                                              strokeWidth: 1.2,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation(
                                                                CustomColors
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : WalletAction(
                                                        onPressed: () async {
                                                          setState(() {
                                                            loading = true;
                                                          });
                                                          Provider.of<WalletData>(
                                                                  context,
                                                                  listen: false)
                                                              .amount
                                                              .clear();
                                                          String? amount =
                                                              await showModalBottomSheet<
                                                                  String>(
                                                            isScrollControlled:
                                                                true,
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    FundCard(
                                                              virtualCard: data
                                                                  .virtualCard!,
                                                              context: context,
                                                            ),
                                                          );
                                                          if (amount != null) {
                                                            await api
                                                                .fundVirtualCard(
                                                              context,
                                                              amount,
                                                              data.virtualCard!
                                                                  .virtualCardId!,
                                                              data.virtualCard!
                                                                  .virtualCardCur!,
                                                            );
                                                          }
                                                          setState(() {
                                                            loading = false;
                                                          });
                                                        },
                                                        scale: 1.2,
                                                        title: 'Fund card',
                                                        icon: 'deposit',
                                                        textColor:
                                                            CustomColors.green,
                                                      ),
                                              ),
                                              // const SizedBox(
                                              //   width: 4,
                                              // ),
                                              // Expanded(
                                              //   child: WalletAction(
                                              //     onPressed: () {},
                                              //     scale: 1.2,
                                              //     title: 'Withdraw',
                                              //     icon: 'withdraw',
                                              //     textColor: CustomColors.labelText,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        if (data.virtualCard != null)
                                          VirtualCardTransaction(
                                            virtualCard: data.virtualCard!,
                                          ),
                                      ],
                                    ),
                                  if (data.virtualCard!.virtualCardFreeze! ||
                                      data.virtualCard?.virtualCardStatus != 1)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 32,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Text(
                                            data.virtualCard!.virtualCardFreeze!
                                                ? 'Frozen'
                                                : 'Deactivated',
                                            style: CustomTextStyle(
                                              color: data.virtualCard!
                                                      .virtualCardFreeze!
                                                  ? CustomColors.primary
                                                  : CustomColors.red,
                                              fontFamily: 'Montserrat',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "This card is ${data.virtualCard!.virtualCardFreeze! ? 'frozen' : 'deactivated'}, activate it or use another",
                                            style: CustomTextStyle(
                                              color: CustomColors.text
                                                  .withOpacity(0.5),
                                              fontFamily: 'Montserrat',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          CustomButton(
                                            text: loading
                                                ? 'loading'
                                                : 'Activate virtual card',
                                            onPressed: () async {
                                              setState(() {
                                                loading = true;
                                              });
                                              data.clear();
                                              await api
                                                  .toggleActivation(
                                                context,
                                                data.virtualCard!
                                                        .virtualCardFreeze!
                                                    ? 'freeze'
                                                    : 'activate',
                                              )
                                                  .then((value) async {
                                                if (value) {
                                                  int index = data.virtualCards
                                                          ?.indexWhere((element) =>
                                                              element
                                                                  .virtualCardId ==
                                                              data.virtualCard
                                                                  ?.virtualCardId) ??
                                                      0;
                                                  await api
                                                      .getVirtualCards(context);
                                                  data.virtualCard =
                                                      data.virtualCards?[index];
                                                }
                                              });

                                              if (mounted) {
                                                setState(() {
                                                  loading = false;
                                                });
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
            );
          });
    });
  }
}
