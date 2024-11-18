
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/components/add_view_measurement.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/controller/athlete_view_measurement_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Measurement extends StatefulWidget {
  const Measurement({super.key});

  @override
  State<Measurement> createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {
  late AthleteMeasurementController measureCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<AthleteMeasurementController>();
    measureCtrl = Get.put(AthleteMeasurementController());

    measureCtrl.measurementSelect.value = "All";
    measureCtrl.getCurrentMonth();
    measureCtrl.createYear();
    measureCtrl.setYear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      measureCtrl.measurementChart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: BaseColors.grey5.withOpacity(0.3),
                  height: 1,
                ),
                buildSizeHeight(5),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          measureCtrl.getPreviousMonth(
                              measureCtrl.currentMonth.value);
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_left_rounded,
                          color: BaseColors.primaryColor,
                          size: 20,
                        ),
                      ),
                      BaseText(
                        value: measureCtrl.currentMonth.value,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          measureCtrl
                              .getNextMonth(measureCtrl.currentMonth.value);
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
                buildSizeHeight(5),
                Divider(
                  color: BaseColors.grey5.withOpacity(0.3),
                  height: 1,
                ),
                buildSizeHeight(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BaseText(
                      value: 'Measurement',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    Row(
                      children: [
                        Obx(() {
                          return Container(
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
                                side: BorderSide(
                                  color:
                                  BaseColors.lightBlue.withOpacity(0.4),
                                ),
                              ),
                              color: BaseColors.white,
                              offset: const Offset(0, 2),
                              position: PopupMenuPosition.under,
                              itemBuilder: (context) {
                                return measureCtrl.measurementItems.map((str) {
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
                                    value: measureCtrl.measurementSelect.value,
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
                                measureCtrl.measurementSelect.value = v;
                                measureCtrl.update();
                                // });
                              },
                            ),
                          );
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
                                return measureCtrl.years.reversed.map((str) {
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
                                    value: measureCtrl.selectedYear.value
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
                                measureCtrl.selectedYear.value = int.parse(v);

                                measureCtrl.measurementChart();

                                // });
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                buildSizeHeight(10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    measureCtrl.measurementColorList.length,
                        (index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: measureCtrl.measurementColorList[index]
                              ['color'],
                            ),
                          ),
                          buildSizeWidth(5),
                          BaseText(
                            value: measureCtrl.measurementColorList[index]
                            ['title'],
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                          buildSizeWidth(10),
                        ],
                      );
                    },
                  ),
                ),
                buildSizeHeight(12),
                Expanded(
                  child: GetBuilder<AthleteMeasurementController>(
                    builder: (ctrl) {
                      return SfCartesianChart(
                        key: UniqueKey(),
                        // tooltipBehavior: TooltipBehavior(enable: true),
                        zoomPanBehavior: measureCtrl.zoomPanBehavior,
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
                            measureCtrl.isZoomedIn.value = false;
                          } else {
                            measureCtrl.isZoomedIn.value = true;
                          }

                          if (currentZoomLevel == 1.0) {
                            measureCtrl.isZoomedOut.value = false;
                          } else {
                            measureCtrl.isZoomedOut.value = true;
                          }
                        },

                        series: <CartesianSeries>[
                          // Renders spline chart

                          if (ctrl.measurementSelect.value == "All" ||
                              ctrl.measurementSelect.value == "Arm")
                            SplineSeries<SplineData, String>(
                              dataSource: ctrl.armDataList,
                              xValueMapper: (SplineData data, _) => data.x,
                              yValueMapper: (SplineData data, _) => data.y,
                              color: ctrl.measurementColorList[0]['color'],
                              // enableTooltip: true,
                              // markerSettings: const MarkerSettings( // Renders the marker
                              //     isVisible: true
                              // ),
                            ),
                          if (ctrl.measurementSelect.value == "All" ||
                              ctrl.measurementSelect.value == "Chest")
                            SplineSeries<SplineData, String>(
                              dataSource: measureCtrl.chestDataList,
                              xValueMapper: (SplineData data, _) => data.x,
                              yValueMapper: (SplineData data, _) => data.y,
                              color: measureCtrl
                                  .measurementColorList[1]['color'],
                              // enableTooltip: true,
                              // markerSettings: const MarkerSettings( // Renders the marker
                              //     isVisible: true
                              // ),
                            ),
                          if (ctrl.measurementSelect.value == "All" ||
                              ctrl.measurementSelect.value == "Thigh")
                            SplineSeries<SplineData, String>(
                              dataSource: measureCtrl.thighDataList,
                              xValueMapper: (SplineData data, _) => data.x,
                              yValueMapper: (SplineData data, _) => data.y,
                              color: measureCtrl
                                  .measurementColorList[2]['color'],
                              // enableTooltip: true,
                              // markerSettings: const MarkerSettings( // Renders the marker
                              //     isVisible: true
                              // ),
                            ),
                          if (ctrl.measurementSelect.value == "All" ||
                              ctrl.measurementSelect.value == "Hips")
                            SplineSeries<SplineData, String>(
                              dataSource: measureCtrl.hipsDataList,
                              xValueMapper: (SplineData data, _) => data.x,
                              yValueMapper: (SplineData data, _) => data.y,
                              color: measureCtrl
                                  .measurementColorList[3]['color'],
                              // enableTooltip: true,
                              // markerSettings: const MarkerSettings( // Renders the marker
                              //     isVisible: true
                              // ),
                            ),
                          if (ctrl.measurementSelect.value == "All" ||
                              ctrl.measurementSelect.value == "Abs")
                            SplineSeries<SplineData, String>(
                              dataSource: measureCtrl.absDataList,
                              xValueMapper: (SplineData data, _) => data.x,
                              yValueMapper: (SplineData data, _) => data.y,
                              color: measureCtrl
                                  .measurementColorList[4]['color'],
                              // enableTooltip: true,
                              // markerSettings: const MarkerSettings( // Renders the marker
                              //     isVisible: true
                              // ),
                            ),
                          if (ctrl.measurementSelect.value == "All" ||
                              ctrl.measurementSelect.value == "Calves")
                            SplineSeries<SplineData, String>(
                              dataSource: measureCtrl.calvesDataList,
                              xValueMapper: (SplineData data, _) => data.x,
                              yValueMapper: (SplineData data, _) => data.y,
                              color: measureCtrl
                                  .measurementColorList[5]['color'],
                              // enableTooltip: true,
                              // markerSettings: const MarkerSettings( // Renders the marker
                              //     isVisible: true
                              // ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        buildSizeHeight(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => Get.to(() => const AddMeasurement()),
              child: Row(
                children: [
                  SvgPicture.asset(BaseAssets.editNotes),
                  buildSizeWidth(10),
                  const BaseText(
                    value: 'Add',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: () => measureCtrl.zoomPanBehavior.zoomOut(),
                    child: measureCtrl.isZoomedOut.value
                        ? SvgPicture.asset(BaseAssets.zoomOutEnable)
                        : SvgPicture.asset(BaseAssets.zoomOutDisable),
                  );
                }),
                buildSizeWidth(10),
                Obx(() {
                  return GestureDetector(
                    onTap: () => measureCtrl.zoomPanBehavior.zoomIn(),
                    child: measureCtrl.isZoomedIn.value
                        ? SvgPicture.asset(BaseAssets.zoomInEnable)
                        : SvgPicture.asset(BaseAssets.zoomInDisable),
                  );
                }),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
