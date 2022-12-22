// import 'package:flutter/material.dart';
// import 'package:qwid/appbars/logo_appbar.dart';
// import 'package:qwid/assets/button.dart';
// import 'package:qwid/assets/colors.dart';
// import 'package:qwid/assets/icon.dart';
// import 'package:qwid/assets/navigation.dart';
// import 'package:qwid/assets/style.dart';
// import 'package:qwid/providers/data/auth_provider.dart';
// import 'package:qwid/screens/onboarding/login.dart';
// import 'package:qwid/skeletons/scrollable_full.dart';
// import 'package:provider/provider.dart';

// class Success extends StatelessWidget {
//   final String title, button;
//   final Function() onPressed;
//   const Success(
//       {Key? key,
//       required this.title,
//       required this.button,
//       required this.onPressed})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     return Consumer<AuthProvider>(builder: (context, authPro, chi9ld) {
//       return Scaffold(
//         appBar: LogoAppbar(
//           automaticallyImplyLeading: true,
//         ),
//         body: ScrollableFullPage(
//           children: [
//             const SizedBox(
//               height: 64,
//             ),
//             Container(
//               alignment: Alignment.center,
//               height: screenSize.width * 0.48,
//               width: screenSize.width * 0.48,
//               decoration: const BoxDecoration(
//                 color: CustomColors.blue10,
//                 shape: BoxShape.circle,
//               ),
//               child: CustomIcon(
//                 height: screenSize.width * 0.264,
//                 icon: 'verified',
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Text(
//               title,
//               style: const CustomTextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: CustomColors.black,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 32,
//             ),
//             CustomButton(
//               text: button,
//               context: context,
//               onPressed: onPressed,
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
