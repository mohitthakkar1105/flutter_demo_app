import 'dart:ui';

import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(
      BuildContext context, {
        required Widget content,
        // optional params (sab tum control karoge)
        Duration duration = const Duration(seconds: 3),
        Color? backgroundColor,
        SnackBarBehavior behavior = SnackBarBehavior.floating,
        EdgeInsetsGeometry? margin,
        ShapeBorder? shape,
        double? elevation,

        SnackBarAction? action,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: content,
        duration: duration, // duration by default persistent false hai
        backgroundColor: backgroundColor,
        behavior: behavior,
        margin: margin,
        shape: shape,
        elevation: elevation,
        action: action,
      ),
    );
  }
}