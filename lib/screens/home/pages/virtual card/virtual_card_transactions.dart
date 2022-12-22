import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/card_transaction.dart';
import 'package:qwid/models/virtual_card.dart';
import 'package:qwid/providers/API/card.dart';
import 'package:qwid/providers/data/card.dart';
import 'package:qwid/screens/home/components/transaction_card.dart';

class VirtualCardTransaction extends StatelessWidget {
  final VirtualCard virtualCard;
  const VirtualCardTransaction({Key? key, required this.virtualCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<CardAPI, CardData>(
        builder: (context, api, walletPro, chi9ld) {
      return FutureBuilder<List<CardTransaction>?>(
          future: api.getVirtualCardTransactions(
              context, virtualCard.virtualCardId!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if ((snapshot.data ?? []).isNotEmpty)
                    Padding(
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
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => TransactionCard(
                        cardTransaction: (snapshot.data ?? [])[index],
                      ),
                      itemCount: (snapshot.data ?? []).length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                    ),
                  ),
                ],
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
