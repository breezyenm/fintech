import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/bank.dart';
import 'package:qwid/models/charge.dart';
import 'package:qwid/popups/general/successful_popup.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/summary_info.dart';

class WithdrawSummary extends StatefulWidget {
  final Bank bank;
  const WithdrawSummary({Key? key, required this.bank}) : super(key: key);

  @override
  State<WithdrawSummary> createState() => _WithdrawSummaryState();
}

class _WithdrawSummaryState extends State<WithdrawSummary> {
  bool loading = false;
  Charge? charge;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
        ),
      ),
      body: Consumer<WalletData>(builder: (context, data, chi9ld) {
        return Consumer<WalletAPI>(builder: (context, api, chi9ld) {
          return FutureBuilder<Charge?>(
              future: api.getCharge(
                cont: context,
                from: (data.wallet?.cur ?? data.fromCur)!,
                to: (data.wallet?.cur ?? data.fromCur)!,
                transType: '2',
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  charge = snapshot.data;
                }
                return ListView(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 44),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SummaryInfo(
                            title: 'YOU ARE WITHDRAWING',
                            info:
                                '${(int.tryParse(data.amount.text) ?? 0)} ${data.wallet?.cur ?? data.fromCur}',
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
                            title: 'FEE',
                            info:
                                '${(int.tryParse(data.amount.text) ?? 0) * double.parse(charge?.fee ?? '0')}',
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
                            // subInfo: 'DETAILS',
                            // subInfoFunction: () {},
                          ),
                          const Divider(
                            height: 32,
                          ),
                          SummaryInfo(
                            title: 'BANK ACCOUNT',
                            info: widget.bank.accountNo ?? '',
                            subInfo: 'CHANGE',
                            subInfoFunction: () {
                              Navigation.pop(context);
                            },
                            moreDetails: {
                              'BANK NAME': widget.bank.bankName ?? '',
                              'ACCOUNT NAME': widget.bank.accountName ?? '',
                            },
                          ),
                          // const Divider(
                          //   height: 32,
                          // ),
                          // const SummaryInfo(
                          //   title: 'WILL RECEIVE',
                          //   info: '70800 NGN',
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                      return CustomButton(
                        text: loading ? 'loading' : 'Withdraw',
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          bool success = await api.withdraw(
                            data.amount.text,
                            '${(int.tryParse(data.amount.text) ?? 0) * double.parse(charge?.fee ?? '0')}',
                            data.wallet?.cur,
                            context,
                          );
                          if (success) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => SuccessfulPopup(
                                title: 'WITHDRAWAL SUCCESSFUL',
                                context: context,
                              ),
                            );
                          }

                          setState(() {
                            loading = false;
                          });
                        },
                      );
                    }),
                  ],
                );
              });
        });
      }),
    );
  }
}
