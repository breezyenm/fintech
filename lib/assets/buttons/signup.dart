import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';

class SignupButton extends TextButton {
  SignupButton({
    Key? key,
    Function()? onPressed,
    required String text,
    required String icon,
  }) : super(
          key: key,
          child: Row(
            children: [
              CustomIcon(
                height: 24,
                icon: icon,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Text(
                    text,
                    style: const CustomTextStyle(
                      color: CustomColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
                child: CustomIcon(
                  height: 12,
                  icon: 'forward',
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
                return const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                );
              },
            ),
            alignment: Alignment.center,
            // elevation: MaterialStateProperty<double>().,
            shape: MaterialStateProperty.resolveWith(
              (states) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: CustomColors.primary,
                  ),
                );
              },
            ),
          ),
        );
}
