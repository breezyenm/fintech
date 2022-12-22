import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/bank.dart';
import 'package:qwid/models/charge.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/summary_info.dart';
import 'package:qwid/screens/home/pages/wallet/transactions/top_up/payment.dart';

class TopupSummary extends StatefulWidget {
  const TopupSummary({Key? key}) : super(key: key);

  @override
  State<TopupSummary> createState() => _TopupSummaryState();
}

class _TopupSummaryState extends State<TopupSummary> {
  Charge? charge;
  List<Bank> banks = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletData>(builder: (context, data, chi9ld) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Summary',
          ),
        ),
        body: Padding(
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
                      title: 'YOU ARE DEPOSITING',
                      info:
                          '${data.amount.text} ${data.wallet?.cur ?? data.fromCur}',
                      // subInfo: 'EDIT',
                      // subInfoFunction: () async {
                      //   await showModalBottomSheet(
                      // isScrollControlled: true,
                      //     context: context,
                      //     builder: (context) => TopupSheet(
                      //       context: context,
                      //       onPressed: () {
                      //         Navigation.pop(context);
                      //       },
                      //     ),
                      //   );
                      //   setState(() {
                      //     if (data.amount.text.isEmpty) {
                      //       data.amount.text = '0';
                      //     }
                      //   });
                      // },
                    ),
                    const Divider(
                      height: 32,
                    ),
                    Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                      return FutureBuilder<Charge?>(
                          future: charge != null
                              ? null
                              : api.getCharge(
                                  cont: context,
                                  from: (data.wallet?.cur ?? data.fromCur)!,
                                  to: (data.wallet?.cur ?? data.fromCur)!,
                                  transType: '1',
                                ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              charge = snapshot.data;
                            }
                            return SummaryInfo(
                              title: 'FEE',
                              info:
                                  '${((int.tryParse(data.amount.text) ?? 0) * double.parse(charge?.fee ?? '0')).toStringAsFixed(2)} ${data.wallet?.cur ?? data.fromCur}',
                              infoWidget: charge != null
                                  ? null
                                  : snapshot.connectionState ==
                                          ConnectionState.done
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
                                      : const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              height: 12,
                                              width: 12,
                                              child: CircularProgressIndicator
                                                  .adaptive(
                                                strokeWidth: 1.2,
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                  CustomColors.primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                              // subInfo: 'DETAILS',
                              // subInfoFunction: () {},
                            );
                          });
                    }),
                    const Divider(
                      height: 32,
                    ),
                    const SummaryInfo(
                      title: 'PAYMENT METHOD',
                      info: 'BANK TRANSFER',
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   height: 16,
              // ),
              // Consumer<WalletAPI>(builder: (context, api, chi9ld) {
              //   return FutureBuilder<List<Bank>>(
              //       future: api.getAdminBank(data.wallet?.cur, context),
              //       builder: (context, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.done) {
              //           banks = snapshot.data ?? [];
              //         }
              //         return snapshot.connectionState != ConnectionState.done &&
              //                 banks.isEmpty
              //             ? const CircularProgressIndicator.adaptive(
              //                 valueColor:
              //                     AlwaysStoppedAnimation(CustomColors.primary),
              //               )
              //             : Column(
              //                 crossAxisAlignment: CrossAxisAlignment.stretch,
              //                 children: [
              //                   if (banks.isEmpty &&
              //                       snapshot.connectionState ==
              //                           ConnectionState.done)
              //                     Column(
              //                       children: [
              //                         const Text(
              //                           'Bank Unavailable',
              //                           style: CustomTextStyle(
              //                             color: CustomColors.black,
              //                             fontFamily: 'Montserrat',
              //                             fontSize: 18,
              //                             fontWeight: FontWeight.w500,
              //                           ),
              //                         ),
              //                         const SizedBox(
              //                           height: 8,
              //                         ),
              //                         Text(
              //                           'Banks are unavailable for this currency, please choose another.',
              //                           style: CustomTextStyle(
              //                             color: CustomColors.black
              //                                 .withOpacity(0.5),
              //                             fontFamily: 'Montserrat',
              //                             fontSize: 12,
              //                             fontWeight: FontWeight.w500,
              //                           ),
              //                           textAlign: TextAlign.center,
              //                         ),
              //                       ],
              //                     ),
              //                   if (banks.isNotEmpty)
              //                     Container(
              //                       decoration: BoxDecoration(
              //                         color: CustomColors.white,
              //                         border: Border.all(
              //                           color: CustomColors.stroke,
              //                         ),
              //                         borderRadius: BorderRadius.circular(8),
              //                       ),
              //                       padding: const EdgeInsets.symmetric(
              //                         vertical: 16,
              //                       ),
              //                       child: Column(
              //                         children: [
              //                           Column(
              //                             children: [
              //                               SummaryInfo(
              //                                 title: 'ACCOUNT NAME',
              //                                 info:
              //                                     banks.first.accountName ?? '',
              //                               ),
              //                               const Divider(
              //                                 height: 32,
              //                               ),
              //                               SummaryInfo(
              //                                 title: 'IBAN',
              //                                 info: banks.first.accountNo ?? '',
              //                                 copyable: true,
              //                               ),
              //                               const Divider(
              //                                 height: 32,
              //                               ),
              //                               SummaryInfo(
              //                                 title: 'BANK',
              //                                 info: banks.first.bankName ?? '',
              //                               ),
              //                               const Divider(
              //                                 height: 32,
              //                               ),
              //                               // SummaryInfo(
              //                               //   title: 'SWIFT',
              //                               //   info: banks.first.swift ?? '',
              //                               //   copyable: true,
              //                               // ),
              //                               // const Divider(
              //                               //   height: 32,
              //                               // ),
              //                               SummaryInfo(
              //                                 title: 'ROUTING NO.',
              //                                 info: banks.first.routingNo ?? '',
              //                                 copyable: true,
              //                               ),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                 ],
              //               );
              //       });
              // }),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                text: 'Make payment',
                onPressed: () {
                  Navigation.push(
                    TopupPayment(
                      charge: charge!,
                    ),
                    context,
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
