
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/controllers/create_workout_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/models/plan_workout_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/components/workout_assign_cards.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/components/workout_category_sheet.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/controller/workout_category_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkoutCategory extends StatefulWidget {
  // final WorkoutData workoutData;

  const WorkoutCategory({super.key});

  @override
  State<WorkoutCategory> createState() => _WorkoutCategoryState();
}

class _WorkoutCategoryState extends State<WorkoutCategory> {
  late WorkoutCategoryController workoutCategoryCtrl;
  var createWorkoutCtrl = Get.find<CreateWorkoutController>();

  @override
  void initState() {
    super.initState();
    workoutCategoryCtrl = Get.put(WorkoutCategoryController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  void loadData() async {
    await workoutCategoryCtrl.getSectionList();
    workoutCategoryCtrl.getWorkoutSections(
        workoutId: createWorkoutCtrl.selectedWorkoutData?.id.toString() ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BaseAppBar(
              title:
                  createWorkoutCtrl.selectedWorkoutData?.name.toString() ?? ""),
          Expanded(
            child: BaseColumn(
              children: [
                Expanded(
                  child: Obx(() {
                    return workoutCategoryCtrl
                            .selectedWorkoutNameList.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            itemCount: workoutCategoryCtrl
                                .predefinedSectionData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return WorkoutAssignCards(itemIndex: index);
                            },
                          )
                        : const BaseNoData(message: "No Exercise Found!");
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => _addCategoryBottomSheet(
                          context,
                          createWorkoutCtrl.selectedWorkoutData!,
                        ),
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
                      // Visibility(
                      //   visible: workoutCategoryCtrl.isButtonVisible.value,
                      //   child: const Spacer(),
                      // ),
                      // Visibility(
                      //   visible: workoutCategoryCtrl.isButtonVisible.value,
                      //   child: InkWell(
                      //     splashColor: Colors.transparent,
                      //     highlightColor: Colors.transparent,
                      //     onTap: () {
                      //       workoutCategoryCtrl.workoutSectionCreate(
                      //         workoutId: widget.workoutData.id ?? '',
                      //       );
                      //     },
                      //     child: Row(
                      //       mainAxisSize: MainAxisSize.min,
                      //       mainAxisAlignment: MainAxisAlignment.end,
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         SvgPicture.asset(BaseAssets.save),
                      //         buildSizeWidth(10),
                      //         const BaseText(
                      //           value: 'Save',
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 18,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
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

  void _addCategoryBottomSheet(BuildContext context, WorkoutData workoutData) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      // isScrollControlled: true,
      builder: (BuildContext context) {
        return WorkoutCategorySheet(workoutData: workoutData);
      },
    );
  }
}
