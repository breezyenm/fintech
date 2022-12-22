import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/screens/home/components/copy.dart';

import '../../../assets/style.dart';

class InfoCard extends StatelessWidget {
  final String title, info;
  final String? subInfo, actionText, warning;
  final Widget? subWidget;
  final Color? infoColor;
  final bool copyable, centered;
  final Function()? onTap, subInfoFunction, action;
  const InfoCard({
    Key? key,
    required this.title,
    required this.info,
    this.subInfo,
    this.copyable = false,
    this.onTap,
    this.subInfoFunction,
    this.infoColor,
    this.subWidget,
    this.action,
    this.actionText,
    this.warning,
    this.centered = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.white,
        border: Border.all(
          color: CustomColors.stroke,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
            centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: CustomTextStyle(
              color: CustomColors.labelText.withOpacity(0.5),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  info,
                  style: CustomTextStyle(
                    color: infoColor ?? CustomColors.labelText,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: centered ? TextAlign.center : TextAlign.start,
                ),
              ),
              if (copyable || action != null)
                const SizedBox(
                  width: 16,
                ),
              if (action != null)
                InkWell(
                  onTap: action,
                  child: Text(
                    actionText!,
                    style: const CustomTextStyle(
                      color: CustomColors.darkPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              else if (copyable)
                Copy(text: info),
            ],
          ),
          if ((subInfo ?? warning ?? subWidget) != null)
            const SizedBox(
              height: 4,
            ),
          if (subWidget != null)
            subWidget!
          else if ((subInfo ?? warning) != null)
            InkWell(
              onTap: subInfoFunction,
              child: Text(
                (subInfo ?? warning)!,
                style: CustomTextStyle(
                    color: subInfoFunction != null
                        ? CustomColors.primary
                        : warning != null
                            ? CustomColors.red.withOpacity(0.5)
                            : CustomColors.labelText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: subInfoFunction != null
                        ? TextDecoration.underline
                        : null),
              ),
            ),
        ],
      ),
    );
  }
}
