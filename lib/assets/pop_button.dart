// import 'package:flutter/material.dart';

// import 'colors.dart';

// class PopButton extends StatelessWidget {
//   final IconData icon;
//   final double size;
//   final Color? color;
//   final Color? containerColor;
//   final Function()? function;
//   final bool loading;

//   const PopButton({
//     Key? key,
//     this.size = 28,
//     this.loading = false,
//     this.containerColor,
//     this.function,
//     this.color,
//     this.icon = Icons.arrow_back_rounded,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(200),
//       onTap: function ??
//           () {
//             if (!loading) Navigation.pop(context);
//           },
//       child: Container(
//         alignment: Alignment.center,
//         height: 32,
//         width: 32,
//         decoration: BoxDecoration(
//           color: containerColor,
//           shape: BoxShape.circle,
//         ),
//         child: Icon(
//           icon,
//           color: loading
//               ? Provider.of<DarkModeProvider>(context).darkMode == DarkMode.Off
//                   ? SwirgeColors.secondaryText
//                   : SwirgeDarkColors.secondaryText
//               : color ??
//                   (Provider.of<DarkModeProvider>(context).darkMode ==
//                           DarkMode.Off
//                       ? SwirgeColors.labelText
//                       : SwirgeDarkColors.labelText),
//           size: size,
//         ),
//       ),
//     );
//   }
// }
