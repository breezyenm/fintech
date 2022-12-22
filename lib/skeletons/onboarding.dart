import 'package:flutter/material.dart';
import 'package:qwid/appbars/logo_appbar.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';

class Onboarding extends StatelessWidget {
  final String? image;
  final String title, subtitle;
  final List<Widget> body;
  const Onboarding({
    Key? key,
    this.image,
    required this.title,
    required this.subtitle,
    this.body = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LogoAppbar(),
      body: ListView(
        children: [
          if (image != null)
            const SizedBox(
              height: 24,
            ),
          if (image != null)
            Image.asset(
              'images/onboarding$image.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          Container(
            width: double.infinity,
            color: CustomColors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Text(
                    title,
                    style: const CustomTextStyle(
                      color: CustomColors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                  ),
                  child: Text(
                    subtitle,
                    style: CustomTextStyle(
                      color: CustomColors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ...body,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
