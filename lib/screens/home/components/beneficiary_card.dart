import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/beneficiary.dart';
import 'package:qwid/providers/brain/card_provider.dart';

class BeneficiaryCard extends StatelessWidget {
  final Beneficiary beneficiary;
  final Function() onTap;
  const BeneficiaryCard({
    Key? key,
    required this.beneficiary,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CardProvider>(builder: (context, cardPro, chi9ld) {
      return InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
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
                backgroundColor: CustomColors.stroke,
                child: Text(
                  beneficiary.accountName![0] + beneficiary.accountName![1],
                  style: const CustomTextStyle(
                    color: CustomColors.text,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
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
                      beneficiary.accountName!,
                      style: const CustomTextStyle(
                        color: CustomColors.text,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      beneficiary.bankName!,
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
              Container(
                alignment: Alignment.center,
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  color: CustomColors.background,
                  shape: BoxShape.circle,
                ),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: CustomIcon(
                    height: 16,
                    icon: 'down',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
