import 'package:flutter/material.dart';

class CustomDialog {
  static void show(
      BuildContext context, {
        required Widget child,
        bool barrierDismissible = true,
        EdgeInsets insetPadding =
        const EdgeInsets.all(20), // default value const hoti hai,[true,false,10,3.14,"hello",null] -->ye san automatic const
      }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: insetPadding,
          child: child,
        );
      },
    );
  }
}