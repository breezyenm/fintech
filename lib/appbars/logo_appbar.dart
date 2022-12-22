import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/logo.dart';

class LogoAppbar extends AppBar {
  LogoAppbar({
    Key? key,
    bool automaticallyImplyLeading = true,
  }) : super(
          key: key,
          title: Logo(),
          centerTitle: true,
          automaticallyImplyLeading: automaticallyImplyLeading,
          backgroundColor: CustomColors.background,
          elevation: 0,
          // shape: const ContinuousRectangleBorder(
          //   side: BorderSide(
          //     width: 0.5,
          //     color: CustomColors.grey6,
          //   ),
          // ),
        );
}
