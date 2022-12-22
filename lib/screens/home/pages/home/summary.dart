// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:qwid/assets/button.dart';
// import 'package:qwid/popups/ios/unavailable.dart';
// import 'package:qwid/screens/home/components/summary_items.dart';
// import 'package:qwid/skeletons/scrollable_full.dart';

// class Summary extends StatelessWidget {
//   const Summary({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Summary'),
//       ),
//       body: ScrollableFullPage(
//         children: [
//           ...summaryItems,
//           const SizedBox(
//             height: 32,
//           ),
//           CustomButton(
//             text: 'Pay now',
//             context: context,
//             onPressed: () {
//               showCupertinoDialog(
//                 context: context,
//                 builder: (context) => const Unavailable(),
//               );
//             },
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           CustomButton(
//             text: 'Save Draft for Later',
//             context: context,
//             outlined: true,
//             onPressed: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }
