import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/models/card_transaction.dart';
import 'package:qwid/models/transaction.dart';
import 'package:qwid/screens/home/components/summary_info.dart';

class TransactionPage extends StatefulWidget {
  final Transaction? transaction;
  final CardTransaction? cardTransaction;
  const TransactionPage({Key? key, this.transaction, this.cardTransaction})
      : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction details',
        ),
        // actions: [
        //   Consumer<BeneficiaryAPI>(builder: (context, api, chi9ld) {
        //     return IconButton(
        //       onPressed: () async {
        //         bool delete = await confirm(
        //           content:
        //               'Are you sure you want to remove ${widget.beneficiary.accountName} from your beneficiaries?',
        //           context: context,
        //           yes: 'Yes, remove',
        //           no: 'No, keep it',
        //         );
        //         if (delete) {
        //           setState(() {
        //             deleting = true;
        //           });
        //           bool success = await api.deleteBeneficiary(
        //             context: context,
        //             beneficiary: widget.beneficiary,
        //           );
        //           setState(() {
        //             deleting = false;
        //           });
        //           if (success) {
        //             Navigation.pop(context);
        //           }
        //         }
        //       },
        //       icon: deleting
        //           ? const SizedBox(
        //               height: 12,
        //               width: 12,
        //               child: CircularProgressIndicator.adaptive(
        //                 strokeWidth: 1.2,
        //                 valueColor:
        //                     AlwaysStoppedAnimation(CustomColors.primary),
        //               ),
        //             )
        //           : CustomIcon(
        //               height: 24,
        //               icon: 'delete',
        //             ),
        //     );
        //   }),
        //   if (!_editMode)
        //     IconButton(
        //       onPressed: () {
        //         setState(() {
        //           _editMode = true;
        //         });
        //       },
        //       icon: CustomIcon(
        //         height: 24,
        //         icon: 'edit',
        //       ),
        //     ),
        // ],
      ),
      body: ListView(
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
                  title: 'TRANSACTION ID',
                  info: widget.transaction?.transId ??
                      widget.cardTransaction?.virtualTransId ??
                      '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'TYPE',
                  info: widget.cardTransaction?.virtualTransType ??
                      (widget.transaction?.transType == 1
                          ? 'Deposit'
                          : widget.transaction?.transType == 6 ||
                                  widget.transaction?.transType == 7
                              ? 'Convert'
                              : widget.transaction?.transType == 2
                                  ? 'Withdrawal'
                                  : widget.transaction?.transType == 3
                                      ? 'Offshore'
                                      : widget.transaction?.transType == 4
                                          ? 'Internal transfer'
                                          : 'Receive of internal transfer'),
                ),
                if (widget.transaction != null)
                  const Divider(
                    height: 32,
                  ),
                if (widget.transaction != null)
                  SummaryInfo(
                    title: 'THIRDPARTY',
                    info: widget.transaction?.externalName ?? '',
                  ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'PURPOSE',
                  info: widget.transaction?.purpose ??
                      widget.cardTransaction?.transactionPurpose ??
                      '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'FROM',
                  info:
                      '${widget.transaction?.fromAmount ?? widget.cardTransaction?.previousBalance ?? ''} ${widget.transaction?.fromCur ?? widget.cardTransaction?.virtualCardCur ?? ''}',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'TO',
                  info:
                      '${widget.transaction?.toAmount ?? widget.cardTransaction?.presentBalance ?? ''} ${widget.transaction?.toCur ?? widget.cardTransaction?.virtualCardCur ?? ''}',
                ),
                const Divider(
                  height: 32,
                ),
                if (widget.transaction != null)
                  SummaryInfo(
                    title: 'CHARGE',
                    info:
                        '${widget.transaction?.charges?.toStringAsFixed(2) ?? ''} ${widget.transaction?.fromCur ?? ''}',
                  ),
                if (widget.transaction != null)
                  const Divider(
                    height: 32,
                  ),
                if (widget.transaction != null)
                  SummaryInfo(
                    title: 'RATE',
                    info: widget.transaction?.rate ?? '',
                  ),
                if (widget.transaction != null)
                  const Divider(
                    height: 32,
                  ),
                SummaryInfo(
                  title: 'DATE',
                  info: DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                      widget.transaction?.createdAt ??
                          widget.cardTransaction?.createdAt ??
                          DateTime.now()),
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'STATUS',
                  info: (widget.transaction?.confirmation ??
                              widget.cardTransaction?.virtualTransStatus) ==
                          0
                      ? 'Pending'
                      : (widget.transaction?.confirmation ??
                                  widget.cardTransaction?.virtualTransStatus) ==
                              1
                          ? 'Successful'
                          : (widget.transaction?.confirmation ??
                                      widget.cardTransaction
                                          ?.virtualTransStatus) ==
                                  2
                              ? 'In progress'
                              : 'Failed',
                  infoColor: (widget.transaction?.confirmation ??
                              widget.cardTransaction?.virtualTransStatus) ==
                          0
                      ? CustomColors.orange
                      : (widget.transaction?.confirmation ??
                                  widget.cardTransaction?.virtualTransStatus) ==
                              1
                          ? CustomColors.green
                          : (widget.transaction?.confirmation ??
                                      widget.cardTransaction
                                          ?.virtualTransStatus) ==
                                  2
                              ? CustomColors.labelText
                              : CustomColors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
