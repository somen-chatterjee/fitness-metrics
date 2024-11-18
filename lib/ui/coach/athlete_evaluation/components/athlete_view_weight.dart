
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/controller/weight_view_controller.dart';
import 'package:fitness_metrics/ui/common_ui/athlete_update_weight.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  var athleteDataCtrl = Get.find<AthleteDataController>();
  late WeightViewController weightViewCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<WeightViewController>();
    weightViewCtrl = Get.put(WeightViewController());
    weightViewCtrl.athleteDetailsCoachViewChart();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                        value: weightViewCtrl.selectedMonth.value,
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
                    weightViewCtrl.selectedMonth.value = v;
                    weightViewCtrl.athleteDetailsCoachViewChart();
                    // });
                  },
                ),
              ),
            ],
          );
        }),
        GetBuilder<WeightViewController>(
          builder: (weightViewCtrl) {
            if(weightViewCtrl.weightDataList.isNotEmpty) {
              return Expanded(
              child: SfCartesianChart(
                key: UniqueKey(),
                // tooltipBehavior: TooltipBehavior(enable: true),
                zoomPanBehavior: weightViewCtrl.zoomPanBehavior,
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

                  if (currentZoomLevel == 0.2) {
                    weightViewCtrl.isZoomedIn.value = false;
                  } else {
                    weightViewCtrl.isZoomedIn.value = true;
                  }

                  if (currentZoomLevel == 1.0) {
                    weightViewCtrl.isZoomedOut.value = false;
                  } else {
                    weightViewCtrl.isZoomedOut.value = true;
                  }
                },

                series: <CartesianSeries>[
                  // Renders spline chart
                  SplineSeries<SplineData, String>(
                    dataSource: weightViewCtrl.weightDataList,
                    xValueMapper: (SplineData data, _) => data.x,
                    yValueMapper: (SplineData data, _) => data.y,
                    color: BaseColors.primaryColor,
                    // enableTooltip: true,
                    // markerSettings: const MarkerSettings( // Renders the marker
                    //     isVisible: true
                    // ),
                  ),
                ],
              ),
            );
            } else {
              return const BaseNoData(message: "No Chart Data Found!");
            }
          },
        ),
        buildSizeHeight(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Get.to(() => const AthleteUpdateWeight()),
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
                    onTap: () => weightViewCtrl.zoomPanBehavior.zoomOut(),
                    child: weightViewCtrl.isZoomedOut.value
                        ? SvgPicture.asset(BaseAssets.zoomOutEnable)
                        : SvgPicture.asset(BaseAssets.zoomOutDisable),
                  );
                }),
                buildSizeWidth(10),
                Obx(() {
                  return GestureDetector(
                    onTap: () => weightViewCtrl.zoomPanBehavior.zoomIn(),
                    child: weightViewCtrl.isZoomedIn.value
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
