import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/toast.dart';

class Copy extends StatelessWidget {
  final String text;
  const Copy({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(200),
      onTap: () async {
        await Clipboard.setData(
          ClipboardData(
            text: text,
          ),
        );
        Functions.toast(
          'Copied',
          context,
        );
      },
      child: CustomIcon(
        height: 20,
        icon: 'copy',
      ),
    );
  }
}
