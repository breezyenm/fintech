import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qwid/assets/colors.dart';

import 'navigation.dart';
import 'style.dart';

Future alert({required BuildContext context, required String content}) async {
  if (Platform.isAndroid) {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigation.pop(context);
              },
              child: const Text(
                'Okay',
                style: CustomTextStyle(
                  color: CustomColors.primary,
                ),
              ),
            ),
          ],
          content: Text(
            content,
            style: const CustomTextStyle(),
          ),
          title: const Text(
            'Message',
            style: CustomTextStyle(),
          ),
        );
      },
    );
  }
  if (Platform.isIOS) {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigation.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
          content: Text(content),
          title: const Text('Message'),
        );
      },
    );
  }
}
