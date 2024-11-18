import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/athlete/workout_details/controllers/workout_details_controller.dart';
import 'package:fitness_metrics/ui/athlete/workout_edit/controller/exercise_view_edit_controller.dart';
import 'package:fitness_metrics/ui/athlete/workout_edit/workout_edit.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WorkoutDetailsCard extends StatefulWidget {
  final int dIndex;
  final String sectionId;
  final String workoutId;

  const WorkoutDetailsCard(
      {super.key,
      required this.dIndex,
      required this.sectionId,
      required this.workoutId});

  @override
  State<WorkoutDetailsCard> createState() => _WorkoutDetailsCardState();
}

class _WorkoutDetailsCardState extends State<WorkoutDetailsCard> {
  var workoutDetailsCtrl = Get.find<WorkoutDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          thickness: 1,
          color: BaseColors.grey3.withOpacity(.2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                value:
                    workoutDetailsCtrl.exercisesDataList[widget.dIndex].name ??
                        "",
                color: BaseColors.black1,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              GestureDetector(
                onTap: () {
                  workoutDetailsCtrl.showNotes(
                    context: context,
                    notes: workoutDetailsCtrl
                            .exercisesDataList[widget.dIndex].note ??
                        '',
                  );
                },
                child: SvgPicture.asset(
                  BaseAssets.editNotes,
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: BaseColors.grey3.withOpacity(.2),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                (workoutDetailsCtrl.exercisesDataList[widget.dIndex].rules ??
                        [])
                    .length,
                (index) {
                  if ((workoutDetailsCtrl
                              .exercisesDataList[widget.dIndex].rules ??
                          [])
                      .isNotEmpty) {
                    var ruleList = workoutDetailsCtrl
                            .exercisesDataList[widget.dIndex].rules ??
                        [];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            value: ruleList[index].training ?? "",
                            color: BaseColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          BaseText(
                            value: ruleList[index].value ?? "",
                            color: BaseColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              /*(widget
                                                  .workoutDetailsList[dIndex]
                                              ['sets'] as Map<String, dynamic>)
                                          .entries
                                          .map<Widget>((entry) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BaseText(
                                                value: entry.key,
                                                color: BaseColors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                              BaseText(
                                                value: entry.value.toString(),
                                                color: BaseColors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),*/
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: SvgPicture.asset(
                  BaseAssets.editPencil,
                ),
                onTap: () async {
                  var exerciseData =
                      workoutDetailsCtrl.exercisesDataList[widget.dIndex];

                  Get.put(ExerciseViewEditController())
                      .exerciseRulesView(
                    sectionId: widget.sectionId,
                    workoutId: widget.workoutId,
                    exerciseId: exerciseData.id ?? '',
                  )
                      .then((val) {
                    if (val) {
                      Get.to(() {
                        return WorkoutEdit(
                          workoutId: widget.workoutId,
                          coachId: exerciseData.coachId ?? '',
                          exerciseId: exerciseData.id ?? '',
                          sectionId: widget.sectionId,
                        );
                      });
                    }
                  });
                },
              ),
              GestureDetector(
                onTap: () {
                  Get.find<CommonController>().showYoutubePlayer(
                    context: context,
                    videoUrl: workoutDetailsCtrl
                            .exercisesDataList[widget.dIndex].videoUrl ??
                        '',
                  );
                },
                child: SvgPicture.asset(
                  BaseAssets.playVideo,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
