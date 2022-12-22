import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qwid/assets/colors.dart';

import 'navigation.dart';
import 'style.dart';

Future<bool> confirm({
  required BuildContext context,
  required String content,
  String? title,
  String? yes,
  String? no,
  bool yesDestructive = false,
}) async {
  bool action = false;
  if (Platform.isAndroid) {
    await showDialog(
      barrierColor: CustomColors.labelText.withOpacity(0.48),
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: CustomColors.background,
          actions: [
            TextButton(
              onPressed: () {
                action = false;
                Navigation.pop(context);
              },
              child: Text(
                no ?? 'No',
                style: const CustomTextStyle(
                  color: CustomColors.labelText,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                action = true;
                Navigation.pop(context);
              },
              child: Text(
                yes ?? 'Yes',
                style: CustomTextStyle(
                  color:
                      yesDestructive ? CustomColors.red : CustomColors.primary,
                ),
              ),
            ),
          ],
          content: Text(
            content,
            style: const CustomTextStyle(
              color: CustomColors.labelText,
            ),
          ),
          title: Text(
            title ?? 'Confirm',
            style: CustomTextStyle(
              color: CustomColors.labelText.withOpacity(0.5),
            ),
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
              isDefaultAction: true,
              onPressed: () {
                action = false;
                Navigation.pop(context);
              },
              child: Text(no ?? 'No'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: yesDestructive,
              onPressed: () {
                action = true;
                Navigation.pop(context);
              },
              child: Text(yes ?? 'Yes'),
            ),
          ],
          content: Text(content),
          title: Text(title ?? 'Confirm'),
        );
      },
    );
  }
  return action;
}
