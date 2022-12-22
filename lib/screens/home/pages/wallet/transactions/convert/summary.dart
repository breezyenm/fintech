import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/charge.dart';
import 'package:qwid/popups/general/successful_popup.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/balance_card.dart';
import 'package:qwid/screens/home/components/summary_info.dart';

class CONVERTSummary extends StatefulWidget {
  const CONVERTSummary({Key? key}) : super(key: key);

  @override
  State<CONVERTSummary> createState() => _CONVERTSummaryState();
}

class _CONVERTSummaryState extends State<CONVERTSummary> {
  Charge? charge;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
        ),
      ),
      body: Consumer2<WalletData, WalletAPI>(
          builder: (context, data, api, chi9ld) {
        return FutureBuilder<Charge?>(
            future: charge != null
                ? null
                : api.getCharge(
                    cont: context,
                    from: (data.fromCur)!,
                    to: (data.toCur)!,
                    transType: '6',
                  ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                charge = snapshot.data;
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 44),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.white,
                        border: Border.all(
                          color: CustomColors.stroke,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          SummaryInfo(
                            title: 'YOU ARE CONVERTING',
                            info: '${data.fromAmount.text} ${data.fromCur}',
                            // subInfo: 'EDIT',
                            // subInfoFunction: () {
                            //   showModalBottomSheet(
                            // isScrollControlled: true,
                            //     context: context,
                            //     builder: (context) => TopupSheet(
                            //       context: context,
                            //       onPressed: () {
                            //         Navigation.pop(context);
                            //       },
                            //     ),
                            //   );
                            // },
                          ),
                          const Divider(
                            height: 32,
                          ),
                          SummaryInfo(
                            title: 'TO',
                            info: charge == null
                                ? ''
                                : '${data.toAmount.text} ${data.toCur}',
                            // subInfo: 'DETAILS',
                            // subInfoFunction: () {},
                          ),
                          const Divider(
                            height: 32,
                          ),
                          SummaryInfo(
                            title: 'FEE',
                            infoWidget: snapshot.connectionState ==
                                        ConnectionState.done ||
                                    charge != null
                                ? charge == null
                                    ? InkWell(
                                        onTap: () async {
                                          setState(() {});
                                        },
                                        child: const Text(
                                          'Reload',
                                          style: CustomTextStyle(
                                            color: CustomColors.primary,
                                          ),
                                        ),
                                      )
                                    : null
                                : const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 12,
                                        width: 12,
                                        child:
                                            CircularProgressIndicator.adaptive(
                                          strokeWidth: 1.2,
                                          valueColor: AlwaysStoppedAnimation(
                                            CustomColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            info:
                                '${(int.tryParse(data.fromAmount.text) ?? 0) * double.parse(charge?.fee ?? '0')} ${data.fromCur}',
                            // subInfo: 'DETAILS',
                            // subInfoFunction: () {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomButton(
                      text: loading ? 'loading' : 'Convert',
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        bool success = await api.convert(
                          data.fromAmount.text,
                          data.toAmount.text,
                          '${(int.tryParse(data.fromAmount.text) ?? 0) * double.parse(charge?.fee ?? '0')}',
                          data.wallets
                              .firstWhere(
                                  (element) => element.cur == data.fromCur)
                              .cur!,
                          data.wallets
                              .firstWhere(
                                  (element) => element.cur == data.toCur)
                              .cur!,
                          context,
                        );
                        if (success) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => SuccessfulPopup(
                              title: 'CONVERSION SUCCESSFUL',
                              context: context,
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    'NEW BALANCE',
                                    style: CustomTextStyle(
                                      color: CustomColors.labelText
                                          .withOpacity(0.5),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  BalanceCard(
                                    currency: data.wallets
                                        .firstWhere((element) =>
                                            element.cur == data.fromCur)
                                        .currency!,
                                    balance: data.wallets
                                        .firstWhere((element) =>
                                            element.cur == data.fromCur)
                                        .balance!
                                        .toString(),
                                    difference:
                                        '${data.fromAmount.text} ${data.fromCur}',
                                    differenceType: 'minus',
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  BalanceCard(
                                    currency: data.wallets
                                        .firstWhere((element) =>
                                            element.cur == data.toCur)
                                        .currency!,
                                    balance: data.wallets
                                        .firstWhere((element) =>
                                            element.cur == data.toCur)
                                        .balance!
                                        .toString(),
                                    difference:
                                        '${data.toAmount.text} ${data.toCur}',
                                    differenceType: 'add',
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
