import 'package:flutter/material.dart';
import 'package:qwid/assets/icon.dart';

class Obscure extends StatelessWidget {
  final bool obscure;

  const Obscure({
    Key? key,
    required this.obscure,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomIcon(
      height: 24,
      icon: obscure ? 'hide' : 'show',
    );
  }
}
