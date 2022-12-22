// import 'package:flutter/material.dart';
// import 'package:qwid/assets/button.dart';
// import 'package:qwid/assets/colors.dart';
// import 'package:qwid/assets/icon.dart';
// import 'package:qwid/assets/style.dart';

// class GeneralPopup extends StatelessWidget {
//   final String title, subtitle, buttonText, icon;
//   final Function() buttonFunction;
//   const GeneralPopup({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//     required this.buttonText,
//     required this.buttonFunction,
//     required this.icon,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const CustomTextStyle(
//               color: CustomColors.black,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           CustomIcon(
//             height: 24,
//             icon: 'close',
//           ),
//         ],
//       ),
//       content: Column(
//         children: [
//           Container(
//             alignment: Alignment.center,
//             height: 120,
//             width: 120,
//             decoration: const BoxDecoration(
//               color: CustomColors.red10,
//               shape: BoxShape.circle,
//             ),
//             child: CustomIcon(
//               height: 80,
//               icon: icon,
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           Text(
//             subtitle,
//             style: const CustomTextStyle(
//               color: CustomColors.grey3,
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           CustomButton(
//             text: buttonText,
//             context: context,
//             onPressed: buttonFunction,
//           ),
//         ],
//       ),
//     );
//   }
// }
