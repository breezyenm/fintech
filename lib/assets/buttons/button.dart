import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';

class CustomButton extends TextButton {
  CustomButton({
    Key? key,
    // Color textColor = CustomColors.white,
    // FontWeight textWeight = FontWeight.bold,
    // double radius = 5,
    // Color color = CustomColors.primary,
    // Color action,
    // double textSize = 16,
    Function()? onPressed,
    required String text,
    // bool outlined = false,
    String? icon,
  }) : super(
          key: key,
          child: SizedBox(
            height: 24,
            child: Center(
              child: text.toLowerCase() == 'loading'
                  ? const SizedBox(
                      width: 24,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1.2,
                        valueColor: AlwaysStoppedAnimation(
                          CustomColors.white,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null)
                          CustomIcon(
                            height: 24,
                            icon: icon,
                          ),
                        if (icon != null)
                          const SizedBox(
                            width: 8,
                          ),
                        Text(
                          text,
                          style: const CustomTextStyle(
                            color: CustomColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          onPressed: text.toLowerCase() == 'loading' ? null : onPressed,
          style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
                return 0;
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return CustomColors.labelText;
                }
                return CustomColors.white;
              },
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return CustomColors.primary.withOpacity(0.25);
                } else if (states.contains(MaterialState.pressed)) {
                  return CustomColors.black.withOpacity(0.25);
                }
                return CustomColors.primary;
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return CustomColors.primary.withOpacity(0.25);
                } else if (states.contains(MaterialState.pressed)) {
                  return CustomColors.black.withOpacity(0.25);
                }
                return CustomColors.primary;
              },
            ),
            padding: MaterialStateProperty.resolveWith(
              (states) {
                return const EdgeInsets.symmetric(
                  vertical: 12,
                );
              },
            ),
            alignment: Alignment.center,
            shape: MaterialStateProperty.resolveWith(
              (states) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: states.contains(MaterialState.disabled)
                      ? BorderSide(
                          color: CustomColors.black.withOpacity(0.12),
                        )
                      : BorderSide.none,
                );
              },
            ),
          ),
        );
}
