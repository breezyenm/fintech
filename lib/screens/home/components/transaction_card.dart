import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/card_transaction.dart';
import 'package:qwid/models/transaction.dart';
import 'package:qwid/providers/brain/wallet_provider.dart';
import 'package:qwid/screens/home/pages/wallet/transactions/transaction_page.dart';

class TransactionCard extends StatelessWidget {
  final CardTransaction? cardTransaction;
  final Transaction? transaction;
  const TransactionCard({
    Key? key,
    this.transaction,
    this.cardTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(builder: (context, walletPro, chi9ld) {
      return InkWell(
        onTap: () {
          Navigation.push(
            TransactionPage(
              transaction: transaction,
              cardTransaction: cardTransaction,
            ),
            context,
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: CustomColors.white,
            border: Border.all(
              color: CustomColors.stroke,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: walletPro.transactionColors[
                        cardTransaction?.virtualTransType ??
                            walletPro
                                .transactionType[transaction?.transType ?? 0] ??
                            'deposit'] ??
                    const Color(0xffD9FDEF),
                child: CustomIcon(
                  height: 24,
                  icon:
                      walletPro.transactionType[transaction?.transType ?? 0] ??
                          'deposit',
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardTransaction?.transactionPurpose ??
                          (transaction?.transType == 1
                              ? '${transaction?.fromCur} Top up'
                              : transaction?.transType == 6 ||
                                      transaction?.transType == 7
                                  ? 'Convert from ${transaction?.fromCur} to ${transaction?.toCur}'
                                  : transaction?.transType == 2
                                      ? 'Withdrawal to ${transaction?.externalName}'
                                      : transaction?.transType == 3 ||
                                              transaction?.transType == 4
                                          ? 'Transfer to  ${transaction?.externalName}'
                                          : 'Transfer from ${transaction?.externalName}'),
                      style: const CustomTextStyle(
                        color: CustomColors.text,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(
                          transaction?.createdAt ??
                              cardTransaction?.createdAt ??
                              DateTime.now()),
                      style: CustomTextStyle(
                        color: CustomColors.labelText.withOpacity(0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                '${transaction?.fromAmount ?? (double.parse(cardTransaction?.presentBalance ?? '0') - double.parse(cardTransaction?.previousBalance ?? '0')).abs().toStringAsFixed(2)} ${transaction?.fromCur ?? cardTransaction?.virtualCardCur}',
                style: const CustomTextStyle(
                  color: CustomColors.text,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
