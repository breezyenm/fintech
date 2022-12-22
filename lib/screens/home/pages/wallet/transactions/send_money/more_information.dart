import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/bottom_sheets/method_sheet.dart';
import 'package:qwid/models/beneficiary.dart';
import 'package:qwid/models/charge.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/info_card.dart';
import 'package:qwid/screens/home/pages/wallet/transactions/send_money/summary.dart';

class MoreInformation extends StatefulWidget {
  final Beneficiary beneficiary;
  const MoreInformation({Key? key, required this.beneficiary})
      : super(key: key);

  @override
  State<MoreInformation> createState() => _MoreInformationState();
}

class _MoreInformationState extends State<MoreInformation> {
  Charge? charge;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<VTNData>(context, listen: false).clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send money',
        ),
      ),
      body: Consumer4<WalletData, VTNData, VTNAPI, WalletAPI>(
          builder: (context, data, vtnData, vtn, api, chi9ld) {
        return FutureBuilder<Charge?>(
            future: api.getCharge(
              cont: context,
              from: data.wallet!.cur!,
              to: widget.beneficiary.cur!,
              transType: '3',
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                charge = snapshot.data;
              }
              return Form(
                key: formKey,
                child: ListView(
                  children: [
                    InfoCard(
                      title: 'YOU ARE SENDING',
                      info:
                          '${data.amount.text} ${data.wallet?.cur ?? data.fromCur}',
                      subInfo:
                          'BALANCE: ${data.wallet?.balance?.toStringAsFixed(2) ?? 0} ${data.wallet?.cur}',
                      // action: () {},
                      // actionText: 'EDIT',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InfoCard(
                      title: 'FEE',
                      info:
                          '${((int.tryParse(data.amount.text) ?? 0) * double.parse(charge?.fee ?? '0')).toStringAsFixed(2)} ${data.wallet?.cur ?? data.fromCur}',
                      subWidget:
                          snapshot.connectionState == ConnectionState.done ||
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
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 1.2,
                                        valueColor: AlwaysStoppedAnimation(
                                          CustomColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InfoCard(
                      title: 'BENEFICIARY',
                      info: widget.beneficiary.accountName!,
                      // action: () {},
                      // actionText: 'CHANGE',
                    ),
                    InfoCard(
                      title: 'WILL RECEIVE',
                      info:
                          '${(int.tryParse(data.amount.text) ?? 0) * (charge?.rate ?? 1)} ${widget.beneficiary.cur}',
                    ),
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
                            'More information',
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
                            'Fill the form below to continue',
                            style: CustomTextStyle(
                              color: CustomColors.text.withOpacity(0.5),
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
                    Container(
                      decoration: BoxDecoration(
                        color: CustomColors.white,
                        border: Border.all(
                          color: CustomColors.stroke,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelledDropdown(
                            hint: 'Source of funds',
                            label: 'SOURCE OF FUNDS',
                            items: vtnData.sources
                                .map((e) => e.name ?? '')
                                .toList(),
                            onChanged: (value) {
                              vtnData.source = vtnData.sources.firstWhere(
                                  (element) => element.name == value);
                            },
                            value: vtnData.source?.name,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          LabelledDropdown(
                            hint: 'Purpose of Remittance',
                            label: 'PURPOSE OF REMITTANCE',
                            items: vtnData.purposes
                                .map((e) => e.name ?? '')
                                .toList(),
                            onChanged: (value) {
                              vtnData.purpose = vtnData.purposes.firstWhere(
                                  (element) => element.name == value);
                            },
                            value: vtnData.purpose?.name,
                          ),
                          // FutureBuilder(
                          //   future: vtnData.sources.isNotEmpty
                          //       ? null
                          //       : vtn.getSources(context),
                          //   builder: (context, snapshot) {
                          //     return LabelledDropdown(
                          //       hint: 'Select Source of funds',
                          //       label: 'SOURCE OF FUNDS',
                          //       icon: snapshot.connectionState ==
                          //                   ConnectionState.done ||
                          //               vtnData.sources.isNotEmpty
                          //           ? null
                          //           : const SizedBox(
                          //               height: 24,
                          //               width: 24,
                          //               child: CircularProgressIndicator.adaptive(
                          //                 strokeWidth: 1.2,
                          //                 valueColor: AlwaysStoppedAnimation(
                          //                     CustomColors.primary),
                          //               ),
                          //             ),
                          //       items: vtnData.sources
                          //           .map((e) => e.name ?? '')
                          //           .toList(),
                          //       onChanged: (value) {
                          //         vtnData.source = vtnData.sources.firstWhere(
                          //             (element) => element.name == value);
                          //       },
                          //       value: vtnData.source?.name,
                          //     );
                          //   },
                          // ),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // Text(
                          //   'UPLOAD SUPPORTING DOCUMENTS',
                          //   style: CustomTextStyle(
                          //     fontSize: 11,
                          //     fontWeight: FontWeight.w500,
                          //     color: CustomColors.labelText.withOpacity(0.5),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 8,
                          // ),
                          // DottedBorder(
                          // dashPattern: [8, 8],
                          // borderType: BorderType.RRect,
                          //   radius: const Radius.circular(8),
                          //   color: CustomColors.darkPrimary,
                          //   child: Container(
                          //     alignment: Alignment.center,
                          //     height: MediaQuery.of(context).size.width - 64,
                          //     width: MediaQuery.of(context).size.width - 64,
                          //     decoration: BoxDecoration(
                          //       color: CustomColors.white,
                          //       borderRadius: BorderRadius.circular(8),
                          //     ),
                          //     child: CustomIcon(
                          //       height: 24,
                          //       icon: 'upload',
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // FutureBuilder(
                          //   future: vtnData.purposes.isNotEmpty
                          //       ? null
                          //       : vtn.getPurpose(context),
                          //   builder: (context, snapshot) {
                          //     return LabelledDropdown(
                          //       hint: 'Select Purpose of Remittance',
                          //       label: 'PURPOSE OF REMITTANCE',
                          //       icon: snapshot.connectionState ==
                          //                   ConnectionState.done ||
                          //               vtnData.purposes.isNotEmpty
                          //           ? null
                          //           : const SizedBox(
                          //               height: 24,
                          //               width: 24,
                          //               child: CircularProgressIndicator.adaptive(
                          //                 strokeWidth: 1.2,
                          //                 valueColor: AlwaysStoppedAnimation(
                          //                     CustomColors.primary),
                          //               ),
                          //             ),
                          //       items: vtnData.purposes
                          //           .map((e) => e.name ?? '')
                          //           .toList(),
                          //       onChanged: (value) {
                          //         vtnData.purpose = vtnData.purposes.firstWhere(
                          //             (element) => element.name == value);
                          //       },
                          //       value: vtnData.source?.name,
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: CustomButton(
                        text: 'Checkout',
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => MethodSheet(
                                context: context,
                                summaryPage: SendSummary(
                                  beneficiary: widget.beneficiary,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              );
            });
      }),
    );
  }
}
