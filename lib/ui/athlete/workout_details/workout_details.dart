
import 'package:fitness_metrics/ui/athlete/start_workout/controller/start_workout_controller.dart';
import 'package:fitness_metrics/ui/athlete/workout_details/components/workout_details_card.dart';
import 'package:fitness_metrics/ui/athlete/workout_details/controllers/workout_details_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:get/get.dart';

class WorkoutDetails extends StatefulWidget {
  final String workoutTitle;
  final String workoutId;
  final String sectionId;
  final int index;

  // final List<Exercises> workoutDetailsList;

  const WorkoutDetails({
    super.key,
    required this.workoutTitle,
    // required this.workoutDetailsList,
    required this.workoutId,
    required this.sectionId,
    required this.index,
  });

  @override
  State<WorkoutDetails> createState() => _WorkoutDetailsState();
}

class _WorkoutDetailsState extends State<WorkoutDetails> {
  var workoutDetailsCtrl = Get.put(WorkoutDetailsController());
  var startWorkoutCtrl = Get.find<StartWorkoutController>();

  @override
  void initState() {
    super.initState();
    workoutDetailsCtrl.exerciseRulesEdit(
      workoutId: widget.workoutId,
      sectionId: widget.sectionId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BaseAppBar(
            title: widget.workoutTitle,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BaseColumn(
                children: [
                  buildSizeHeight(20),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    decoration: BoxDecoration(
                      color: BaseColors.green2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: BaseText(
                                  value: widget.workoutTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  color: BaseColors.black1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              SvgPicture.asset(BaseAssets.downArrow),
                            ],
                          ),
                        ),
                        Obx(() {
                          return ListView.builder(
                            padding: const EdgeInsets.only(bottom: 10),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                workoutDetailsCtrl.exercisesDataList.length,
                            itemBuilder: (context, dIndex) {
                              return WorkoutDetailsCard(
                                dIndex: dIndex,
                                sectionId: widget.sectionId,
                                workoutId: widget.workoutId,
                              );
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  buildSizeHeight(20),
                  Visibility(
                    // visible: widget.sectionId ==
                    //     startWorkoutCtrl.workoutDataList.last.section?.sectionId?.toString() ?? '',
                    child: BaseButton(
                      title: "Finish",
                      borderRadius: 15,
                      fontSize: 18,
                      btnColor: BaseColors.primaryColor,
                      leftMargin: 30,
                      rightMargin: 30,
                      onPressed: () {
                        workoutDetailsCtrl.showMarkFinished(
                          context: context,
                          workoutId: widget.workoutId,
                          sectionId: widget.sectionId,
                        );
                      },
                    ),
                  ),
                  buildSizeHeight(10),
                  BaseButton(
                    title: "Next Exercise",
                    borderRadius: 15,
                    fontSize: 18,
                    btnTextColor: BaseColors.primaryColor,
                    btnColor: BaseColors.green2,
                    leftMargin: 30,
                    rightMargin: 30,
                    onPressed: () => Get.back(),
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
