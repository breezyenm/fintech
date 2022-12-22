// import 'package:flutter/material.dart';

// class RadioItem extends StatelessWidget {
//   final bool selected;
//   final String label;

//   const RadioItem({Key? key, this.selected = false, required this.label})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       child: Row(
//         children: [
//           Container(
//             height: 24,
//             width: 24,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: selected
//                     ? SwirgeColors.primary
//                     : (Provider.of<DarkModeProvider>(context).darkMode ==
//                             DarkMode.Off
//                         ? SwirgeColors.line
//                         : SwirgeDarkColors.line),
//                 width: 4,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 8,
//           ),
//           Text(
//             label,
//             style: CustomTextStyle(
//               context,
//               color: Provider.of<DarkModeProvider>(context).darkMode ==
//                       DarkMode.Off
//                   ? SwirgeColors.labelText
//                   : SwirgeDarkColors.labelText,
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
