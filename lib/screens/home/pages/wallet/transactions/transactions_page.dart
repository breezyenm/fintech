import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/bottom_sheets/download_trans.dart';
import 'package:qwid/models/transaction.dart';
import 'package:qwid/models/wallet.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/transaction_card.dart';
import 'package:qwid/screens/home/pages/wallet/transactions/statements_page.dart';

class TransactionsPage extends StatefulWidget {
  final List<Transaction>? transactions;
  final Wallet? wallet;
  const TransactionsPage({
    Key? key,
    this.transactions,
    this.wallet,
  }) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  late ScrollController controller;
  bool loading = false;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    WalletData data = Provider.of<WalletData>(context, listen: false);
    if (widget.transactions != null) {
      data.transactions = widget.transactions ?? [];
    }
    controller = ScrollController()
      ..addListener(() async {
        if (data.transactions.isNotEmpty &&
            controller.offset == controller.position.maxScrollExtent) {
          setState(() {
            loading = true;
          });
          await Provider.of<WalletAPI>(context, listen: false)
              .getUserTransactions(
            context: context,
            start: data.transactions.length,
            limit: data.transactions.length + 20,
            cur: widget.wallet?.cur,
          );
          setState(() {
            loading = false;
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<WalletAPI, WalletData>(
        builder: (context, api, data, chi9ld) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Transactions',
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // data.fromCur = null;
                // data.wallet = null;
                data.year = null;
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Form(
                    key: _key,
                    child: DownloadTrans(
                      context: context,
                      onPressed: () async {
                        if ((_key.currentState?.validate() ?? false) &&
                            data.wallet != null &&
                            data.year != null) {
                          Navigation.push(
                            const StatementsPage(),
                            context,
                          );
                        }
                      },
                    ),
                  ),
                );
              },
              icon: CustomIcon(
                height: 24,
                icon: 'download',
              ),
            ),
          ],
        ),
        body: FutureBuilder(
            future: (data.transactions).length >= 20
                ? null
                : api.getUserTransactions(
                    context: context,
                    start: data.transactions.length,
                    limit: data.transactions.length + 20,
                    cur: widget.wallet?.cur,
                  ),
            builder: (context, snapshot) {
              if (data.transactions.isEmpty) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Empty',
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
                          "You've not made any transactions",
                          style: CustomTextStyle(
                            color: CustomColors.text.withOpacity(0.5),
                            fontFamily: 'Montserrat',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: SizedBox(
                        height: 12,
                        width: 12,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 1.2,
                          valueColor:
                              AlwaysStoppedAnimation(CustomColors.primary),
                        ),
                      ),
                    ),
                  );
                }
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      // primary: false,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) => TransactionCard(
                        transaction: data.transactions[index],
                      ),
                      itemCount: data.transactions.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (loading)
                    const SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1.2,
                        valueColor: AlwaysStoppedAnimation(
                          CustomColors.primary,
                        ),
                      ),
                    ),
                ],
              );
            }),
      );
    });
  }
}
