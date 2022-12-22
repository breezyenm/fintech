// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:qwid/assets/colors.dart';
// import 'package:qwid/assets/icon.dart';
// import 'package:qwid/assets/navigation.dart';

// class Unavailable extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   const Unavailable(
//       {Key? key,
//       this.title = 'No Available Service Provider',
//       this.subtitle =
//           'There is no service provider available for instant service'})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoAlertDialog(
//       title: Text(title),
//       content: Column(
//         children: [
//           const SizedBox(
//             height: 16,
//           ),
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
//               icon: 'unavailable',
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           Text(
//             subtitle,
//           ),
//         ],
//       ),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           onPressed: () {},
//           child: const Text(
//             'Check Again',
//           ),
//         ),
//         CupertinoDialogAction(
//           onPressed: () {
//             Navigation.pop(context);
//           },
//           child: const Text(
//             'Dismiss & Save Draft',
//           ),
//         ),
//       ],
//     );
//   }
// }
