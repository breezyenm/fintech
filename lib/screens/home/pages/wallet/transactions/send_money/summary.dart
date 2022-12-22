import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/checkbox.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/bank.dart';
import 'package:qwid/models/beneficiary.dart';
import 'package:qwid/models/charge.dart';
import 'package:qwid/models/user.dart';
import 'package:qwid/popups/general/successful_popup.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/info_card.dart';
import 'package:qwid/screens/home/components/note.dart';
import 'package:qwid/screens/home/components/summary_info.dart';

class SendSummary extends StatefulWidget {
  final Beneficiary? beneficiary;
  final User? internalUser;
  const SendSummary({Key? key, this.internalUser, this.beneficiary})
      : super(key: key);

  @override
  State<SendSummary> createState() => _SendSummaryState();
}

class _SendSummaryState extends State<SendSummary> {
  Charge? charge;
  bool _paid = false;
  bool loading = false;
  List<Bank> banks = [];
  String? transID;
  @override
  Widget build(BuildContext context) {
    return Consumer3<WalletData, VTNData, VTNAPI>(
        builder: (context, data, vtnData, vtn, chi9ld) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Summary',
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 44),
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
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                return FutureBuilder<Charge?>(
                    future: charge != null
                        ? null
                        : api.getCharge(
                            cont: context,
                            from: (data.wallet?.cur ?? data.fromCur)!,
                            to: (data.beneficiaryCur ??
                                widget.beneficiary?.cur!)!,
                            transType: widget.beneficiary == null ? '4' : '3',
                          ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        charge = snapshot.data;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SummaryInfo(
                            title: 'YOU ARE SENDING',
                            info:
                                '${((int.tryParse(data.amount.text) ?? 0) + ((int.tryParse(data.amount.text) ?? 0) * double.parse(charge?.fee ?? '0'))).toStringAsFixed(2)} ${data.wallet?.cur ?? data.fromCur}',
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
                                '${((int.tryParse(data.amount.text) ?? 0) * double.parse(charge?.fee ?? '0')).toStringAsFixed(2)} ${data.wallet?.cur ?? data.fromCur}',
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
                            title: 'RECIPIENT',
                            info: widget.internalUser != null
                                ? '${widget.internalUser?.firstName} ${widget.internalUser?.lastName}'
                                : widget.beneficiary?.accountName ?? '',
                            // subInfo: 'CHANGE',
                            // subInfoFunction: () {
                            //   Navigation.pop(context);
                            // },
                            moreDetails: widget.internalUser != null
                                ? {
                                    'EMAIL ADDRESS':
                                        widget.internalUser?.email ?? '',
                                  }
                                : {
                                    'RECIPIENT BANK':
                                        widget.beneficiary?.bankName ?? '',
                                    'RECIPIENT IBAN':
                                        widget.beneficiary?.accountNo ?? '',
                                    'SWIFT': widget.beneficiary?.swift ?? '',
                                    'ROUTING NUMBER':
                                        widget.beneficiary?.bankRoutingNo ?? '',
                                  },
                          ),
                          const Divider(
                            height: 32,
                          ),
                          SummaryInfo(
                            title: 'WILL RECEIVE',
                            info:
                                '${((int.tryParse(data.amount.text) ?? 0) * (charge?.rate ?? 1)).toStringAsFixed(2)} ${data.beneficiaryCur ?? widget.beneficiary?.cur}',
                          ),
                          // if (!internal)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                height: 32,
                              ),
                              SummaryInfo(
                                title: 'SOURCE OF FUNDS',
                                info: vtnData.source!.name!,
                              ),
                              // const Divider(
                              //   height: 32,
                              // ),
                              // SummaryInfo(
                              //   title: 'SUPPORTING DOCUMENTS',
                              //   info: '',
                              //   infoWidget: Container(
                              //     height: 96,
                              //     width: 64,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(5),
                              //       color: CustomColors.stroke,
                              //     ),
                              //   ),
                              // ),
                              const Divider(
                                height: 32,
                              ),
                              SummaryInfo(
                                title: 'PURPOSE OF REMITTANCE',
                                info: vtnData.purpose!.name!,
                              ),
                              const Divider(
                                height: 32,
                              ),
                              SummaryInfo(
                                title: 'PAYMENT METHOD',
                                info: data.method == 1 ||
                                        widget.internalUser != null
                                    ? 'WALLET'
                                    : 'BANK TRANSFER',
                              ),
                            ],
                          ),
                        ],
                      );
                    });
              }),
            ),
            const SizedBox(
              height: 16,
            ),
            if (widget.beneficiary != null && data.method == 3)
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
            if (widget.beneficiary != null && data.method == 3)
              const SizedBox(
                height: 16,
              ),
            if (widget.beneficiary != null && data.method == 3)
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
            if (widget.beneficiary != null && data.method == 3)
              const SizedBox(
                height: 16,
              ),
            if (widget.beneficiary != null && data.method == 3) const Note(),
            if (widget.beneficiary != null && data.method == 3)
              const SizedBox(
                height: 16,
              ),
            if (widget.beneficiary != null && data.method == 3)
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
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                  return FutureBuilder<List<Bank>>(
                      future: banks.isNotEmpty
                          ? null
                          : api.getAdminBank(data.wallet?.cur, context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          banks = snapshot.data ?? [];
                        }
                        return snapshot.connectionState !=
                                    ConnectionState.done &&
                                banks.isEmpty
                            ? const CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation(
                                    CustomColors.primary),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (banks.isEmpty &&
                                      snapshot.connectionState ==
                                          ConnectionState.done)
                                    Column(
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
                                            color: CustomColors.black
                                                .withOpacity(0.5),
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  if (banks.isNotEmpty)
                                    Column(
                                      children: [
                                        SummaryInfo(
                                          title: 'ACCOUNT NAME',
                                          info: banks.first.accountName ?? '',
                                        ),
                                        const Divider(
                                          height: 32,
                                        ),
                                        SummaryInfo(
                                          title: 'IBAN',
                                          info: banks.first.accountNo ?? '',
                                          copyable: true,
                                        ),
                                        const Divider(
                                          height: 32,
                                        ),
                                        SummaryInfo(
                                          title: 'BANK',
                                          info: banks.first.bankName ?? '',
                                        ),
                                        const Divider(
                                          height: 32,
                                        ),
                                        // SummaryInfo(
                                        //   title: 'SWIFT',
                                        //   info: banks.first.swift ?? '',
                                        //   copyable: true,
                                        // ),
                                        // const Divider(
                                        //   height: 32,
                                        // ),
                                        if ((banks.first.routingNo ?? '')
                                            .isNotEmpty)
                                          SummaryInfo(
                                            title: 'ROUTING NO.',
                                            info: banks.first.routingNo ?? '',
                                            copyable: true,
                                          ),
                                      ],
                                    ),
                                ],
                              );
                      });
                }),
              ),
            if (data.method == 3)
              const SizedBox(
                height: 16,
              ),
            if (data.method == 3)
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
            // if (charge != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                return CustomButton(
                  text: loading ? 'loading' : 'Confirm payment',
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    if (widget.internalUser != null) {
                      bool success = await api.transfer(
                        data.amount.text,
                        '${(int.tryParse(data.amount.text) ?? 0) * (charge?.rate ?? 0)}',
                        '${double.parse(charge?.fee ?? '0')}',
                        widget.internalUser!.uid!,
                        context,
                      );
                      if (success) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => SuccessfulPopup(
                            title: 'TRANSFER SUCCESSFUL',
                            context: context,
                          ),
                        );
                      }
                    }
                    if (widget.beneficiary != null &&
                        (data.method == 1 || _paid)) {
                      bool success = await api.sendMoney(
                        data.wallet?.cur,
                        widget.beneficiary!.cur,
                        data.amount.text,
                        ((int.tryParse(data.amount.text) ?? 0) *
                                (charge?.rate ?? 1))
                            .toString(),
                        ((int.tryParse(data.amount.text) ?? 0) *
                            double.parse(charge?.fee ?? '0')),
                        widget.beneficiary!.id!,
                        context,
                        data.method!,
                        bankId: data.method == 3 ? banks.first.id : null,
                        referenceNo: transID,
                      );
                      if (success) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => SuccessfulPopup(
                            title: 'TRANSFER SUCCESSFUL',
                            context: context,
                          ),
                        );
                      }
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
