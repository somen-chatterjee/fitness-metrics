import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomisedGreyErrorScreen extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const CustomisedGreyErrorScreen({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BaseColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BaseText(
              value: kDebugMode
                  ? errorDetails.summary.toString()
                  : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
            )
          ],
        ),
      ),
    );
  }
}
