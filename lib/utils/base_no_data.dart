
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';

class BaseNoData extends StatelessWidget {
  final String? message;
  final Color? textColor;

  const BaseNoData({super.key, this.message, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           SizedBox(
            height: 100,
              child: OverflowBox(
                minHeight: 180,
                maxHeight: 180,
                minWidth: 180,
                maxWidth: 180,
                  child: Lottie.asset(
                      BaseAssets.noDataFoundJson,
                    height: 200,
                    width: 200
                  ),
              ),
          ),
          buildSizeHeight(20),
          BaseText(
            value: message ?? "No Data Found!",
            fontSize: 16,
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
