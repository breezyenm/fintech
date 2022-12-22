import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';

class CheckBox extends CheckboxListTile {
  CheckBox({
    Key? key,
    required bool value,
    required Function(bool?) onChanged,
    required Widget title,
  }) : super(
          key: key,
          value: value,
          onChanged: onChanged,
          activeColor: CustomColors.primary,
          enableFeedback: true,
          title: title,
          contentPadding: const EdgeInsets.all(0),
          dense: true,
          checkColor: CustomColors.white,
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(
              width: 1,
              color: CustomColors.labelText,
            ),
          ),
          visualDensity: const VisualDensity(
            horizontal: -4,
            vertical: -4,
          ),
          controlAffinity: ListTileControlAffinity.leading,
        );
}
