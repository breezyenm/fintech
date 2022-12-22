import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.warning,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Please Note',
            style: CustomTextStyle(
              color: Color(0xff58461C),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Sending money can take up to 5 to 10 minutes. Please contact our customer care @qwid.io if it takes longer',
            style: CustomTextStyle(
              color: Color(0xffAB9F81),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
