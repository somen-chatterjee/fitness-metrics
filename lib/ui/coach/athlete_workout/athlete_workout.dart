
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/controller/workout_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteWorkout extends StatefulWidget {
  const AthleteWorkout({super.key});

  @override
  State<AthleteWorkout> createState() => _AthleteWorkoutState();
}

class _AthleteWorkoutState extends State<AthleteWorkout> {
  var workoutCtrl = Get.put(WorkoutController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: BaseColors.grey5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => workoutCtrl.selectBody(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: workoutCtrl.selectedIndex.value == 0
                            ? BaseColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: BaseText(
                        value: 'Workout archive',
                        fontSize: 14,
                        fontWeight: workoutCtrl.selectedIndex.value == 0
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: workoutCtrl.selectedIndex.value == 0
                            ? BaseColors.white
                            : BaseColors.black1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                buildSizeWidth(10),
                Expanded(
                  child: InkWell(
                    onTap: () => workoutCtrl.selectBody(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: workoutCtrl.selectedIndex.value == 1
                            ? BaseColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: BaseText(
                        value: 'Training preferences',
                        fontSize: 14,
                        fontWeight: workoutCtrl.selectedIndex.value == 1
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: workoutCtrl.selectedIndex.value == 1
                            ? BaseColors.white
                            : BaseColors.black1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildSizeHeight(20),
          Expanded(
            child:
            workoutCtrl.bodyList[workoutCtrl.selectedIndex.value],),
        ],
      );
    });
  }
}
