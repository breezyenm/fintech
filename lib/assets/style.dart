import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';

class CustomTextStyle extends TextStyle {
  const CustomTextStyle({
    double? spacing,
    double? height,
    double fontSize = 16,
    String fontFamily = 'Inter',
    FontWeight fontWeight = FontWeight.w600,
    Color? color = CustomColors.labelText,
    TextDecoration? decoration,
  }) : super(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          height: height,
          letterSpacing: spacing,
          decoration: decoration,
          decorationColor: CustomColors.primary,
        );
}
