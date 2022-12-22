import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/virtual_account.dart';
import 'package:qwid/models/wallet.dart';
import 'package:qwid/providers/brain/account_provider.dart';
import 'package:qwid/screens/home/components/copy.dart';
import 'package:qwid/screens/home/pages/wallet/virtual%20account/setup_modal.dart';
import 'package:qwid/screens/home/pages/wallet/virtual%20account/virtual_account_page.dart';

class VirtualWalletCard extends StatelessWidget {
  final VirtualAccount? virtualAccount;
  final Wallet wallet;
  // final bool active;
  const VirtualWalletCard({
    Key? key,
    // this.active = false,
    this.virtualAccount,
    required this.wallet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () async {
        if (virtualAccount == null) {
          await showDialog(
            context: context,
            builder: (context) => const SetupModal(),
          );
          Provider.of<AccountProvider>(context, listen: false)
              .virtualAccountToBeAdded = null;
          Provider.of<AccountProvider>(context, listen: false).wallet = null;
        } else {
          Navigation.push(
            VirtualAccountPage(
              virtualAccount: virtualAccount!,
              wallet: wallet,
            ),
            context,
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: CustomColors.stroke,
            )),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
        child: Column(
          children: [
            Text(
              '${virtualAccount == null ? 'SETUP' : 'FUND YOUR'} VIRTUAL ACCOUNT',
              style: const CustomTextStyle(
                color: CustomColors.labelText,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            if (virtualAccount != null)
              if (virtualAccount?.accountNo == null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  color: CustomColors.warning,
                  child: const Text(
                    'PENDING',
                    style: CustomTextStyle(
                      color: CustomColors.labelText,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            virtualAccount!.accountNo!,
                            style: const CustomTextStyle(
                              color: CustomColors.labelText,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Copy(
                          text: virtualAccount!.accountNo!,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      virtualAccount!.bankName!,
                      style: const CustomTextStyle(
                        color: CustomColors.darkPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
            else
              CustomIcon(
                height: 120,
                icon: 'save',
              ),
            const SizedBox(
              height: 14,
            ),
            Text(
              virtualAccount == null
                  ? 'Receive money and credit your wallet quick and easy with your own virtual bank account'
                  : 'Funds transferred to this account number is instantly credited to your ${virtualAccount?.cur} wallet.',
              style: const CustomTextStyle(
                color: CustomColors.labelText,
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              virtualAccount == null ? 'Get started' : 'More details',
              style: const CustomTextStyle(
                color: CustomColors.darkPrimary,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: CustomColors.darkPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
