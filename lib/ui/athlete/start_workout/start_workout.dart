import 'package:fitness_metrics/ui/athlete/start_workout/components/extend_data_widget.dart';
import 'package:fitness_metrics/ui/athlete/start_workout/controller/start_workout_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StartWorkout extends StatefulWidget {
  final String workoutTitle;
  final String workoutId;
  final String workoutNote;

  const StartWorkout({super.key,
    required this.workoutTitle,
    required this.workoutId,
    required this.workoutNote});

  @override
  State<StartWorkout> createState() => _StartWorkoutState();
}

class _StartWorkoutState extends State<StartWorkout> {
  var startWorkoutCtrl = Get.put(StartWorkoutController());

  @override
  void initState() {
    super.initState();
    startWorkoutCtrl.workoutSectionGet(workoutId: widget.workoutId);
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
                  buildSizeHeight(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'CAUTION: ',
                        overflow: TextOverflow.ellipsis,
                        color: BaseColors.black1,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      Expanded(
                        child: BaseText(
                          value: widget.workoutNote,
                          color: BaseColors.black1,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  Obx(() {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        scaffoldBackgroundColor: Colors.transparent,
                        cardColor: Colors.transparent,
                      ),
                      child: ReorderableListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: startWorkoutCtrl.workoutDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(
                            key: Key(index.toString()),
                                () =>
                                GestureDetector(
                                  onTap: () =>
                                      startWorkoutCtrl.getExerciseData(
                                        index: index,
                                        workoutId: widget.workoutId,
                                      ),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: startWorkoutCtrl
                                          .workoutDataList[index].section?.status ==
                                          0
                                          ? BaseColors.green2
                                          : BaseColors.grey6,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        // workout title
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                            left: 16,
                                            right: 0,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: BaseText(
                                                  value: startWorkoutCtrl
                                                      .workoutDataList[index]
                                                      .section?.name?.toString() ??
                                                      '',
                                                  maxLines: 2,
                                                  overflow: TextOverflow
                                                      .ellipsis,
                                                  color: BaseColors.black1,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  startWorkoutCtrl
                                                      .extendData(index: index);
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 45,
                                                  height: 28,
                                                  // color: Colors.red,
                                                  // padding: EdgeInsets.only(right: 5),
                                                  child: SvgPicture.asset(
                                                    startWorkoutCtrl
                                                        .visibleFAQ.value !=
                                                        index
                                                        ? BaseAssets.rightArrow2
                                                        : BaseAssets.downArrow,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                        // extend data
                                        ExtendDataWidget(itemIndex: index)
                                      ],
                                    ),
                                  ),
                                ),
                          );
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          setState(() {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            // print(
                            //     '$oldIndex $newIndex ${startWorkoutCtrl.visibleFAQ.value}');
                            startWorkoutCtrl.visibleFAQ.value = newIndex;

                            var item = startWorkoutCtrl.workoutDataList
                                .removeAt(oldIndex);
                            startWorkoutCtrl.workoutDataList
                                .insert(newIndex, item);
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
