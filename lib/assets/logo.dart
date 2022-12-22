import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';

class Logo extends Text {
  // final double? height;

  Logo({
    Key? key,
    double size = 36,
    Color color = CustomColors.primary,
  }) : super(
          'qwid',
          key: key,
          style: CustomTextStyle(
            fontSize: size,
            fontFamily: 'MontserratAlternates',
            color: color,
          ),
        );
}
