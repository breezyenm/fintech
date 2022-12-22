import 'package:flutter/material.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/skeletons/home.dart';

class SuccessfulPopup extends AlertDialog {
  SuccessfulPopup({
    Key? key,
    required String title,
    Widget? subtitle,
    required BuildContext context,
  }) : super(
          key: key,
          insetPadding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.all(24),
          backgroundColor: CustomColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.624,
                  width: MediaQuery.of(context).size.width * 0.624,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColors.stroke,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  title,
                  style: const CustomTextStyle(
                    color: CustomColors.text,
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle == null)
                  const SizedBox(
                    height: 8,
                  ),
                subtitle ??
                    Text(
                      'Payment should arrive in few minutes',
                      style: CustomTextStyle(
                        color: CustomColors.text.withOpacity(0.5),
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                  text: 'Go Home',
                  onPressed: () {
                    Navigation.replaceAll(
                      const Home(),
                      context,
                    );
                  },
                ),
              ],
            ),
          ),
        );
}
