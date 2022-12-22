import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/screens/home/components/copy.dart';

class SummaryInfo extends StatefulWidget {
  final String title, info;
  final Widget? infoWidget;
  final String? subInfo, warning;
  final Map<String, String> moreDetails;
  final bool copyable;
  final Color? infoColor;
  final Function()? onTap, subInfoFunction;
  const SummaryInfo({
    Key? key,
    required this.title,
    required this.info,
    this.subInfo,
    this.warning,
    this.copyable = false,
    this.onTap,
    this.subInfoFunction,
    this.moreDetails = const {},
    this.infoWidget,
    this.infoColor,
  }) : super(key: key);

  @override
  State<SummaryInfo> createState() => _SummaryInfoState();
}

class _SummaryInfoState extends State<SummaryInfo> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: CustomTextStyle(
              color: CustomColors.labelText.withOpacity(0.5),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          widget.infoWidget ??
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      widget.info,
                      style: CustomTextStyle(
                        color: widget.infoColor ?? CustomColors.labelText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if ((widget.copyable && widget.info.isNotEmpty) ||
                      widget.moreDetails.isNotEmpty)
                    const SizedBox(
                      width: 16,
                    ),
                  if (widget.copyable && widget.info.isNotEmpty)
                    Copy(text: widget.info)
                  else if (widget.moreDetails.isNotEmpty)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 24,
                        width: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColors.background,
                        ),
                        child: RotatedBox(
                          quarterTurns: _expanded ? 2 : 0,
                          child: CustomIcon(
                            height: 16,
                            icon: 'down',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          if ((widget.subInfo ?? widget.warning) != null)
            const SizedBox(
              height: 4,
            ),
          if ((widget.subInfo ?? widget.warning) != null)
            InkWell(
              onTap: widget.subInfoFunction,
              child: Text(
                (widget.subInfo ?? widget.warning)!,
                style: CustomTextStyle(
                  color: widget.subInfoFunction != null
                      ? CustomColors.darkPrimary
                      : widget.warning != null
                          ? CustomColors.red.withOpacity(0.5)
                          : CustomColors.labelText,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  decoration: widget.subInfoFunction != null
                      ? TextDecoration.underline
                      : null,
                ),
              ),
            ),
          if (widget.moreDetails.isNotEmpty && _expanded)
            const Divider(
              height: 32,
            ),
          if (widget.moreDetails.isNotEmpty && _expanded)
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.moreDetails.entries.toList()[index].key,
                    style: CustomTextStyle(
                      color: CustomColors.labelText.withOpacity(0.5),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.moreDetails.entries.toList()[index].value,
                    style: const CustomTextStyle(
                      color: CustomColors.labelText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              separatorBuilder: (context, index) => const Divider(
                height: 32,
              ),
              itemCount: widget.moreDetails.length,
            ),
        ],
      ),
    );
  }
}
