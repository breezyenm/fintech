import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';
import '../style.dart';

class CustomTextField extends TextFormField {
  CustomTextField({
    Key? key,
    FocusNode? focusNode,
    Function(String)? function,
    Function()? onTap,
    TextInputAction? textInputAction,
    bool enabled = true,
    bool? enabledColor,
    Color? hintColor,
    Color? styleColor,
    bool? borderless,
    bool? obscure,
    Widget? prefix,
    Widget? suffix,
    TextEditingController? controller,
    Color? color,
    Color? borderColor,
    double? fontSize,
    double? styleFontSize,
    int? minLines,
    int? maxLines,
    int? maxLength,
    double radius = 5,
    Iterable<String>? autofillHints,
    TextInputType type = TextInputType.text,
    String? hint,
    String? label,
    String? errorText,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          focusNode: focusNode,
          onTap: onTap,
          onFieldSubmitted: function,
          textInputAction: textInputAction ?? TextInputAction.done,
          enabled: enabled,
          textCapitalization: obscure != null
              ? TextCapitalization.none
              : TextCapitalization.sentences,
          controller: controller,
          obscureText: obscure ?? false,
          keyboardType: (hint?.toLowerCase().contains('email') ?? false)
              ? TextInputType.emailAddress
              : type,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            // isDense: true,
            enabled: enabled,
            fillColor: CustomColors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: CustomColors.primary,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: CustomColors.stroke,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: CustomColors.stroke,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: CustomColors.stroke,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: CustomColors.primary,
              ),
            ),
            hintText: hint,
            hintStyle: CustomTextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: CustomColors.labelText.withOpacity(0.5),
            ),
            prefixIcon: prefix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 16,
                    ),
                    child: prefix,
                  ),
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 24,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 16,
              ),
              child: suffix,
            ),
            suffixIconConstraints: const BoxConstraints(
              maxHeight: 24,
            ),
          ),
          style: CustomTextStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize ?? 16,
            color: CustomColors.text,
          ),
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines ?? minLines ?? 1,
          maxLength: maxLength,
          maxLengthEnforcement:
              maxLength == null ? null : MaxLengthEnforcement.enforced,
          validator: (value) {
            if (!enabled ||
                (label?.toLowerCase().contains('optional') ?? false)) {
              return null;
            }
            if (obscure != null && value!.length < 6) {
              return 'Password 8 characters min';
            } else if (value == null || value.isEmpty) {
              return 'Input field';
            }

            return null;
          },
        );
}
