
import 'package:fitness_metrics/ui/coach/athlete_evaluation/controller/coach_athlete_evaluation_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteEvaluation extends StatefulWidget {
  const AthleteEvaluation({super.key});

  @override
  State<AthleteEvaluation> createState() => _AthleteEvaluationState();
}

class _AthleteEvaluationState extends State<AthleteEvaluation> {
  var evaluationCtrl = Get.put(CoachAthleteEvaluationController());

  @override
  void initState() {
    super.initState();
    evaluationCtrl.selectBody(0);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSizeHeight(10),
          ToggleButtons(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            constraints: const BoxConstraints(
              maxHeight: 60,
              maxWidth: 50,
              minHeight: 00,
              minWidth: 25,
            ),
            isSelected: [
              evaluationCtrl.selectedEvaluation.value == 0,
              evaluationCtrl.selectedEvaluation.value == 1,
              evaluationCtrl.selectedEvaluation.value == 2,
            ],
            renderBorder: false,
            onPressed: (index) {
              evaluationCtrl.selectedEvaluation.value = index;
            },
            fillColor: Colors.transparent,
            splashColor: Colors.transparent,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: evaluationCtrl.selectedEvaluation.value == 0
                      ? BaseColors.primaryColor
                      : BaseColors.white,
                  border: Border.all(
                    color: BaseColors.primaryColor,
                  ),
                  shape: BoxShape.circle,
                ),
                width: 15,
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: evaluationCtrl.selectedEvaluation.value == 1
                      ? BaseColors.primaryColor
                      : BaseColors.white,
                  border: Border.all(
                    color: BaseColors.primaryColor,
                  ),
                  shape: BoxShape.circle,
                ),
                width: 15,
                height: 15,
                alignment: Alignment.center,
              ),
              Container(
                decoration: BoxDecoration(
                  color: evaluationCtrl.selectedEvaluation.value == 2
                      ? BaseColors.primaryColor
                      : BaseColors.white,
                  border: Border.all(
                    color: BaseColors.primaryColor,
                  ),
                  shape: BoxShape.circle,
                ),
                width: 15,
                height: 15,
                alignment: Alignment.center,
              ),
            ],
          ),
          buildSizeHeight(10),
          evaluationCtrl.evaluationList[evaluationCtrl.selectedEvaluation.value]
        ],
      );
    });
  }
}
