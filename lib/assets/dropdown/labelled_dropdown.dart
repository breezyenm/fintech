import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/dropdown/dropdown_field.dart';
import 'package:qwid/assets/style.dart';

class LabelledDropdown extends StatefulWidget {
  final List<String>? items;
  final String? label, value;
  final String hint;
  final bool? enabled;
  final Widget? prefix, icon;
  final Function(String?) onChanged;
  const LabelledDropdown({
    Key? key,
    this.label,
    required this.hint,
    this.prefix,
    this.icon,
    this.items,
    this.value,
    required this.onChanged,
    this.enabled,
  }) : super(key: key);

  @override
  State<LabelledDropdown> createState() => _LabelledDropdownState();
}

class _LabelledDropdownState extends State<LabelledDropdown> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: CustomTextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: CustomColors.labelText.withOpacity(0.5),
            ),
          ),
        if (widget.label != null)
          const SizedBox(
            height: 8,
          ),
        CustomDropdownField(
          enabled: widget.enabled ?? true,
          icon: widget.icon,
          value: widget.value,
          focusNode: myFocusNode,
          hint: widget.hint,
          items: widget.items,
          onChanged: widget.onChanged,
          prefix: widget.prefix,
        ),
      ],
    );
  }
}
