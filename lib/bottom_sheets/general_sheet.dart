import 'package:flutter/material.dart';
import 'package:qwid/assets/buttons/button.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/style.dart';

class GeneralSheet extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? buttonText;
  final Function()? onPressed;
  final List<Widget> body;

  const GeneralSheet(
      {super.key,
      required this.title,
      this.subtitle,
      this.buttonText,
      this.onPressed,
      required this.body});

  @override
  State<GeneralSheet> createState() => _GeneralSheetState();
}

class _GeneralSheetState extends State<GeneralSheet> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: BottomSheet(
        backgroundColor: CustomColors.white,
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          return SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 44),
              child: ListView(
                shrinkWrap: true,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  Center(
                    child: Container(
                      height: 3,
                      width: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: CustomColors.labelText.withOpacity(0.25),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Text(
                      widget.title,
                      style: const CustomTextStyle(
                        color: CustomColors.text,
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (widget.subtitle != null)
                    const SizedBox(
                      height: 8,
                    ),
                  if (widget.subtitle != null)
                    Center(
                      child: Text(
                        widget.subtitle!,
                        style: CustomTextStyle(
                          color: CustomColors.text.withOpacity(0.5),
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 24,
                  ),
                  ...widget.body,
                  if (widget.buttonText != null)
                    const SizedBox(
                      height: 24,
                    ),
                  if (widget.buttonText != null)
                    Center(
                      child: CustomButton(
                        text: widget.buttonText!,
                        onPressed: () {
                          if (_key.currentState?.validate() ?? false) {
                            widget.onPressed!();
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
