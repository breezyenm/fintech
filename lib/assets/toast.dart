import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';

import 'style.dart';

class Functions {
  static toast(
    String content,
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: CustomColors.background,
        content: Text(
          content,
          style: const CustomTextStyle(),
        ),
      ),
    );
  }
}
