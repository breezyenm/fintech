import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';

class SettingsCard extends StatefulWidget {
  final bool destructive;
  final String title;
  final String? subtitle;
  final Widget? settings;
  final Function()? onPressed;
  const SettingsCard({
    Key? key,
    required this.title,
    this.destructive = false,
    this.subtitle,
    this.settings,
    this.onPressed,
  }) : super(key: key);

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool _open = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onPressed ??
              () {
                if (widget.settings != null) {
                  setState(() {
                    _open = !_open;
                  });
                }
              },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: CustomColors.white,
              border: Border.all(
                color: CustomColors.stroke,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(_open ? 4 : 8),
                top: const Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: CustomTextStyle(
                      color: widget.destructive
                          ? CustomColors.red
                          : CustomColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: widget.settings == null
                        ? Colors.transparent
                        : CustomColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: RotatedBox(
                    quarterTurns: (_open && widget.settings != null) ? 0 : -1,
                    child: CustomIcon(
                      height: 16,
                      icon: 'down',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_open)
          const SizedBox(
            height: 4,
          ),
        if (_open)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: CustomColors.white,
              border: Border.all(
                color: CustomColors.stroke,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(_open ? 4 : 8),
                bottom: const Radius.circular(8),
              ),
            ),
            child: widget.settings,
          ),
      ],
    );
  }
}
