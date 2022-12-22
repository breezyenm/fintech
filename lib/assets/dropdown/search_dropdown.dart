import 'package:flutter/material.dart';
import 'package:qwid/assets/colors.dart';
import 'package:qwid/assets/icon.dart';
import 'package:qwid/assets/style.dart';

class SearchDropdown extends StatelessWidget {
  final String? text, leading;
  final String hint, label;
  final Widget? icon;
  const SearchDropdown({
    Key? key,
    this.text,
    required this.hint,
    required this.icon,
    required this.label,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: CustomTextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: CustomColors.labelText.withOpacity(0.5),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.stroke,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              if (leading != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'icons/flags/png/$leading.png',
                    package: 'country_icons',
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: CustomColors.stroke,
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ),
              if (leading != null)
                const SizedBox(
                  width: 12,
                ),
              Expanded(
                child: Text(
                  text ?? hint,
                  style: CustomTextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: text == null
                        ? CustomColors.labelText.withOpacity(0.5)
                        : CustomColors.text,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                alignment: Alignment.center,
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: CustomColors.background,
                ),
                child: icon ??
                    CustomIcon(
                      height: 16,
                      icon: 'down',
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
