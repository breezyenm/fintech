import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors.dart';
import '../style.dart';

class LabelledField extends TextFormField {
  LabelledField({
    Key? key,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    bool enabled = true,
    bool? obscure,
    Widget? prefix,
    Widget? suffix,
    TextEditingController? controller,
    double? fontSize,
    int? minLines,
    int? maxLines,
    TextInputType type = TextInputType.text,
    required String hint,
    required String label,
    Function()? onEditingComplete,
    ValueChanged<String>? onChanged,
    Iterable<String>? autofillHints,
  }) : super(
          key: key,
          autofillHints: autofillHints,
          enableIMEPersonalizedLearning: true,
          enableInteractiveSelection: true,
          enableSuggestions: true,
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          textInputAction: textInputAction,
          enabled: enabled,
          textCapitalization: obscure != null
              ? TextCapitalization.none
              : TextCapitalization.sentences,
          controller: controller,
          obscureText: obscure ?? false,
          keyboardType: label.toLowerCase().contains('email')
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
            labelStyle: const CustomTextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: CustomColors.labelText,
            ),
            floatingLabelStyle: const CustomTextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: CustomColors.labelText,
            ),
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
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
            fontWeight: FontWeight.w400,
            fontSize: fontSize ?? 16,
            color: CustomColors.labelText,
          ),
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          validator: (value) {
            if (obscure != null && value!.length < 6) {
              return 'Password 8 characters min';
            } else if (value == null || value.isEmpty) {
              return 'Input field';
            }

            return null;
          },
        );
}
