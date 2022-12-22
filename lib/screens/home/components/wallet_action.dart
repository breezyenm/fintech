import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';

class WalletAction extends TextButton {
  WalletAction({
    Key? key,
    required Color textColor,
    double scale = 1,
    Function()? onPressed,
    required String title,
    required String icon,
  }) : super(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIcon(
                height: 20 * scale,
                icon: icon,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: CustomTextStyle(
                  color: textColor,
                  fontSize: 10 * scale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return 0;
                }
                return 2;
              },
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return CustomColors.black.withOpacity(0.01);
                }
                return CustomColors.white;
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return CustomColors.black.withOpacity(0.01);
                }
                return CustomColors.white;
              },
            ),
            padding: MaterialStateProperty.resolveWith(
              (states) {
                return const EdgeInsets.symmetric(
                  vertical: 8,
                );
              },
            ),
            shadowColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return const Color(0xffD8D8D8).withOpacity(0);
                }
                return const Color(0xffD8D8D8).withOpacity(0.64);
              },
            ),
            alignment: Alignment.center,
            shape: MaterialStateProperty.resolveWith(
              (states) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                );
              },
            ),
          ),
        );
}
