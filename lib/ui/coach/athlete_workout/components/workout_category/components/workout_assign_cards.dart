import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/components/workout_extend_data.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/controller/workout_category_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkoutAssignCards extends StatefulWidget {
  final int itemIndex;

  const WorkoutAssignCards({super.key, required this.itemIndex});

  @override
  State<WorkoutAssignCards> createState() => _WorkoutAssignCardsState();
}

class _WorkoutAssignCardsState extends State<WorkoutAssignCards> {
  var workoutCategoryCtrl = Get.find<WorkoutCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        decoration: BoxDecoration(
          color: BaseColors.yellowGreen,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 8,
                left: 16,
                right: 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: BaseText(
                      value: workoutCategoryCtrl
                          .selectedWorkoutNameList[widget.itemIndex].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      color: BaseColors.black1,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (workoutCategoryCtrl.visibleFAQ.value ==
                          widget.itemIndex) {
                        workoutCategoryCtrl.visibleFAQ.value = -1; // Collapse
                      } else {
                        workoutCategoryCtrl.visibleFAQ.value =
                            widget.itemIndex; // Expand
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 45,
                      height: 28,
                      // color: Colors.red,
                      // padding: EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        workoutCategoryCtrl.visibleFAQ.value != widget.itemIndex
                            ? BaseAssets.rightArrow2
                            : BaseAssets.downArrow,
                      ),
                    ),
                  )
                ],
              ),
            ),
            WorkoutExtendData(itemIndex: widget.itemIndex),
            Visibility(
              visible: workoutCategoryCtrl.visibleFAQ.value == widget.itemIndex,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 12,
                  left: 14,
                  right: 14,
                  // horizontal: 14,
                  // vertical: 12,
                ),
                child: GestureDetector(
                  onTap: () {
                    workoutCategoryCtrl.gotoNextScreen(
                      index: widget.itemIndex,
                    );
                  },
                  child: SvgPicture.asset(
                    BaseAssets.addRound,
                    colorFilter: const ColorFilter.mode(BaseColors.black, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
