
import 'package:fitness_metrics/ui/athlete/workout_details/controllers/workout_details_controller.dart';
import 'package:fitness_metrics/ui/athlete/workout_edit/components/dynamic_exercise_edit_field.dart';
import 'package:fitness_metrics/ui/athlete/workout_edit/controller/exercise_view_edit_controller.dart';
import 'package:fitness_metrics/ui/athlete/workout_edit/controller/workout_edit_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WorkoutEdit extends StatefulWidget {
  final String workoutId;
  final String coachId;
  final String exerciseId;
  final String sectionId;

  // final ExercisesData exercisesData;

  const WorkoutEdit({
    super.key,
    // required this.exercisesData,
    required this.workoutId,
    required this.coachId,
    required this.exerciseId,
    required this.sectionId,
  });

  @override
  State<WorkoutEdit> createState() => _WorkoutEditState();
}

class _WorkoutEditState extends State<WorkoutEdit> {
  var editCtrl = Get.put(WorkoutEditController());
  var exerciseViewEditCtrl = Get.find<ExerciseViewEditController>();
  var workoutDetailsCtrl = Get.find<WorkoutDetailsController>();

  @override
  void initState() {
    super.initState();
    editCtrl.athleteDetailsChart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BaseAppBar(
            title: exerciseViewEditCtrl.section.value,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BaseColumn(
                children: [
                  buildSizeHeight(25),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BaseText(
                      value: exerciseViewEditCtrl.section.value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      color: BaseColors.black1,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    decoration: BoxDecoration(
                      color: BaseColors.green2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSizeHeight(10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BaseText(
                                value: exerciseViewEditCtrl.exerciseName.value,
                                color: BaseColors.black1,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  workoutDetailsCtrl.showNotes(
                                    context: context,
                                    notes: exerciseViewEditCtrl.blockNote.value,
                                  );
                                },
                                child: SvgPicture.asset(BaseAssets.editNotes),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: BaseColors.grey3.withOpacity(.2),
                        ),
                        const Flexible(
                          child: DynamicExerciseEditField(),
                          // child: Padding(
                          //   padding: const EdgeInsets.only(
                          //     top: 6,
                          //     bottom: 10,
                          //     left: 16,
                          //     right: 16,
                          //   ),
                          //   child: Column(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: List.generate(
                          //       (widget.exercisesData.rules ?? []).length,
                          //       (index) {
                          //         if ((widget.exercisesData.rules ?? [])
                          //             .isNotEmpty) {
                          //           var ruleList =
                          //               (widget.exercisesData.rules ?? []);
                          //
                          //           ruleList[index].ruleTextController?.text =
                          //               ruleList[index].value ?? '';
                          //
                          //           return Padding(
                          //             padding: const EdgeInsets.symmetric(
                          //                 vertical: 0.0),
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 BaseText(
                          //                   value:
                          //                       ruleList[index].training ?? "",
                          //                   color: BaseColors.black,
                          //                   fontWeight: FontWeight.w400,
                          //                   fontSize: 16,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 50,
                          //                   height: 35,
                          //                   child: TextFormField(
                          //                     controller: ruleList[index]
                          //                         .ruleTextController,
                          //                     // keyboardType: TextInputType.number,
                          //                     textAlign: TextAlign.end,
                          //                   ),
                          //                 ),
                          //                 // BaseText(
                          //                 //   value: ruleList[index].value ?? "",
                          //                 //   color: BaseColors.black,
                          //                 //   fontWeight: FontWeight.w400,
                          //                 //   fontSize: 16,
                          //                 // ),
                          //               ],
                          //             ),
                          //           );
                          //         } else {
                          //           return const SizedBox();
                          //         }
                          //       },
                          //     ),
                          //     /*(widget
                          //                         .workoutDetailsList[dIndex]
                          //                     ['sets'] as Map<String, dynamic>)
                          //                 .entries
                          //                 .map<Widget>((entry) {
                          //               return Padding(
                          //                 padding: const EdgeInsets.symmetric(
                          //                     vertical: 4.0),
                          //                 child: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     BaseText(
                          //                       value: entry.key,
                          //                       color: BaseColors.black,
                          //                       fontWeight: FontWeight.w400,
                          //                       fontSize: 16,
                          //                     ),
                          //                     BaseText(
                          //                       value: entry.value.toString(),
                          //                       color: BaseColors.black,
                          //                       fontWeight: FontWeight.w400,
                          //                       fontSize: 16,
                          //                     ),
                          //                   ],
                          //                 ),
                          //               );
                          //             }).toList(),*/
                          //   ),
                          // ),
                        ),
                        buildSizeHeight(12),
                      ],
                    ),
                  ),
                  buildSizeHeight(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Expanded(
                      //   flex: 2,
                      //   child: Row(
                      //     children: [
                      //       SvgPicture.asset(BaseAssets.minus),
                      //       buildSizeWidth(10),
                      //       SvgPicture.asset(BaseAssets.plus),
                      //     ],
                      //   ),
                      // ),
                      Flexible(
                        child: BaseButton(
                          title: "Submit",
                          borderRadius: 15,
                          fontSize: 18,
                          btnHeight: 45,
                          btnColor: BaseColors.primaryColor,
                          onPressed: () {
                            if (exerciseViewEditCtrl
                                .exerciseFormKey.currentState!
                                .validate()) {
                              exerciseViewEditCtrl.exerciseRulesUpdate(
                                workoutId: widget.workoutId,
                                sectionId: widget.sectionId,
                                coachId: widget.coachId,
                                exerciseId: widget.exerciseId,
                              );
                            }

                            // editCtrl.validateExercise(
                            //   ruleList: (widget.exercisesData.rules ?? []),
                            //   workoutId: widget.workoutId,
                            //   sectionId: widget.exercisesData.sectionId ?? '',
                            //   coachId: widget.exercisesData.coachId?.toString() ?? '',
                            //   exerciseId: widget.exercisesData.id?.toString() ?? '',
                            // );
                          },
                        ),
                      )
                    ],
                  ),
                  buildSizeHeight(30),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 18, right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: BaseColors.grey5,
                                width: 0.92,
                              )),
                          child: PopupMenuButton<String>(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                BorderSide(color: BaseColors.lightBlue.withOpacity(0.4))),
                            color: BaseColors.white,
                            offset: const Offset(0, 2),
                            position: PopupMenuPosition.under,
                            itemBuilder: (context) {
                              List<String> monthList = ['All', ...months];
                              return monthList.map((str) {
                                return PopupMenuItem(
                                  height: 25,
                                  value: str,
                                  child: BaseText(
                                    value: str,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }).toList();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                BaseText(
                                  value: editCtrl.selectedMonth.value,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: BaseColors.grey5,
                                ),
                              ],
                            ),
                            onSelected: (v) {
                              // setState(() {
                              // print('!!!===== $v');
                              editCtrl.selectedMonth.value = v;
                              editCtrl.athleteDetailsChart();
                              // });
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: GetBuilder<WorkoutEditController>(
                      builder: (workoutEditCtrl) {
                        if(workoutEditCtrl.weightDataList.isNotEmpty) {
                          return SfCartesianChart(
                            key: UniqueKey(),
                            // tooltipBehavior: TooltipBehavior(enable: true),
                            zoomPanBehavior: workoutEditCtrl.zoomPanBehavior,
                            margin: const EdgeInsets.all(0.0),
                            plotAreaBorderWidth: 0,
                            primaryXAxis: const CategoryAxis(
                              labelRotation: -45,
                              interval: 1,
                              // Ensures all x-axis values are shown
                              majorGridLines: MajorGridLines(width: 0),
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(width: 0),
                              labelStyle: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                            primaryYAxis: const NumericAxis(
                              rangePadding: ChartRangePadding.additional,
                              // labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                              majorGridLines: MajorGridLines(width: 0),
                              axisLine: AxisLine(width: 0),
                              majorTickLines: MajorTickLines(width: 0),
                              labelStyle: TextStyle(
                                fontSize: 10,
                              ),
                              // majorTickLines: MajorTickLines(width: 0),
                            ),

                            onZoomEnd: (value) {
                              var currentZoomLevel = value.currentZoomFactor;

                              if (currentZoomLevel == 0.4) {
                                workoutEditCtrl.isZoomedIn.value = false;
                              } else {
                                workoutEditCtrl.isZoomedIn.value = true;
                              }

                              if (currentZoomLevel == 1.0) {
                                workoutEditCtrl.isZoomedOut.value = false;
                              } else {
                                workoutEditCtrl.isZoomedOut.value = true;
                              }
                            },

                            series: <CartesianSeries>[
                              // Renders spline chart
                              SplineSeries<SplineData, String>(
                                dataSource: workoutEditCtrl.weightDataList,
                                xValueMapper: (SplineData data, _) => data.x,
                                yValueMapper: (SplineData data, _) => data.y,
                                color: BaseColors.primaryColor,
                                // enableTooltip: true,
                                // markerSettings: const MarkerSettings( // Renders the marker
                                //     isVisible: true
                                // ),
                              ),
                            ],
                          );
                        } else {
                          return const BaseNoData(message: "No Chart Data Found!");
                        }
                      },
                    ),
                  ),
                  buildSizeHeight(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() {
                        return GestureDetector(
                          onTap: () => editCtrl.zoomPanBehavior.zoomOut(),
                          child: editCtrl.isZoomedOut.value
                              ? SvgPicture.asset(BaseAssets.zoomOutEnable)
                              : SvgPicture.asset(BaseAssets.zoomOutDisable),
                        );
                      }),
                      buildSizeWidth(10),
                      Obx(() {
                        return GestureDetector(
                          onTap: () => editCtrl.zoomPanBehavior.zoomIn(),
                          child: editCtrl.isZoomedIn.value
                              ? SvgPicture.asset(BaseAssets.zoomInEnable)
                              : SvgPicture.asset(BaseAssets.zoomInDisable),
                        );
                      }),
                    ],
                  ),
                  buildSizeHeight(30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
