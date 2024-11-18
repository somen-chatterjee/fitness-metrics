import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/controller/training_preference_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingCards extends StatefulWidget {
  final int itemIndex;

  const TrainingCards({super.key, required this.itemIndex});

  @override
  State<TrainingCards> createState() => _TrainingCardsState();
}

class _TrainingCardsState extends State<TrainingCards> {
  var trainingPreferenceCtrl = Get.find<TrainingPreferenceController>();

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
            value: trainingPreferenceCtrl
                    .preferenceList[widget.itemIndex].question ??
                "",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: BaseColors.black1,
          ),
          buildSizeHeight(5),
          Row(
            children: [
              const BaseText(
                value: "Answer: ",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: BaseColors.grey1,
              ),
              Expanded(
                child: BaseText(
                  value: trainingPreferenceCtrl
                          .preferenceList[widget.itemIndex].answer ??
                      "N/A",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: BaseColors.black1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
