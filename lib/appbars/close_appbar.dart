import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';

class CloseAppbar extends AppBar {
  CloseAppbar(
      {Key? key,
      bool automaticallyImplyLeading = false,
      required Function() function,
      required String title})
      : super(
          key: key,
          leading: Center(
            child: GestureDetector(
              onTap: function,
              child: CustomIcon(
                height: 24,
                icon: 'close',
              ),
            ),
          ),
          title: Text(
            title,
          ),
          centerTitle: true,
          backgroundColor: CustomColors.white,
          elevation: 0,
          // shape: const ContinuousRectangleBorder(
          //   side: BorderSide(
          //     width: 1,
          //     color: CustomColors.grey7,
          //   ),
          // ),
        );
}
