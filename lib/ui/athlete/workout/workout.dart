
import 'package:fitness_metrics/ui/athlete/settings_workout/settings_workout.dart';
import 'package:fitness_metrics/ui/athlete/workout/controller/workout_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Workout extends StatefulWidget {
  const Workout({super.key});

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  var workoutCtrl = Get.put(WorkoutController());

  @override
  void initState() {
    super.initState();
    workoutCtrl.selectBody(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Workouts',
            showBackIcon: false,
          ),
          buildSizeHeight(20),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalScreenPadding),
              child: SettingsWorkout(),
            ),
          ),
        ],
      ),
    );
  }
}
