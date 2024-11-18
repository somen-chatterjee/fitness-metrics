import 'package:fitness_metrics/ui/athlete/settings_data/settings_data.dart';
import 'package:fitness_metrics/ui/athlete/settings_workout/settings_workout.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/settings_evaluation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SettingsController extends GetxController{

  List<Widget> bodyList = [
    const SettingsData(),
    const SettingsEvaluation(),
    const SettingsWorkout(),
  ];

  RxInt selectedIndex = 0.obs;

  void selectBody(int index) {
    selectedIndex.value = index;
  }

}