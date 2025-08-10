//
// import 'package:animation_world/animated_cards/components/my_data.dart';
//
// import 'package:flutter/material.dart';
//
// class BottomLinks extends StatelessWidget {
//   final DummyData dummyData;
//   const BottomLinks({super.key, required this.dummyData});
//
//   Color _getBackgroundColor(BackgroundStyle background) {
//     if (background is SolidColorBackground) {
//       return background.color;
//     }
//     if (background is GradientBackground) {
//       return background.colors.first;
//     }
//     return Colors.black;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       color: Colors.white,
//       child: Container(
//         margin: EdgeInsets.all(14),
//         padding: EdgeInsets.all(3),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4.0),
//           color:
//               dummyData.bgColor is SolidColorBackground
//                   ? (dummyData.bgColor as SolidColorBackground).color
//                   : null,
//           gradient:
//               dummyData.bgColor is GradientBackground
//                   ? (dummyData.bgColor as GradientBackground).gradient
//                   : null,
//         ),
//         height: 90,
//         width: double.infinity,
//         child: Container(
//           height: 90,
//           padding: EdgeInsets.all(8),
//           width: double.infinity,
//           color: Colors.white,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             spacing: 12,
//             children: [
//               Image.asset(dummyData.logo, height: 60),
//               Text(
//                 dummyData.linkText,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Oswald',
//                   color: _getBackgroundColor(dummyData.bgColor),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
