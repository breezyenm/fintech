// import 'package:flutter/material.dart';
// import 'package:qwid/assets/colors.dart';
// import 'package:qwid/assets/icon.dart';
// import 'package:qwid/assets/style.dart';

// class SignupButton extends StatelessWidget {
//   final String icon, text;
//   const SignupButton({Key? key, required this.icon, required this.labelText})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(8),
//       onTap: () {},
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: CustomColors.primary,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 12,
//         ),
//         margin: const EdgeInsets.symmetric(
//           horizontal: 16,
//         ),
//         width: double.infinity,
//         child: Row(
//           children: [
//             CustomIcon(
//               height: 24,
//               icon: icon,
//             ),
//             const SizedBox(
//               width: 16,
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 10,
//                 ),
//                 child: Text(
//                   text,
//                   style: const CustomTextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               width: 16,
//             ),
//             Container(
//               alignment: Alignment.center,
//               height: 24,
//               width: 24,
//               decoration: const BoxDecoration(
//                 color: CustomColors.background,
//                 shape: BoxShape.circle,
//               ),
//               child: CustomIcon(
//                 height: 12,
//                 icon: 'forward',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
