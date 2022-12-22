// import 'package:flutter/material.dart';
// import 'package:qwid/assets/button.dart';
// import 'package:qwid/assets/colors.dart';
// import 'package:qwid/assets/dropdown/labelled_dropdown.dart';
// import 'package:qwid/assets/icon.dart';
// import 'package:qwid/assets/navigation.dart';
// import 'package:qwid/assets/style.dart';
// import 'package:qwid/screens/home/pages/home/summary.dart';
// import 'package:qwid/skeletons/scrollable_full.dart';

// class HomeDetails extends StatelessWidget {
//   const HomeDetails({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: const Text(
//           'Find a Service Provider',
//         ),
//       ),
//       body: ScrollableFullPage(
//         children: [
//           const Text(
//             'Address',
//             style: CustomTextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               color: CustomColors.grey3,
//             ),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           ListTile(
//             dense: true,
//             visualDensity: VisualDensity.compact,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 side: const BorderSide(
//                   color: CustomColors.grey7,
//                 )),
//             tileColor: CustomColors.grey9,
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 16,
//               vertical: 12,
//             ),
//             title: const Text(
//               '9 Olusnaya Close, Ikeja, Lagos, Nigeria',
//               style: CustomTextStyle(
//                 color: CustomColors.black,
//                 fontWeight: FontWeight.w400,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//             trailing: CustomIcon(
//               height: 24,
//               icon: 'close',
//             ),
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           LabelledDropdown(
//             onChanged: (value) {},
//             hint: 'Choose house type',
//             items: const ['Duplex', 'Bungalow'],
//             label: 'House Type',
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           LabelledDropdown(
//             onChanged: (value) {},
//             hint: 'How many',
//             items: const ['0', '1', '2'],
//             label: 'Number of rooms',
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           LabelledDropdown(
//             onChanged: (value) {},
//             hint: 'How many',
//             items: const ['0', '1', '2'],
//             label: 'Number of living room',
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           LabelledDropdown(
//             onChanged: (value) {},
//             hint: 'How many?',
//             items: const ['0', '1', '2'],
//             label: 'Number of bathrooms/toilets',
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           LabelledDropdown(
//             onChanged: (value) {},
//             hint: 'How many?',
//             items: const ['0', '1', '2'],
//             label: 'Kitchen',
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           Container(
//             color: CustomColors.green10,
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   'Total',
//                   style: CustomTextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: CustomColors.green2,
//                   ),
//                 ),
//                 Text(
//                   '₦20,000',
//                   style: CustomTextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: CustomColors.green2,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           CustomButton(
//             text: 'Next',
//             context: context,
//             onPressed: () {
//               Navigation.push(
//                 const Summary(),
//                 context,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
