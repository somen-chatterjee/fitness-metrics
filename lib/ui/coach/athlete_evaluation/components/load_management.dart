import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/controller/load_management_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class LoadManagement extends StatefulWidget {
  const LoadManagement({super.key});

  @override
  State<LoadManagement> createState() => _LoadManagementState();
}

class _LoadManagementState extends State<LoadManagement> {
  late LoadManagementController loadCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<LoadManagementController>();
    loadCtrl = Get.put(LoadManagementController());

    loadCtrl.getCurrentMonth();
    loadCtrl.createYear();
    loadCtrl.setYear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadCtrl.loadChart();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: BaseText(
                    value: 'Load Management',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                Obx(() {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: BaseColors.yellowGreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 40,
                    child: PopupMenuButton<String>(
                      position: PopupMenuPosition.under,
                      itemBuilder: (context) {
                        return loadCtrl.loadManageList.map((str) {
                          return PopupMenuItem(
                            value: str,
                            child: BaseText(
                              value: str,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          );
                        }).toList();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          BaseText(
                            value: loadCtrl.loadManageType.value,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: BaseColors.black1,
                          ),
                        ],
                      ),
                      onSelected: (v) {
                        loadCtrl.loadManageType.value = v;
                        loadCtrl.update();
                      },
                    ),
                  );
                }),
              ],
            ),
            /*buildSizeHeight(20),
            Align(
              alignment: Alignment.centerRight,
              child: IntrinsicWidth(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 8, left: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: BaseColors.grey5.withOpacity(0.4)),
                  ),
                  height: 40,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      BaseText(
                        value: 'Date',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: BaseColors.grey2,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: BaseColors.grey2,
                      ),
                    ],
                  ),
                ),
              ),
            ),*/
            buildSizeHeight(10),
            Divider(
              color: BaseColors.grey5.withOpacity(0.3),
              height: 22,
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      loadCtrl.getPreviousMonth(
                          loadCtrl.currentMonth.value);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left_rounded,
                      color: BaseColors.primaryColor,
                      size: 20,
                    ),
                  ),
                  BaseText(
                    value: loadCtrl.currentMonth.value,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      loadCtrl
                          .getNextMonth(loadCtrl.currentMonth.value);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: BaseColors.primaryColor,
                      size: 20,
                    ),
                  ),
                ],
              );
            }),
            Divider(
              color: BaseColors.grey5.withOpacity(0.3),
              height: 22,
            ),
            buildSizeHeight(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  if(loadCtrl.measurementExerciseList.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.only(left: 18, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: BaseColors.grey5,
                          width: 0.92,
                        ),
                      ),
                      child: PopupMenuButton<String>(
                        elevation: 0,
                        constraints: const BoxConstraints.tightFor(
                        //   width: 80,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: BaseColors.lightBlue.withOpacity(0.4),
                          ),
                        ),
                        color: BaseColors.white,
                        offset: const Offset(0, 2),
                        position: PopupMenuPosition.under,
                        itemBuilder: (context) {
                          return loadCtrl.measurementExerciseList.reversed.map((str) {
                            return PopupMenuItem(
                              height: 25,
                              value: str.id.toString(),
                              // padding: const EdgeInsets.only(left: 18,right: 0),
                              child: BaseText(
                                value: str.exercise.toString(),
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
                              value: loadCtrl.exerciseId.isNotEmpty ? loadCtrl.selectedExercise.value
                                  .toString() : 'All',
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

                          loadCtrl.exerciseId = v;

                          String exerciseName = loadCtrl.measurementExerciseList.firstWhere((val) => (val.id?.toString() ?? '') == v).exercise ?? '';
                          loadCtrl.selectedExercise.value = exerciseName;

                          loadCtrl.loadChart();

                          // });
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                buildSizeWidth(10),
                Obx(() {
                  return Container(
                    padding: const EdgeInsets.only(left: 18, right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: BaseColors.grey5,
                        width: 0.92,
                      ),
                    ),
                    child: PopupMenuButton<String>(
                      elevation: 0,
                      constraints: const BoxConstraints.tightFor(
                        width: 80,
                        height: 200,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: BaseColors.lightBlue.withOpacity(0.4),
                        ),
                      ),
                      color: BaseColors.white,
                      offset: const Offset(0, 2),
                      position: PopupMenuPosition.under,
                      itemBuilder: (context) {
                        return loadCtrl.years.reversed.map((str) {
                          return PopupMenuItem(
                            height: 25,
                            value: str.toString(),
                            // padding: const EdgeInsets.only(left: 18,right: 0),
                            child: BaseText(
                              value: str.toString(),
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
                            value: loadCtrl.selectedYear.value
                                .toString(),
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
                        loadCtrl.selectedYear.value = int.parse(v);
        
                        loadCtrl.loadChart();
        
                        // });
                      },
                    ),
                  );
                }),
              ],
            ),
            Container(
              decoration: const BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              height: 260,
              child: GetBuilder<LoadManagementController>(builder: (ctrl) {
                return SfCartesianChart(
                  key: UniqueKey(),
                  // tooltipBehavior: TooltipBehavior(enable: true),
                  //   zoomPanBehavior: ZoomPanBehavior(
                  //           enablePanning: true,
                  //         ),
                  zoomPanBehavior: ctrl.zoomPanBehavior,
                  margin: const EdgeInsets.all(0.0),
                  plotAreaBorderWidth: 0,
                  primaryXAxis: const CategoryAxis(
                    // labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    labelRotation: -45,
                    interval: 1,
                    // to show all values in x-axis
                    majorGridLines: MajorGridLines(width: 0),
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(width: 0),
                    labelAlignment: LabelAlignment.center,
                    labelStyle: TextStyle(
                      fontSize: 10,
                    ),
                    // majorTickLines: MajorTickLines(width: 0),
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

                    if (currentZoomLevel == 0.2) {
                      ctrl.isZoomedIn.value = false;
                    } else {
                      ctrl.isZoomedIn.value = true;
                    }

                    if (currentZoomLevel == 1.0) {
                      ctrl.isZoomedOut.value = false;
                    } else {
                      ctrl.isZoomedOut.value = true;
                    }
                  },

                  series: <CartesianSeries>[
                    // Renders spline chart
                    if (ctrl.loadManageType.value == "All" || ctrl.loadManageType.value == "Total Volume")
                      SplineSeries<SplineData, String>(
                        dataSource: ctrl.totalLoadList,
                        xValueMapper: (SplineData data, _) => data.x,
                        yValueMapper: (SplineData data, _) => data.y,
                        color: BaseColors.primaryColor,
                        // enableTooltip: true,
                        // markerSettings: const MarkerSettings( // Renders the marker
                        //     isVisible: true
                        // ),
                      ),
                    if (ctrl.loadManageType.value == "All" || ctrl.loadManageType.value == "1RM Estimation")
                      SplineSeries<SplineData, String>(
                        dataSource: ctrl.totalRmList,
                        xValueMapper: (SplineData data, _) => data.x,
                        yValueMapper: (SplineData data, _) => data.y,
                        color: BaseColors.purple,
                        // enableTooltip: true,
                        // markerSettings: const MarkerSettings( // Renders the marker
                        //     isVisible: true
                        // ),
                      ),
                  ],
                );
              }),
            ),
            buildSizeHeight(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Row(
                //   children: [
                //     SvgPicture.asset(BaseAssets.editNotes),
                //     buildSizeWidth(10),
                //     const BaseText(
                //       value: 'Add',
                //       fontWeight: FontWeight.w500,
                //       fontSize: 18,
                //     )
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: () => loadCtrl.zoomPanBehavior.zoomOut(),
                        child: loadCtrl.isZoomedOut.value
                            ? SvgPicture.asset(BaseAssets.zoomOutEnable)
                            : SvgPicture.asset(BaseAssets.zoomOutDisable),
                      );
                    }),
                    buildSizeWidth(10),
                    Obx(() {
                      return GestureDetector(
                        onTap: () => loadCtrl.zoomPanBehavior.zoomIn(),
                        child: loadCtrl.isZoomedIn.value
                            ? SvgPicture.asset(BaseAssets.zoomInEnable)
                            : SvgPicture.asset(BaseAssets.zoomInDisable),
                      );
                    }),
                  ],
                ),
              ],
            ),
            buildSizeHeight(40),
          ],
        ),
      ),
    );
  }
}
