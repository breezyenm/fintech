import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/models/wallet.dart';
import 'package:qwid/providers/brain/home_provider.dart';
import 'package:qwid/providers/data/wallet.dart';
import 'package:qwid/screens/home/components/wallet_actions.dart';
import 'package:qwid/screens/home/pages/wallet/wallet_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

class WalletCard extends StatefulWidget {
  // final String currency, balance, flag;
  final Wallet wallet;
  const WalletCard({
    Key? key,
    // required this.currency,
    // required this.balance,
    // required this.flag,
    required this.wallet,
  }) : super(key: key);

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  late Key key;
  @override
  void initState() {
    key = Key(widget.wallet.cur!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, WalletData>(
        builder: (context, homePro, data, chi9ld) {
      return GestureDetector(
        onTap: () {
          data.wallet = widget.wallet;
          Navigation.push(
            WalletPage(
              wallet: widget.wallet,
            ),
            context,
          );
        },
        child: VisibilityDetector(
          key: key,
          onVisibilityChanged: (info) {
            if (info.visibleFraction > 0.7) {
              homePro.displayedWallet = widget.wallet;
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 56,
            decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: CustomColors.stroke,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SvgPicture.network(
                            widget.wallet.flag!,
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        widget.wallet.currency!,
                        style: const CustomTextStyle(
                          color: CustomColors.darkPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward,
                        color: CustomColors.darkPrimary,
                        size: 24,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BALANCE',
                        style: CustomTextStyle(
                          color: CustomColors.labelText.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.wallet.balance!.toStringAsFixed(2),
                        style: const CustomTextStyle(
                          color: CustomColors.labelText,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                WalletActions(
                  wallet: widget.wallet,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
