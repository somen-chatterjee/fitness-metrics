import 'package:flutter/material.dart';
import 'base_colors.dart';

const double horizontalScreenPadding = 20;
const double baseContainerRadius = 28;
const int apiTimeOut = 30;

LinearGradient gradient = const LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomRight,
  colors: [
    BaseColors.gradient1,
    BaseColors.gradient2,
  ],
);

List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

class SplineData {
  SplineData(this.x, this.y);

  final String x;
  final double? y;
}