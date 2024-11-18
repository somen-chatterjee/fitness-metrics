import 'package:fitness_metrics/ui/athlete/workout/controller/workout_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingCards extends StatefulWidget {
  final int itemIndex;
  final String title;

  const TrainingCards(
      {super.key, required this.itemIndex, required this.title});

  @override
  State<TrainingCards> createState() => _TrainingCardsState();
}

class _TrainingCardsState extends State<TrainingCards> {
  final workoutCtrl = Get.find<WorkoutController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: BaseColors.grey5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            value: widget.title,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: BaseColors.black1,
          ),
          buildSizeHeight(5),
          Obx(() {
            return TextField(
              controller: workoutCtrl.preferenceList[widget.itemIndex]
                  .answerController,
              readOnly: workoutCtrl.answerGive.value,
              decoration: const InputDecoration(
                hintText: 'Enter here',
                hintStyle: TextStyle(
                    color: BaseColors.grey5
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: BaseColors.grey5),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),),
            );
          }),
        ],
      ),
    );
  }
}
