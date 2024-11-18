import 'package:fitness_metrics/ui/athlete/settings_evaluation/components/body_composition.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/components/load_management.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/components/wellness.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EvaluationController extends GetxController {
  // main evaluation
  List<Widget> evaluationList = [
    const BodyComposition(),
    const Wellness(),
    const LoadManagement(),
  ];

  RxInt selectedEvaluation = 0.obs;

  void selectBody(int index) {
    selectedEvaluation.value = index;
  }

  // body composition
  RxString compositionType = 'Weight'.obs;

  List<String> compositionList = [
    'Weight',
    'Measurement',
    'Progress Photo',
  ];

}

