import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/navigation.dart';
import 'package:qwid/assets/style.dart';

class SettingsOption extends StatelessWidget {
  final String text, subtext;
  final bool? toggle;
  final Function(bool)? onChanged;
  final Widget? route;
  const SettingsOption({
    Key? key,
    required this.text,
    required this.subtext,
    this.toggle,
    this.onChanged,
    this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (route != null) {
          Navigation.push(
            route!,
            context,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const CustomTextStyle(
                      color: CustomColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    subtext,
                    style: const CustomTextStyle(
                      color: CustomColors.labelText,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            if (toggle != null)
              CupertinoSwitch(
                value: toggle!,
                trackColor: CustomColors.labelText.withOpacity(0.25),
                activeColor: CustomColors.primary,
                onChanged: onChanged,
              )
            else
              Container(
                alignment: Alignment.center,
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  color: CustomColors.white,
                  shape: BoxShape.circle,
                ),
                child: RotatedBox(
                  quarterTurns: -1,
                  child: CustomIcon(
                    height: 16,
                    icon: 'down',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
