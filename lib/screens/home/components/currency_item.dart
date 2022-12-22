import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/wallet.dart';

class CurrencyItem extends StatelessWidget {
  // final bool active;
  // final String currency, cur, balance;
  final Wallet wallet;
  const CurrencyItem({
    Key? key,
    // required this.active,
    // required this.currency,
    // required this.cur,
    // required this.balance,
    required this.wallet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: CustomColors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SvgPicture.network(
              wallet.flag!,
              width: 50,
              height: 50,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          wallet.currency!,
          style: CustomTextStyle(
            color: CustomColors.labelText.withOpacity(0.5),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              'BALANCE',
              style: CustomTextStyle(
                color: CustomColors.darkPrimary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              wallet.balance!.toStringAsFixed(2),
              style: const CustomTextStyle(
                color: CustomColors.labelText,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }
}
