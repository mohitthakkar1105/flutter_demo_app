import 'package:flutter/material.dart';

class Textfield extends StatefulWidget {
  const Textfield({super.key});

  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _controller,
          style: const TextStyle(
            color: Colors.orange,
          ),
          decoration: InputDecoration(
            hintText: "Enter your name",
            labelText: "Name",
            prefixIcon: GestureDetector(
              onTap: () {
                _controller.text = "";
              },
              child: Icon(Icons.person),
            ),
            suffixIcon: Icon(Icons.clear),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
//
// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     this.labelText,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.obscureText = false,
//     this.keyboardType,
//   });
//
//   final TextEditingController controller;
//   final String hintText;
//   final String? labelText;
//   final IconData? prefixIcon;
//   final IconData? suffixIcon;
//   final bool obscureText;
//   final TextInputType? keyboardType;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//
//       style: const TextStyle(
//         color: Colors.black,
//       ),
//
//       decoration: InputDecoration(
//         hintText: hintText,
//         labelText: labelText,
//
//         prefixIcon: prefixIcon != null
//             ? Icon(prefixIcon)
//             : null,
//
//         suffixIcon: suffixIcon != null
//             ? Icon(suffixIcon)
//             : null,
//
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }