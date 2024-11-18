import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';

class BaseColumn extends StatelessWidget {
  final List<Widget> children;
  final int? milliseconds;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final double? leftPadding, rightPadding, topPadding, bottomPadding;

  const BaseColumn(
      {super.key,
      required this.children,
      this.milliseconds,
      this.crossAxisAlignment,
      this.mainAxisAlignment,
      this.mainAxisSize,
      this.leftPadding,
      this.rightPadding,
      this.topPadding,
      this.bottomPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: rightPadding ?? horizontalScreenPadding,
          left: leftPadding ?? horizontalScreenPadding),
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        children: children,
      ),
    );
  }
}
