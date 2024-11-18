import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/controller/workout_category_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutCategoryCards extends StatefulWidget {
  final int categoryIndex;

  const WorkoutCategoryCards({super.key, required this.categoryIndex});

  @override
  State<WorkoutCategoryCards> createState() => _WorkoutCategoryCardsState();
}

class _WorkoutCategoryCardsState extends State<WorkoutCategoryCards> {
  var workoutCategoryCtrl = Get.find<WorkoutCategoryController>();

  @override
  Widget build(BuildContext context) {
    var checkWidthHeight = 20.0;
    return GestureDetector(
      onTap: () {
        // setState(() {
        workoutCategoryCtrl.addOrRemove(categoryIndex: widget.categoryIndex);
        // });
      },
      child: Obx(() {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: workoutCategoryCtrl.selectedWorkoutList.contains(
                      workoutCategoryCtrl.sectionList[widget.categoryIndex])
                      ? BaseColors.primaryColor
                      : BaseColors.grey2
              )
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              BaseText(
                value: workoutCategoryCtrl.sectionList[widget.categoryIndex].name?.toString() ?? "",
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: workoutCategoryCtrl.selectedWorkoutList.contains(
                    workoutCategoryCtrl.sectionList[widget.categoryIndex]) ? BaseColors.black : BaseColors.grey2,
              ),
              Visibility(
                visible: workoutCategoryCtrl.selectedWorkoutList.contains(
                    workoutCategoryCtrl.sectionList[widget.categoryIndex]),
                child: Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: checkWidthHeight,
                    height: checkWidthHeight,
                    // alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: BaseColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: BaseText(
                        value: "${workoutCategoryCtrl.selectedWorkoutList
                            .indexOf(workoutCategoryCtrl.sectionList[widget.categoryIndex]) + 1}",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: BaseColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
