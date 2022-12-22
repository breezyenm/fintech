// import 'package:flutter/material.dart';
// import 'package:qwid/assets/colors.dart';
// import 'package:qwid/assets/icon.dart';
// import 'package:qwid/assets/style.dart';
// import 'package:qwid/providers/data/requests_provider.dart';
// import 'package:qwid/screens/home/components/request_action.dart';
// import 'package:qwid/screens/home/components/summary_items.dart';
// import 'package:qwid/skeletons/scrollable_full.dart';
// import 'package:provider/provider.dart';

// class History extends StatelessWidget {
//   const History({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<RequestsProvider>(builder: (context, rPro, chi9ld) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Request History',
//           ),
//         ),
//         body: ScrollableFullPage(
//           children: [
//             Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 20,
//                   backgroundColor: CustomColors.blue10,
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Olamide Adeyemi',
//                       style: CustomTextStyle(
//                         color: CustomColors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         CustomIcon(
//                           height: 12,
//                           icon: 'star',
//                         ),
//                         const SizedBox(
//                           width: 2,
//                         ),
//                         CustomIcon(
//                           height: 12,
//                           icon: 'star',
//                         ),
//                         const SizedBox(
//                           width: 2,
//                         ),
//                         CustomIcon(
//                           height: 12,
//                           icon: 'star',
//                         ),
//                         const SizedBox(
//                           width: 2,
//                         ),
//                         CustomIcon(
//                           height: 12,
//                           icon: 'star',
//                         ),
//                         const SizedBox(
//                           width: 2,
//                         ),
//                         CustomIcon(
//                           height: 12,
//                           icon: 'unstar',
//                         ),
//                         const SizedBox(
//                           width: 2,
//                         ),
//                         const Text(
//                           '4.5',
//                           style: CustomTextStyle(
//                             color: CustomColors.yellow3,
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             ...summaryItems,
//             const SizedBox(
//               height: 16,
//             ),
//             const Divider(
//               thickness: 0.5,
//               color: CustomColors.grey7,
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 6,
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         height: 8,
//                         width: 8,
//                         decoration: BoxDecoration(
//                           color: rPro.statusColors['in transit'],
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 28,
//                         child: VerticalDivider(
//                           width: 0,
//                           color: CustomColors.grey7,
//                         ),
//                       ),
//                       Container(
//                         height: 8,
//                         width: 8,
//                         decoration: BoxDecoration(
//                           color: rPro.statusColors['arrived'],
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 28,
//                         child: VerticalDivider(
//                           width: 0,
//                           color: CustomColors.grey7,
//                         ),
//                       ),
//                       Container(
//                         height: 8,
//                         width: 8,
//                         decoration: BoxDecoration(
//                           color: rPro.statusColors['in progress'],
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'In transit at 11:20 AM',
//                       style: CustomTextStyle(
//                         color: CustomColors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     Text(
//                       'Arrived at 11:30 AM',
//                       style: CustomTextStyle(
//                         color: CustomColors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     Text(
//                       'Job in Progress',
//                       style: CustomTextStyle(
//                         color: CustomColors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             const Divider(
//               thickness: 0.5,
//               color: CustomColors.grey7,
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 RequestAction(
//                   color: CustomColors.blue10,
//                   text: 'Call',
//                   icon: 'call',
//                 ),
//                 SizedBox(
//                   width: 40,
//                 ),
//                 RequestAction(
//                   color: CustomColors.green10,
//                   text: 'Message',
//                   icon: 'message',
//                 ),
//                 SizedBox(
//                   width: 40,
//                 ),
//                 RequestAction(
//                   color: CustomColors.red10,
//                   text: 'Cancel job',
//                   icon: 'cancel',
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
