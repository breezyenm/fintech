import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/transaction.dart';
import 'package:qwid/models/wallet.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/screens/home/pages/wallet/transactions/transactions_page.dart';

import 'transaction_card.dart';

class TransactionList extends StatefulWidget {
  final Wallet? wallet;
  const TransactionList({Key? key, this.wallet}) : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  List<Transaction>? transactions;
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletAPI>(builder: (context, api, chi9ld) {
      return FutureBuilder<List<Transaction>>(
          future: (transactions ?? []).isNotEmpty
              ? null
              : api.getUserTransactions(
                  context: context,
                  start: 0,
                  limit: 5,
                  cur: widget.wallet?.cur,
                  save: false,
                ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                transactions == null) {
              transactions = snapshot.data;
            }
            if ((transactions ?? []).isNotEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: transactions!.length >= 5
                        ? () {
                            Navigation.push(
                              TransactionsPage(
                                wallet: widget.wallet,
                                transactions: transactions,
                              ),
                              context,
                            );
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Row(
                        children: [
                          CustomIcon(
                            height: 24,
                            icon: 'transactions',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Expanded(
                            child: Text(
                              'TRANSACTION HISTORY',
                              style: CustomTextStyle(
                                color: CustomColors.text,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          if (transactions!.length >= 5)
                            const Icon(
                              Icons.arrow_forward,
                              size: 24,
                              color: CustomColors.labelText,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => TransactionCard(
                        transaction: (transactions ?? [])[index],
                      ),
                      itemCount: (transactions ?? []).length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Empty',
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
                      'You have not made any transaction',
                      style: CustomTextStyle(
                        color: CustomColors.black.withOpacity(0.5),
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox(
              height: 100,
              child: Center(
                child: SizedBox(
                  height: 12,
                  width: 12,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 1.2,
                    valueColor: AlwaysStoppedAnimation(CustomColors.primary),
                  ),
                ),
              ),
            );
          });
    });
  }
}
