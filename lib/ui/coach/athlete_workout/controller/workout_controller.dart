
import 'package:fitness_metrics/ui/coach/athlete_workout/components/archive/archive.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/training/training.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WorkoutController extends GetxController{

  List<Widget> bodyList = [
    const Archive(),
    const Training(),
  ];

  RxInt selectedIndex = 0.obs;

  void selectBody(int index) {
    selectedIndex.value = index;
  }
}