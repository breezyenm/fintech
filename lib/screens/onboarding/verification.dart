// import 'package:qwid/assets/buttons/button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qwid/assets/colors.dart';
// import 'package:qwid/assets/navigation.dart';
// import 'package:qwid/assets/style.dart';
// import 'package:qwid/providers/API/auth.dart';
// import 'package:qwid/providers/data/auth.dart';
// import 'package:qwid/screens/onboarding/components/verification_document.dart';
// import 'package:qwid/skeletons/onboarding.dart';

// import 'login.dart';

// class Verification extends StatefulWidget {
//   const Verification({Key? key}) : super(key: key);

//   @override
//   State<Verification> createState() => _VerificationState();
// }

// class _VerificationState extends State<Verification> {
//   bool loading = false;
//   bool error = false;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthData>(builder: (context, data, child) {
//       return Onboarding(
//         title: 'Verify your account',
//         subtitle: 'Provide the required documents to continue',
//         image: '3',
//         body: [
//           GridView.builder(
//             primary: false,
//             padding: const EdgeInsets.symmetric(
//               horizontal: 16,
//             ),
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.75,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//             ),
//             itemBuilder: (context, index) {
//               return VerificationDocument(
//                 document: data.documents[index],
//               );
//             },
//             itemCount: data.documents.length,
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           if (error)
//             Text(
//               "One or more uploads remaining",
//               style: CustomTextStyle(
//                 color: CustomColors.text.withOpacity(0.5),
//                 fontFamily: 'Montserrat',
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           if (error)
//             const SizedBox(
//               height: 24,
//             ),
//           Consumer<AuthAPI>(builder: (context, api, child) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 16,
//               ),
//               child: CustomButton(
//                 text: loading ? 'loading' : 'Verify',
//                 onPressed: () async {
//                   if (data.supportedFiles.length == data.documents.length) {
//                     setState(() {
//                       error = false;
//                       loading = true;
//                     });
//                     await api.verify(context);
//                     if (mounted) {
//                       setState(() {
//                         loading = false;
//                       });
//                     }
//                   } else {
//                     setState(() {
//                       error = true;
//                     });
//                   }
//                 },
//               ),
//             );
//           }),
//           const SizedBox(
//             height: 24,
//           ),
//           Consumer<AuthData>(builder: (context, data, child) {
//             return InkWell(
//               onTap: () async {
//                 await Navigation.replaceAll(
//                   const LoginPage(),
//                   context,
//                 );
//                 data.user = null;
//               },
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   Text(
//                     'Back to login',
//                     style: CustomTextStyle(
//                       color: CustomColors.primary,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 11.5,
//                   ),
//                   Icon(
//                     Icons.arrow_forward_ios_rounded,
//                     color: CustomColors.primary,
//                     size: 10,
//                   ),
//                 ],
//               ),
//             );
//           }),
//           const SizedBox(
//             height: 24,
//           ),
//         ],
//       );
//     });
//   }
// }
