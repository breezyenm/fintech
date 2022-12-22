// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
// import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/labelled_text_field.dart';
import 'package:qwid/models/user.dart';
import 'package:qwid/providers/API/vtn.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/vtn.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/info_card.dart';
import 'package:qwid/screens/home/pages/wallet/transactions/send_money/summary.dart';

class InternalTransfer extends StatefulWidget {
  const InternalTransfer({Key? key}) : super(key: key);

  @override
  State<InternalTransfer> createState() => _InternalTransferState();
}

class _InternalTransferState extends State<InternalTransfer> {
  User? _account;
  bool loading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Provider.of<WalletData>(context, listen: false).beneficiaryEmail.clear();
    Provider.of<VTNData>(context, listen: false).clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<WalletData, VTNData, VTNAPI>(
        builder: (context, data, vtnData, vtn, chi9ld) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Send money',
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              InfoCard(
                title: 'YOU ARE SENDING',
                info: '${data.amount.text} ${data.wallet?.cur ?? data.fromCur}',
                subInfo:
                    'BALANCE: ${data.wallet?.balance?.toStringAsFixed(2) ?? 0} ${data.wallet?.cur}',
                // action: () {},
                // actionText: 'EDIT',
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
                      'Beneficiary information',
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
                    LabelledTextField(
                      hint: 'email@example.com',
                      label: 'SEND TO',
                      controller: data.beneficiaryEmail,
                      onChanged: (value) {
                        setState(() {
                          _account = null;
                        });
                      },
                    ),
                    if (_account != null)
                      const SizedBox(
                        height: 8,
                      ),
                    if (_account != null)
                      Text(
                        '${_account?.firstName} ${_account?.lastName}',
                        style: const CustomTextStyle(
                          color: CustomColors.darkPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    LabelledDropdown(
                      hint: 'Select Currency',
                      value: data.beneficiaryCur,
                      items: data.wallets
                          .map((e) => e.cur!.toUpperCase())
                          .toList(),
                      onChanged: (value) {
                        data.beneficiaryCur = value;
                      },
                      label: 'CURRENCY',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (_account != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  ],
                ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Consumer<WalletAPI>(builder: (context, api, chi9ld) {
                  return CustomButton(
                    text: loading
                        ? 'loading'
                        : _account == null
                            ? 'Verify account'
                            : 'Transfer',
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        if (_account == null) {
                          setState(() {
                            loading = true;
                          });
                          List<User> users = await api.searchUser(
                            data.beneficiaryEmail.text,
                            context,
                          );
                          debugPrint(users.toString());
                          setState(() {
                            loading = false;
                            if (users.isNotEmpty) {
                              _account = users.first;
                            }
                          });
                        } else {
                          Navigation.push(
                            SendSummary(
                              internalUser: _account,
                            ),
                            context,
                          );
                        }
                      }
                    },
                  );
                }),
              )
            ],
          ),
        ),
      );
    });
  }
}
