import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';

class OptionButton extends TextButton {
  OptionButton({
    Key? key,
    Function()? onPressed,
    required String text,
    required String subtext,
  }) : super(
          key: key,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const CustomTextStyle(
                        color: CustomColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      subtext,
                      style: const CustomTextStyle(
                        color: CustomColors.labelText,
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
          onPressed: onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
                return 0;
              },
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return CustomColors.primary.withOpacity(0.3);
                }
                return CustomColors.white;
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return CustomColors.primary.withOpacity(0.3);
                }
                return CustomColors.white;
              },
            ),
            padding: MaterialStateProperty.resolveWith(
              (states) {
                return const EdgeInsets.all(16);
              },
            ),
            alignment: Alignment.center,
            // elevation: MaterialStateProperty<double>().,
            shape: MaterialStateProperty.resolveWith(
              (states) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: CustomColors.stroke,
                  ),
                );
              },
            ),
          ),
        );
}
