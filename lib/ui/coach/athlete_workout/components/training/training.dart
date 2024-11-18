import 'package:fitness_metrics/ui/coach/athlete_workout/components/training/components/training_cards.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/controller/training_preference_controller.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Training extends StatefulWidget {
  const Training({super.key});

  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {

  late TrainingPreferenceController trainingPreferenceCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<TrainingPreferenceController>();
    trainingPreferenceCtrl = Get.put(TrainingPreferenceController());
    trainingPreferenceCtrl.coachWorkoutPreferenceQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: trainingPreferenceCtrl.preferenceList.length,
        itemBuilder: (context, index) {
          return TrainingCards(
            itemIndex: index,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            buildSizeHeight(12),
      );
    });
  }
}
