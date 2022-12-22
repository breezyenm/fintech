import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';

class BalanceCard extends StatelessWidget {
  final String currency, balance, difference, differenceType;
  const BalanceCard({
    Key? key,
    required this.currency,
    required this.balance,
    required this.difference,
    required this.differenceType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.white,
        border: Border.all(
          color: CustomColors.stroke,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 14,
                width: 20,
                color: CustomColors.stroke,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                currency,
                style: CustomTextStyle(
                  color: CustomColors.labelText.withOpacity(0.5),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                balance,
                style: const CustomTextStyle(
                  color: CustomColors.labelText,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${differenceType == 'minus' ? '-' : '+'}$difference',
                style: CustomTextStyle(
                  color: differenceType == 'minus'
                      ? CustomColors.red.withOpacity(0.5)
                      : CustomColors.green.withOpacity(0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
