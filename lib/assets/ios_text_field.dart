// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'colors.dart';
// import 'style.dart';

// class CustomIosTextField extends CupertinoTextField {
//   final bool enabled;
//   final bool? enabledColor;
//   final TextEditingController? controller;
//   final bool? obscure, borderless;
//   final Color? color;
//   final Color? styleColor;
//   final Color? hintColor;
//   final Color? borderColor;
//   final Widget? suffix;
//   final String? label;
//   final String? errorText;
//   final double? fontSize;
//   final double? styleFontSize;
//   final int? minLines;
//   final int? maxLines;
//   final double radius;
//   final ValueChanged<String>? onChanged;
//   final TextInputType type;
//   final TextInputAction? textInputAction;
//   final Function(String)? function;
//   final Function()? onTap;

//   CustomIosTextField(
//     BuildContext context, {
//     this.function,
//     this.onTap,
//     this.labelTextInputAction,
//     this.enabled = true,
//     this.enabledColor,
//     this.hintColor,
//     this.styleColor,
//     this.borderless,
//     this.obscure,
//     this.suffix,
//     this.controller,
//     this.color,
//     this.borderColor,
//     this.fontSize,
//     this.styleFontSize,
//     this.minLines,
//     this.maxLines,
//     this.radius = 5,
//     this.type = TextInputType.multiline,
//     this.label,
//     this.errorText,
//     this.onChanged,
//   }) : super(
//           onTap: onTap,
//           // onFieldSubmitted: function,
//           cursorColor: SwirgeColors.primary,
//           padding: EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 12,
//           ),
//           strutStyle: StrutStyle.disabled,
//           // cursorHeight: 20,
//           textInputAction: textInputAction,
//           enabled: enabled,
//           textCapitalization: obscure != null
//               ? TextCapitalization.none
//               : TextCapitalization.sentences,
//           controller: controller,
//           obscureText: obscure == null ? false : obscure,
//           textAlignVertical: TextAlignVertical.center,
//           keyboardType: type,
//           placeholder: label,
//           placeholderStyle: CustomTextStyle(
//             context,
//             fontSize: fontSize ?? 16,
//             color:
//                 Provider.of<DarkModeProvider>(context).darkMode == DarkMode.Off
//                     ? SwirgeColors.secondaryText
//                     : SwirgeDarkColors.secondaryText.withOpacity(0.5),
//           ),
//           suffix: suffix,
//           style: CustomTextStyle(
//             context,
//             fontWeight: FontWeight.w500,
//             fontSize: fontSize ?? 20,
//             color: styleColor ??
//                 (Provider.of<DarkModeProvider>(context).darkMode == DarkMode.Off
//                     ? SwirgeColors.labelText
//                     : SwirgeDarkColors.labelText),
//           ),
//           decoration: BoxDecoration(
//               color: Provider.of<DarkModeProvider>(context).darkMode ==
//                       DarkMode.Off
//                   ? SwirgeColors.field
//                   : SwirgeDarkColors.field,
//               border: Border.all(
//                 color: Provider.of<DarkModeProvider>(context).darkMode ==
//                         DarkMode.Off
//                     ? SwirgeColors.line
//                     : SwirgeDarkColors.line,
//               ),
//               borderRadius: BorderRadius.circular(11)),
//           onChanged: onChanged,
//           minLines: minLines,
//           maxLines: maxLines == null ? 1 : maxLines,
//         );
// }
