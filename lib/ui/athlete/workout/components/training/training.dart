import 'package:fitness_metrics/ui/athlete/workout/components/training/components/training_cards.dart';
import 'package:fitness_metrics/ui/athlete/workout/controller/workout_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Training extends StatefulWidget {
  const Training({super.key});

  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
  final workoutCtrl = Get.find<WorkoutController>();

  @override
  void initState() {
    super.initState();
    workoutCtrl.getPreferenceQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: workoutCtrl.preferenceList.length,
              itemBuilder: (context, index) {
                return TrainingCards(
                  itemIndex: index,
                  title: workoutCtrl.preferenceList[index].question ?? '',
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  buildSizeHeight(12),
            );
          }),
          buildSizeHeight(20),
          Obx(() {
            return Visibility(
              visible: !workoutCtrl.answerGive.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: BaseButton(
                  btnHeight: 45,
                  title: "Send",
                  borderRadius: 15,
                  onPressed: () {
                    workoutCtrl.getAllAnswers().then((_) {
                      // print("object ${workoutCtrl.filledAll}");
                      if (workoutCtrl.filledAll) {
                        workoutCtrl.workoutPreferenceAnswersResult();
                      }
                    });
                  },
                ),
              ),
            );
          }),
          buildSizeHeight(20),
        ],
      ),
    );
  }
}
