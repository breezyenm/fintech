import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/models/virtual_account.dart';
import 'package:qwid/models/wallet.dart';
import 'package:qwid/screens/home/components/info_card.dart';
import 'package:qwid/screens/home/components/summary_info.dart';

class VirtualAccountPage extends StatelessWidget {
  final VirtualAccount virtualAccount;
  final Wallet wallet;
  const VirtualAccountPage({
    Key? key,
    required this.virtualAccount,
    required this.wallet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 44),
        children: [
          InfoCard(
            title: 'CURRENCY',
            info: wallet.currency!,
          ),
          const SizedBox(
            height: 16,
          ),
          InfoCard(
            title: 'STATUS',
            info: virtualAccount.status == 0 ? 'Pending' : 'Active',
            infoColor: virtualAccount.status == 0
                ? CustomColors.red.withOpacity(0.5)
                : CustomColors.green.withOpacity(0.5),
          ),
          const SizedBox(
            height: 16,
          ),
          InfoCard(
            title: 'BALANCE',
            info: wallet.balance!.toStringAsFixed(2),
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
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummaryInfo(
                  title: 'BANK NAME',
                  info: virtualAccount.bankName ?? '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'ACCOUNT HOLDER',
                  info: virtualAccount.accountName ?? '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'ACCOUNT NUMBER',
                  info: virtualAccount.accountNo ?? '',
                  copyable: true,
                ),
                if ((virtualAccount.routine ?? '').isNotEmpty)
                  const Divider(
                    height: 32,
                  ),
                if ((virtualAccount.routine ?? '').isNotEmpty)
                  SummaryInfo(
                    title: wallet.cur == 'USD' ? 'ROUTING NUMBER' : 'SORT CODE',
                    info: virtualAccount.routine ?? '',
                    copyable: true,
                  ),
                if ((virtualAccount.swift ?? '').isNotEmpty)
                  const Divider(
                    height: 32,
                  ),
                if ((virtualAccount.swift ?? '').isNotEmpty)
                  SummaryInfo(
                    title: 'SWIFT',
                    info: virtualAccount.swift ?? '',
                    copyable: true,
                  ),
                if ((virtualAccount.iban ?? '').isNotEmpty)
                  const Divider(
                    height: 32,
                  ),
                if ((virtualAccount.iban ?? '').isNotEmpty)
                  SummaryInfo(
                    title: 'IBAN',
                    info: virtualAccount.iban ?? '',
                    copyable: true,
                  ),
                const Divider(
                  height: 32,
                ),
                const SummaryInfo(
                  title: 'TRANSACTION LIMIT',
                  info: 'Nil',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
