import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/logo.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/virtual_card.dart';
import 'package:qwid/providers/data/card.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VirtualCardItem extends StatefulWidget {
  final VirtualCard virtualCard;
  final bool full;
  const VirtualCardItem(
      {Key? key, required this.virtualCard, this.full = false})
      : super(key: key);

  @override
  State<VirtualCardItem> createState() => _VirtualCardItemState();
}

class _VirtualCardItemState extends State<VirtualCardItem> {
  late Key key;
  @override
  void initState() {
    key = Key(widget.virtualCard.virtualCardId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Hero(
      tag: widget.virtualCard.virtualCardId!,
      child: Consumer<CardData>(builder: (context, data, chi9ld) {
        return VisibilityDetector(
          key: key,
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.7) {
              data.virtualCard = widget.virtualCard;
            }
          },
          child: SizedBox(
            height: (screen.width - (widget.full ? 32 : 56)) * 9 / 16,
            width: (screen.width - (widget.full ? 32 : 56)),
            child: Stack(
              children: [
                Container(
                  height: (screen.width - (widget.full ? 32 : 56)) * 9 / 16,
                  width: (screen.width - (widget.full ? 32 : 56)),
                  // margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: (widget.virtualCard.virtualCardColor != null)
                        ? data.presets[widget.virtualCard.virtualCardColor!] ??
                            CustomColors.primary
                        : CustomColors.primary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                          color: const Color(0xff111111).withOpacity(0.22))
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Logo(
                        size: 22,
                        color: CustomColors.white,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              4,
                              (index) => CustomIcon(
                                height: 11,
                                icon: 'star',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            widget.virtualCard.virtualCardData?.cardNumber
                                    ?.substring((widget
                                                    .virtualCard
                                                    .virtualCardData
                                                    ?.cardNumber ??
                                                '00000000')
                                            .length -
                                        4) ??
                                '0000',
                            style: const CustomTextStyle(
                              color: CustomColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'EXP ${widget.virtualCard.virtualCardData?.expiryMonth}/${widget.virtualCard.virtualCardData?.expiryYear}',
                            style: const CustomTextStyle(
                              color: CustomColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.virtualCard.virtualCardData?.nameOnCard}',
                            style: const CustomTextStyle(
                              color: CustomColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'VISA',
                            style: CustomTextStyle(
                              color: CustomColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'images/card_design.png',
                    height: ((screen.width - 56) * 9 / 16) * 0.45,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
