import 'package:flutter/material.dart';

class CustomIcon extends Image {
  CustomIcon({
    Key? key,
    required double height,
    required String icon,
  }) : super(
          key: key,
          height: height,
          image: AssetImage(
            'images/$icon.png',
          ),
          fit: BoxFit.fitHeight,
        );
}
