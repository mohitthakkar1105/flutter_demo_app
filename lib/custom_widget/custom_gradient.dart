import 'package:flutter/material.dart';

class CustomGradient {
  final List<Color> colors;
  final List<double>? stops;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const CustomGradient({
    required this.colors,
    this.stops,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  LinearGradient get gradient => LinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
  );
}
