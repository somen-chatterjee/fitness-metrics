import 'package:fitness_metrics/ui/athlete/workout/models/plan_model.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/components/create_training_note_sheet.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/components/create_workout_sheet.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/components/workout_grid_cards.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/controllers/create_workout_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/controller/coach_archive_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CreateWorkout extends StatefulWidget {
  final PlanData planData;

  const CreateWorkout({super.key, required this.planData});

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  late CreateWorkoutController createWorkoutCtrl;
  late CoachArchiveController coachArchiveCtrl;

  @override
  void initState() {
    super.initState();
    coachArchiveCtrl = Get.find<CoachArchiveController>();
    createWorkoutCtrl = Get.put(CreateWorkoutController());

    createWorkoutCtrl.planWorkoutGetCoach(
      page: 1,
      planId: widget.planData.id ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BaseAppBar(title: widget.planData.name ?? ""),
          Expanded(
            child: BaseColumn(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      buildSizeHeight(60),
                      const BaseText(
                        value: 'Start Creating',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      BaseText(
                        value:
                            'Active Plan ${dateDDMMYY(widget.planData.startDate ?? "")} - ${dateDDMMYY(widget.planData.finishDate ?? "")}',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      Expanded(
                        child: Obx(() {
                          return SmartRefresher(
                            enablePullUp: createWorkoutCtrl.currentPage !=
                                createWorkoutCtrl.lastPage,
                            controller: createWorkoutCtrl.refreshController,
                            onLoading: () {
                              if (createWorkoutCtrl.currentPage !=
                                  createWorkoutCtrl.lastPage) {
                                createWorkoutCtrl.planWorkoutGetCoach(
                                  page: createWorkoutCtrl.currentPage += 1,
                                  planId: widget.planData.id ?? "",
                                );
                              }
                            },
                            enablePullDown: false,
                            onRefresh: () {
                              createWorkoutCtrl.planWorkoutGetCoach(
                                page: 1,
                                planId: widget.planData.id ?? "",
                              );
                            },
                            child: createWorkoutCtrl.workoutList.isNotEmpty
                                ? GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 42,
                                    ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 32,
                                      crossAxisSpacing: 35,
                                      childAspectRatio: 1.19,
                                    ),
                                    itemCount:
                                        createWorkoutCtrl.workoutList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return WorkoutGridCards(
                                        workoutData: createWorkoutCtrl
                                            .workoutList[index],
                                      );
                                    },
                                  )
                                : const BaseNoData(
                                    message: "No Workout Found!"),
                          );
                        }),
                      ),
                    ],
                  ),

                  // ListView.separated(
                  //   itemCount: 14,
                  //   padding: EdgeInsets.zero,
                  //   itemBuilder: (context, index) {
                  //     return ArchiveCards(itemIndex: index);
                  //   },
                  //   separatorBuilder: (BuildContext context, int index) {
                  //     return buildSizeHeight(12);
                  //   },
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => _addTrainingNoteBottomSheet(context),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(BaseAssets.editNotes),
                            buildSizeWidth(10),
                            const BaseText(
                              value: 'Trainer Notes',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await createWorkoutCtrl
                              .getWorkoutIcon()
                              .then((onValue) {
                            if (context.mounted) {
                              _addWorkoutBottomSheet(context);
                            }
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(BaseAssets.addRound),
                            buildSizeWidth(10),
                            const BaseText(
                              value: 'Add',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addWorkoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return CreateWorkoutSheet(planId: widget.planData.id ?? '');
      },
    );
  }

  void _addTrainingNoteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return CreateTrainingNoteSheet(planId: widget.planData.id ?? '');
      },
    );
  }
}
