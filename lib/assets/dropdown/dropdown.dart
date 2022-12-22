import 'package:flutter/material.dart';

import '../colors.dart';
import '../style.dart';

class CustomDropdown extends DropdownButtonFormField<String> {
  CustomDropdown({
    Key? key,
    required String hint,
    required String label,
    bool isExpanded = true,
    String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) : super(
          key: key,
          isExpanded: isExpanded,
          value: value,
          items: items
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    style: const CustomTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: CustomColors.black,
                    ),
                  ),
                ),
              )
              .toList(),
          // iconSize: 24,
          elevation: 0,
          style: const CustomTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: CustomColors.black,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
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
          ),
        );
}
