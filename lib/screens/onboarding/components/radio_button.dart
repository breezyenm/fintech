// import 'package:flutter/material.dart';
// import 'package:qwid/assets/colors.dart';
// import 'package:qwid/providers/data/auth_provider.dart';
// import 'package:provider/provider.dart';

// class RadioButton extends StatelessWidget {
//   final String tag;
//   const RadioButton({Key? key, required this.tag}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthProvider>(
//       builder: (context, authPro, chi9ld) {
//         return Container(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 20,
//           ),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: authPro.provider == tag
//                   ? CustomColors.primary
//                   : CustomColors.grey6,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
