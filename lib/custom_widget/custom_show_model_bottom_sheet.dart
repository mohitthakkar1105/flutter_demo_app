import 'package:flutter/material.dart';

class CustomBottomSheet {
  static Future<void> show(
      BuildContext context, {
        required Widget child,

        bool isDismissible = true,
        bool isScrollControlled = true,
        bool enableDrag = true,

        Color backgroundColor = Colors.transparent,

        ShapeBorder? shape,
      }) {
    return showModalBottomSheet(
      context: context,

      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,

      backgroundColor: backgroundColor,
      shape: shape,

      builder: (_) => child,
    );
  }
}

//use :- >

// STEP 1
// CustomBottomSheet.show(
// context,
// child: const MyBottomSheet(),
// );

//STEP 2
// import 'package:flutter/material.dart';
//
// class MyBottomSheet extends StatelessWidget {
//   const MyBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     // Your Sizer
//     final sizer = Sizer();
//     sizer.init(context);
//
//     return Container(
//       height: sizer.setHeight(300),
//       width: double.infinity,
//
//       padding: const EdgeInsets.all(20),
//
//       decoration: const BoxDecoration(
//         color: Colors.white,
//
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(25),
//         ),
//       ),
//
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Hello Bhai",
//             style: TextStyle(
//               fontSize: sizer.setSp(20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }