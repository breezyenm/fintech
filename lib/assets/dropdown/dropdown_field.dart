import 'package:flutter/material.dart';
import 'package:qwid/assets/icon.dart';

import '../colors.dart';
import '../style.dart';

class CustomDropdownField extends DropdownButtonFormField<String> {
  CustomDropdownField({
    Key? key,
    bool enabled = true,
    required String hint,
    required FocusNode focusNode,
    bool isExpanded = true,
    String? value,
    Widget? prefix,
    Widget? icon,
    List<String>? items,
    Map<String, Widget>? itemPrefix,
    required Function(String?) onChanged,
  }) : super(
          key: key,
          focusNode: focusNode,
          isExpanded: isExpanded,
          value: value,
          items: items
              ?.map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Row(
                    children: [
                      if (itemPrefix != null)
                        Container(
                          height: 16,
                          width: 23,
                          color: CustomColors.stroke,
                        ),
                      if (itemPrefix != null)
                        const SizedBox(
                          width: 8,
                        ),
                      Expanded(
                        child: Text(
                          e,
                          style: const CustomTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: CustomColors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
          icon: icon ??
              Container(
                alignment: Alignment.center,
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.background,
                ),
                child: CustomIcon(
                  height: 16,
                  icon: 'down',
                ),
              ),
          // iconSize: 24,
          elevation: 0,
          style: const CustomTextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: CustomColors.text,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            enabled: enabled,
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
            hintText: hint,
            hintStyle: CustomTextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: CustomColors.labelText.withOpacity(0.5),
            ),
          ),
          validator: (value) {
            if ((value ?? '').isEmpty) {
              return '${hint.trim().toLowerCase().contains('select') ? '' : 'Select'} ${hint.trim().toLowerCase() == 'select' ? '' : hint}';
            }

            return null;
          },
        );
}
