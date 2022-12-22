import 'package:flutter/material.dart';
import 'package:qwid/assets/buttons/option_button.dart';
import 'package:qwid/bottom_sheets/general_sheet.dart';

class OptionsSheet extends GeneralSheet {
  OptionsSheet({
    Key? key,
    required String title,
    String? subtitle,
    required Map<String, String> options,
    required Map<String, Function()> optionsAction,
    required BuildContext context,
  }) : super(
          key: key,
          body: options.entries
              .map((e) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OptionButton(
                        text: e.key,
                        subtext: e.value,
                        onPressed: optionsAction[e.key],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ))
              .toList(),
          title: title,
          subtitle: subtitle,
        );
}
