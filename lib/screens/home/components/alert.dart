import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';

class Alert extends StatelessWidget {
  const Alert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.white.withOpacity(0.48),
        // border: Border.all(
        //   color: CustomColors.stroke,
        // ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: Text(
              'Your documents are under review',
              style: CustomTextStyle(
                color: Color(0xffAB9F81),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.info_outline_rounded,
            color: Color(0xffAB9F81),
          )
        ],
      ),
    );
  }
}
