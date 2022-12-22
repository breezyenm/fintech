import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/providers/API/wallet.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/statement_card.dart';

class StatementsPage extends StatefulWidget {
  const StatementsPage({Key? key}) : super(key: key);

  @override
  State<StatementsPage> createState() => _StatementsPageState();
}

class _StatementsPageState extends State<StatementsPage> {
  // late ScrollController controller;
  bool loading = false;
  @override
  void initState() {
    WalletData data = Provider.of<WalletData>(context, listen: false);
    Provider.of<WalletAPI>(context, listen: false).getStatement(
      context: context,
      cur: data.wallet?.cur,
      year: data.year,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<WalletAPI, WalletData>(
      builder: (context, api, data, chi9ld) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Statements',
            ),
          ),
          body: data.statements == null
              ? const SizedBox(
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
                )
              : (data.statements ?? []).isEmpty
                  ? Padding(
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
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 44,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => StatementCard(
                        statement: (data.statements ?? [])[index],
                      ),
                      itemCount: (data.statements ?? []).length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ),
        );
      },
    );
  }
}
