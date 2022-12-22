import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/search_dropdown.dart';
import 'package:qwid/assets/dropdown/search_list.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/models/charge.dart';
import 'package:qwid/models/currency.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/pages/wallet/transactions/convert/summary.dart';

class ConvertSheetWidget extends StatefulWidget {
  const ConvertSheetWidget({Key? key}) : super(key: key);

  @override
  State<ConvertSheetWidget> createState() => _ConvertSheetWidgetState();
}

class _ConvertSheetWidgetState extends State<ConvertSheetWidget> {
  bool from = false;
  bool to = false;
  Charge? charge;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    VTNAPI vtnapi = Provider.of<VTNAPI>(context, listen: false);
    vtnapi.getCountries(context);
    WalletData data = Provider.of<WalletData>(context, listen: false);
    data.fromCur = null;
    data.toCur = null;
    // data.fromCur = data.wallets.first.cur;
    // data.toCur = data.wallets.first.cur;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletData>(builder: (context, data, chi9ld) {
      return Form(
        key: _key,
        child: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 44),
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 3,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: CustomColors.labelText.withOpacity(0.25),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Center(
                child: Text(
                  'Convert',
                  style: CustomTextStyle(
                    color: CustomColors.text,
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: Text(
                  'Enter amount and select currencies',
                  style: CustomTextStyle(
                    color: CustomColors.text.withOpacity(0.5),
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Focus(
                                onFocusChange: (focus) {
                                  from = focus;
                                },
                                child: LabelledTextField(
                                  type: TextInputType.number,
                                  onChanged: (value) {
                                    if (from &&
                                        data.fromCur != null &&
                                        data.toCur != null &&
                                        charge != null) {
                                      if (data.fromAmount.text.isEmpty) {
                                        data.toAmount.clear();
                                      }
                                      if (data.fromAmount.text.isNotEmpty) {
                                        data.toAmount.text = (double.parse(
                                                    data.fromAmount.text) *
                                                charge!.rate!)
                                            .toStringAsFixed(2);
                                      }
                                    }
                                  },
                                  label: 'FROM',
                                  controller: data.fromAmount,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Consumer2<VTNAPI, VTNData>(
                                  builder: (context, vtnAPI, vtnData, chi9ld) {
                                return FutureBuilder(
                                    future: vtnData.countries.isNotEmpty
                                        ? null
                                        : vtnAPI.getCountries(context),
                                    builder: (context, snapshot) {
                                      return InkWell(
                                        onTap: () async {
                                          if (vtnData.countries.isNotEmpty) {
                                            data.toAmount.clear();
                                            data.fromCur =
                                                await Navigation.push(
                                              SearchList(
                                                leading: vtnData.countries
                                                    .map((e) =>
                                                        e.abbr?.toLowerCase() ??
                                                        '')
                                                    .toList(),
                                                items: data.wallets
                                                    .map((e) => e.cur)
                                                    .toList(),
                                              ),
                                              context,
                                            );
                                            setState(() {
                                              charge = null;
                                            });
                                          }
                                        },
                                        child: SearchDropdown(
                                          icon: snapshot.connectionState ==
                                                      ConnectionState.done ||
                                                  vtnData.countries.isNotEmpty
                                              ? null
                                              : const SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(
                                                    strokeWidth: 1.2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            CustomColors
                                                                .primary),
                                                  ),
                                                ),
                                          hint: 'Select currency',
                                          label: 'CURRENCY',
                                          leading: data.wallet?.countryCode
                                              ?.toLowerCase(),
                                          text: data.fromCur,
                                        ),
                                      );
                                    });
                              }),
                            ),
                          ],
                        ),
                        if (data.wallets
                            .where((element) => element.cur == data.fromCur)
                            .isNotEmpty)
                          const SizedBox(
                            height: 8,
                          ),
                        if (data.wallets
                            .where((element) => element.cur == data.fromCur)
                            .isNotEmpty)
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
                                        '${data.wallets.firstWhere((element) => element.cur == data.fromCur).balance?.toStringAsFixed(2)} ${data.fromCur}',
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
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Focus(
                                onFocusChange: (value) {
                                  to = value;
                                },
                                child: LabelledTextField(
                                  type: TextInputType.number,
                                  label: 'TO',
                                  controller: data.toAmount,
                                  onChanged: (value) {
                                    if (to &&
                                        data.fromCur != null &&
                                        data.toCur != null &&
                                        charge != null) {
                                      if (data.toAmount.text.isEmpty) {
                                        data.fromAmount.clear();
                                      }
                                      if (data.toAmount.text.isNotEmpty) {
                                        data.fromAmount.text =
                                            (double.parse(data.toAmount.text) /
                                                    charge!.rate!)
                                                .toStringAsFixed(2);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Consumer<VTNData>(
                                  builder: (context, vtnData, chi9ld) {
                                return InkWell(
                                  onTap: () async {
                                    if (vtnData.countries.isNotEmpty) {
                                      data.toAmount.clear();
                                      data.toCur = await Navigation.push(
                                        SearchList(
                                          leading: vtnData.countries
                                              .map((e) =>
                                                  e.abbr?.toLowerCase() ?? '')
                                              .toList(),
                                          items: vtnData.countries
                                              .map((e) => e.currencies!)
                                              .toList()
                                              .reduce((value, element) {
                                                List<Currency> val = value;
                                                val.addAll(element);
                                                return val;
                                              })
                                              .map((e) => e.cur!)
                                              .toSet()
                                              .toList(),
                                        ),
                                        context,
                                      );
                                      setState(() {
                                        charge = null;
                                      });
                                    }
                                  },
                                  child: SearchDropdown(
                                    icon: vtnData.countries.isNotEmpty
                                        ? null
                                        : const SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator
                                                .adaptive(
                                              strokeWidth: 1.2,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      CustomColors.primary),
                                            ),
                                          ),
                                    hint: 'Select currency',
                                    label: 'CURRENCY',
                                    leading: data.toWallet?.countryCode
                                        ?.toLowerCase(),
                                    text: data.toCur,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        if (data.wallets
                            .where((element) => element.cur == data.toCur)
                            .isNotEmpty)
                          const SizedBox(
                            height: 8,
                          ),
                        if (data.wallets
                            .where((element) => element.cur == data.toCur)
                            .isNotEmpty)
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
                                        '${data.wallets.firstWhere((element) => element.cur == data.toCur).balance?.toStringAsFixed(2)} ${data.toCur}',
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
                    if (data.toCur != null && data.fromCur != null)
                      const SizedBox(
                        height: 16,
                      ),
                    if (data.toCur != null && data.fromCur != null)
                      Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                        return FutureBuilder<Charge?>(
                            future: charge != null
                                ? null
                                : api.getCharge(
                                    cont: context,
                                    from: data.fromCur!,
                                    to: data.toCur!,
                                  ),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                charge = snapshot.data;
                                if (data.fromCur != null &&
                                    data.toCur != null) {
                                  if (data.fromAmount.text.isNotEmpty) {
                                    Future.delayed(
                                      const Duration(
                                        seconds: 1,
                                      ),
                                      () {
                                        data.toAmount.text = (double.parse(
                                                    data.fromAmount.text) *
                                                charge!.rate!)
                                            .toStringAsFixed(2);
                                      },
                                    );
                                  }
                                }
                              }
                              return InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  if (charge != null) {
                                    String cur = data.fromCur!;
                                    setState(() {
                                      charge = null;
                                      data.fromCur = data.toCur;
                                      data.fromAmount.text = data.toAmount.text;
                                      data.toAmount.clear();
                                      data.toCur = cur;
                                    });
                                    // Wallet? wallet = data.wallet;
                                    // data.wallet = data.toWallet;
                                    // data.toWallet = null;
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: charge == null
                                        ? Colors.transparent
                                        : CustomColors.background,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: charge == null
                                      ? snapshot.connectionState !=
                                              ConnectionState.done
                                          ? const SizedBox(
                                              width: 24,
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                                strokeWidth: 1.2,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                  CustomColors.white,
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                                  const Text(
                                                    'Error',
                                                    style: CustomTextStyle(
                                                      color: CustomColors.text,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "We couldn't fetch the conversion rate, try again",
                                                    style: CustomTextStyle(
                                                      color: CustomColors.text
                                                          .withOpacity(0.5),
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  CustomButton(
                                                    text: 'Reload',
                                                    onPressed: () {
                                                      setState(() {});
                                                    },
                                                  )
                                                ],
                                              ),
                                            )
                                      : Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '1 ${data.fromCur}',
                                                    style:
                                                        const CustomTextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: CustomColors
                                                          .labelText,
                                                    ),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                CustomIcon(
                                                  height: 24,
                                                  icon: 'switch',
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${charge?.rate?.toStringAsFixed(2)} ${data.toCur}',
                                                    style:
                                                        const CustomTextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: CustomColors
                                                          .labelText,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'Tap to switch',
                                              style: CustomTextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: CustomColors.labelText
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              );
                            });
                      })
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              CustomButton(
                text: 'Convert',
                onPressed: (data.wallets
                            .where((element) => element.cur == data.toCur)
                            .isNotEmpty &&
                        data.wallets
                            .where((element) => element.cur == data.fromCur)
                            .isNotEmpty)
                    ? () {
                        if (_key.currentState?.validate() ?? false) {
                          Navigation.push(
                            const CONVERTSummary(),
                            context,
                          );
                        }
                      }
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}
