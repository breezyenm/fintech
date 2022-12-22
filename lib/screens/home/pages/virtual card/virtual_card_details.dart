import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/models/virtual_card.dart';
import 'package:qwid/screens/home/components/summary_info.dart';
import 'package:qwid/screens/home/components/virtual_card.dart';

class VirtualCardDetails extends StatelessWidget {
  final VirtualCard virtualCard;
  const VirtualCardDetails({Key? key, required this.virtualCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Card details',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 44),
        children: [
          VirtualCardItem(
            full: true,
            virtualCard: virtualCard,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SummaryInfo(
                  title: 'CARD NAME',
                  info: virtualCard.virtualCardData?.nameOnCard ?? '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'CARD NUMBER',
                  info: virtualCard.virtualCardData?.cardNumber ?? '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'EXPIRY DATE',
                  info:
                      ('${virtualCard.virtualCardData?.expiryMonth}/${virtualCard.virtualCardData?.expiryYear}'),
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'CVC',
                  info: virtualCard.virtualCardData?.cvv ?? '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'STREET ADDRESS',
                  info: virtualCard.virtualCardData?.address ?? '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'COUNTRY',
                  info: virtualCard.virtualCardData?.country ?? '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'STATE',
                  info: virtualCard.virtualCardData?.state ?? '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'CITY',
                  info: virtualCard.virtualCardData?.city ?? '',
                ),
                const Divider(
                  height: 32,
                ),
                SummaryInfo(
                  title: 'ZIPCODE',
                  info: virtualCard.virtualCardData?.zipcode ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
