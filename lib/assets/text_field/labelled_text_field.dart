import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/obscure.dart';
import 'package:qwid/assets/style.dart';
import 'package:qwid/assets/text_field/text_field.dart';

class LabelledTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final int? minLines;
  final int? maxLength;
  final Iterable<String>? autofillHints;
  final TextInputType type;
  final TextInputAction? textInputAction;
  final Widget? prefix, suffix;
  final bool enabled;
  final Function()? onTap;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  const LabelledTextField({
    Key? key,
    this.label,
    this.hint,
    this.prefix,
    this.minLines,
    this.controller,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.suffix,
    this.type = TextInputType.text,
    this.autofillHints,
    this.textInputAction,
    this.maxLength,
  }) : super(key: key);

  @override
  State<LabelledTextField> createState() => _LabelledTextFieldState();
}

class _LabelledTextFieldState extends State<LabelledTextField> {
  late FocusNode myFocusNode;
  bool? _obscure;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _obscure = (widget.hint?.toLowerCase().contains('password') ?? false)
        ? true
        : null;

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
              fontWeight: FontWeight.w400,
              color: CustomColors.labelText.withOpacity(0.5),
            ),
          ),
        if (widget.label != null)
          const SizedBox(
            height: 8,
          ),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: widget.onTap,
          child: CustomTextField(
              type: widget.type,
              autofillHints: widget.autofillHints,
              textInputAction: widget.textInputAction,
              onChanged: widget.onChanged,
              // onTap: widget.onTap,
              enabled: widget.enabled,
              obscure: _obscure,
              hint: widget.hint,
              label: widget.label,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              prefix: widget.prefix,
              focusNode: myFocusNode,
              controller: widget.controller ?? _controller,
              suffix: widget.suffix ??
                  (_obscure == null
                      ? null
                      : InkWell(
                          onTap: () {
                            setState(() {
                              _obscure = !_obscure!;
                            });
                          },
                          child: Obscure(
                            obscure: _obscure!,
                          ),
                        ))),
        ),
      ],
    );
  }
}
