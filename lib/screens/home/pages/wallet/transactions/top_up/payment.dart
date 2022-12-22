import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/checkbox.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/charge.dart';
import 'package:qwid/models/virtual_account.dart';
import 'package:qwid/popups/general/successful_popup.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/brain/account_provider.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/info_card.dart';
import 'package:qwid/screens/home/components/note.dart';
import 'package:qwid/screens/home/components/summary_info.dart';

class TopupPayment extends StatefulWidget {
  final Charge charge;
  const TopupPayment({Key? key, required this.charge}) : super(key: key);

  @override
  State<TopupPayment> createState() => _TopupPaymentState();
}

class _TopupPaymentState extends State<TopupPayment> {
  bool _paid = false;
  bool loading = false;
  String? transID;
  @override
  Widget build(BuildContext context) {
    return Consumer2<WalletData, AccountProvider>(
        builder: (context, data, pro, chi9ld) {
      VirtualAccount? account;
      List<VirtualAccount> accounts = (pro.virtualAccounts ?? [])
          .where(
            (element) => element.cur == data.wallet?.cur,
          )
          .toList();
      if (accounts.isNotEmpty) {
        account = accounts[0];
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Payment',
          ),
        ),
        body: account == null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bank Unavailable',
                      style: CustomTextStyle(
                        color: CustomColors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Banks are unavailable for this currency, please choose another.',
                      style: CustomTextStyle(
                        color: CustomColors.black.withOpacity(0.5),
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 44),
                children: [
                  InfoCard(
                    title: 'YOU ARE SENDING',
                    info:
                        '${((int.tryParse(data.amount.text) ?? 0) + (int.tryParse(data.amount.text) ?? 0) * double.parse(widget.charge.fee ?? '0')).toStringAsFixed(2)} ${data.wallet?.cur ?? data.fromCur}',
                    // subInfo: 'Details',
                    // subInfoFunction: () {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                    return FutureBuilder<String?>(
                        future: transID != null
                            ? null
                            : api.getTransactionId(
                                context: context,
                              ),
                        builder: (context, snapshot) {
                          transID = snapshot.data;
                          return GestureDetector(
                            onTap: () {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  transID == null) {
                                setState(() {});
                              }
                            },
                            child: InfoCard(
                              title: 'TRANSACTION ID',
                              infoColor: snapshot.connectionState ==
                                          ConnectionState.done &&
                                      transID == null
                                  ? CustomColors.primary
                                  : null,
                              info: snapshot.connectionState ==
                                          ConnectionState.done &&
                                      transID == null
                                  ? 'Tap to reload'
                                  : transID ?? 'fetching...',
                              warning:
                                  'Use as transfer reference or transaction might not be picked',
                              copyable: true,
                            ),
                          );
                        });
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bank Transfer',
                          style: CustomTextStyle(
                            color: CustomColors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'To complete payment, send the above amount to the account below.',
                          style: CustomTextStyle(
                            color: CustomColors.black.withOpacity(0.5),
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Note(),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<AccountProvider>(builder: (context, pro, chi9ld) {
                    return Container(
                      decoration: BoxDecoration(
                        color: CustomColors.white,
                        border: Border.all(
                          color: CustomColors.stroke,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              SummaryInfo(
                                title: 'ACCOUNT NAME',
                                info: account?.accountName ?? '',
                              ),
                              const Divider(
                                height: 32,
                              ),
                              SummaryInfo(
                                title: 'Account number',
                                info: account?.accountNo ?? '',
                                copyable: true,
                              ),
                              const Divider(
                                height: 32,
                              ),
                              SummaryInfo(
                                title: 'BANK',
                                info: account?.bankName ?? '',
                              ),
                              if ((account?.iban ?? '').isNotEmpty)
                                const Divider(
                                  height: 32,
                                ),
                              if ((account?.iban ?? '').isNotEmpty)
                                SummaryInfo(
                                  title: 'IBAN',
                                  info: account?.iban ?? '',
                                  copyable: true,
                                ),
                              if ((account?.swift ?? '').isNotEmpty)
                                const Divider(
                                  height: 32,
                                ),
                              if ((account?.swift ?? '').isNotEmpty)
                                SummaryInfo(
                                  title: 'SWIFT',
                                  info: account?.swift ?? '',
                                  copyable: true,
                                ),
                              if ((account?.routine ?? '').isNotEmpty)
                                const Divider(
                                  height: 32,
                                ),
                              if ((account?.routine ?? '').isNotEmpty)
                                SummaryInfo(
                                  title: 'ROUTING NO.',
                                  info: account?.routine ?? '',
                                  copyable: true,
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: CheckBox(
                      value: _paid,
                      onChanged: (value) {
                        setState(() {
                          _paid = value ?? false;
                        });
                      },
                      title: const Text(
                        'I have made the transfer',
                        style: CustomTextStyle(
                          color: CustomColors.labelText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: CustomButton(
                        text: loading ? 'loading' : 'Confirm payment',
                        onPressed: _paid
                            ? () async {
                                setState(() {
                                  loading = true;
                                });
                                bool success = await api.confirmDeposit(
                                  cur: data.wallet?.cur,
                                  amount: data.amount.text,
                                  context: context,
                                  id: account?.id,
                                  referenceNo: transID,
                                );
                                if (success) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => SuccessfulPopup(
                                      title: 'PAYMENT SUCCESSFUL',
                                      context: context,
                                    ),
                                  );
                                }

                                setState(() {
                                  loading = false;
                                });
                              }
                            : null,
                      ),
                    );
                  }),
                ],
              ),
      );
    });
  }
}
