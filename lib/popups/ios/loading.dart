import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qwid/assets/navigation.dart';

class Loading extends StatelessWidget {
  final String title;
  const Loading({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: const CircularProgressIndicator.adaptive(),
      actions: [
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigation.pop(context);
          },
          child: const Text(
            'Close',
          ),
        ),
      ],
    );
  }
}
