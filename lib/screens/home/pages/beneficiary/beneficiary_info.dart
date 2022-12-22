import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/confirm.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/beneficiary.dart';
import 'package:qwid/providers/API/beneficiary.dart';
import 'package:qwid/providers/data/beneficiary.dart';
import 'package:qwid/screens/home/components/summary_info.dart';
import 'package:qwid/screens/home/pages/beneficiary/edit_beneficiary.dart';

class BeneficiaryInfo extends StatefulWidget {
  final Beneficiary beneficiary;
  const BeneficiaryInfo({Key? key, required this.beneficiary})
      : super(key: key);

  @override
  State<BeneficiaryInfo> createState() => _BeneficiaryInfoState();
}

class _BeneficiaryInfoState extends State<BeneficiaryInfo> {
  bool _editMode = false;
  bool loading = false;
  bool deleting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Beneficiary',
        ),
        actions: [
          Consumer<BeneficiaryAPI>(builder: (context, api, chi9ld) {
            return IconButton(
              onPressed: () async {
                bool delete = await confirm(
                  content:
                      'Are you sure you want to remove ${widget.beneficiary.accountName} from your beneficiaries?',
                  context: context,
                  yes: 'Yes, remove',
                  no: 'No, keep it',
                );
                if (delete) {
                  setState(() {
                    deleting = true;
                  });
                  bool success = await api.deleteBeneficiary(
                    context: context,
                    beneficiary: widget.beneficiary,
                  );
                  setState(() {
                    deleting = false;
                  });
                  if (success) {
                    Navigation.pop(context);
                  }
                }
              },
              icon: deleting
                  ? const SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1.2,
                        valueColor:
                            AlwaysStoppedAnimation(CustomColors.primary),
                      ),
                    )
                  : CustomIcon(
                      height: 24,
                      icon: 'delete',
                    ),
            );
          }),
          if (!_editMode)
            IconButton(
              onPressed: () {
                setState(() {
                  _editMode = true;
                });
              },
              icon: CustomIcon(
                height: 24,
                icon: 'edit',
              ),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 44),
        children: [
          if (_editMode)
            EditBeneficiary(
              beneficiary: widget.beneficiary,
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    'Personal information',
                    style: CustomTextStyle(
                      color: CustomColors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SummaryInfo(
                        title: 'BENEFICIARY NAME',
                        info: widget.beneficiary.accountName!,
                      ),
                      const Divider(
                        height: 32,
                      ),
                      SummaryInfo(
                        title: 'STATE',
                        info: widget.beneficiary.state ?? '',
                      ),
                      const Divider(
                        height: 32,
                      ),
                      SummaryInfo(
                        title: 'CITY',
                        info: widget.beneficiary.city ?? '',
                      ),
                      const Divider(
                        height: 32,
                      ),
                      SummaryInfo(
                        title: 'ADDRESS',
                        info: widget.beneficiary.address ?? '',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    'Account information',
                    style: CustomTextStyle(
                      color: CustomColors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SummaryInfo(
                        title: 'COUNTRY',
                        info: widget.beneficiary.country ?? '',
                      ),
                      const Divider(
                        height: 32,
                      ),
                      SummaryInfo(
                        title: 'CURRENCY',
                        info: widget.beneficiary.cur ?? '',
                      ),
                      const Divider(
                        height: 32,
                      ),
                      SummaryInfo(
                        title: 'BANK',
                        info: widget.beneficiary.bankName!,
                      ),
                      const Divider(
                        height: 32,
                      ),
                      SummaryInfo(
                        title: 'IBAN',
                        info: widget.beneficiary.accountNo!,
                        copyable: true,
                      ),
                      // if ((widget.beneficiary.swift ?? '').isNotEmpty)
                      const Divider(
                        height: 32,
                      ),
                      // if ((widget.beneficiary.swift ?? '').isNotEmpty)
                      SummaryInfo(
                        title: 'SWIFT',
                        info: widget.beneficiary.swift ?? '',
                        copyable: true,
                      ),
                      // if ((widget.beneficiary.bankRoutingNo ?? '').isNotEmpty)
                      const Divider(
                        height: 32,
                      ),
                      // if ((widget.beneficiary.bankRoutingNo ?? '').isNotEmpty)
                      SummaryInfo(
                        title: 'ROUTING NO.',
                        info: widget.beneficiary.bankRoutingNo!,
                        copyable: true,
                      ),
                      // if ((widget.beneficiary.bankSortCode ?? '').isNotEmpty)
                      const Divider(
                        height: 32,
                      ),
                      // if ((widget.beneficiary.bankSortCode ?? '').isNotEmpty)
                      SummaryInfo(
                        title: 'SORT CODE',
                        info: widget.beneficiary.bankSortCode!,
                        copyable: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (_editMode)
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Consumer2<BeneficiaryData, BeneficiaryAPI>(
                    builder: (context, data, api, chi9ld) {
                  return CustomButton(
                    text: 'Save',
                    onPressed: () async {
                      if (data.formKey.currentState?.validate() ?? false) {
                        setState(() {
                          loading = true;
                        });
                        await api
                            .updateBeneficiary(
                          beneficiary: widget.beneficiary,
                          context: context,
                        )
                            .then((value) {
                          setState(() {
                            loading = false;
                          });
                          if (value) {
                            setState(() {
                              _editMode = false;
                            });
                          }
                        });
                      }
                    },
                  );
                }),
              ],
            ),
        ],
      ),
    );
  }
}
