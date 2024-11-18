import 'package:fitness_metrics/ui/athlete/workout_details/models/finish_workout_model.dart';
import 'package:fitness_metrics/ui/athlete/workout_questions/workout_questions.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkoutFinish extends StatelessWidget {
  final FinishData finishData;

  const WorkoutFinish({super.key, required this.finishData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Workout finished',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BaseColumn(
                children: [
                  buildSizeHeight(70),
                  SvgPicture.asset(BaseAssets.congratulation),
                  buildSizeHeight(30),
                  const BaseText(
                    value: 'Congratulations!',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  buildSizeHeight(20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 22),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(finishData.workoutTime != null && finishData.workoutTime!.isNotEmpty)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BaseText(value: "${finishData.workoutTime} min"),
                            SvgPicture.asset(BaseAssets.time),
                          ],
                        ),
                        if(finishData.totalLoad != null && finishData.totalLoad!.isNotEmpty)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BaseText(value: "${finishData.totalLoad}kg total"),
                            SvgPicture.asset(BaseAssets.calories),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const BaseText(value: "Workouts left"),
                            BaseText(value: "${finishData.finishedWorkout ?? ''}/${finishData.monthlyGoal ?? ''}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildSizeHeight(40),
                  BaseButton(
                    title: "Send Some Feedback",
                    borderRadius: 15,
                    fontSize: 18,
                    btnColor: BaseColors.primaryColor,
                    leftMargin: 30,
                    rightMargin: 30,
                    onPressed: () => Get.off(()=> const WorkoutQuestions()),
                  ),
                  buildSizeHeight(10),
                  BaseButton(
                    title: "Home",
                    borderRadius: 15,
                    fontSize: 18,
                    btnTextColor: BaseColors.primaryColor,
                    btnColor: BaseColors.green2,
                    leftMargin: 30,
                    rightMargin: 30,
                    onPressed: () {
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                    },
                  ),
                  buildSizeHeight(25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
