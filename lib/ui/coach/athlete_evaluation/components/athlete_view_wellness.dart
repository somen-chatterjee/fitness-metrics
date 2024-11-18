import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/controller/wellness_view_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Wellness extends StatefulWidget {
  const Wellness({super.key});

  @override
  State<Wellness> createState() => _WellnessState();
}

class _WellnessState extends State<Wellness> {
  late WellnessController wellnessCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<WellnessController>();
    wellnessCtrl = Get.put(WellnessController());

    wellnessCtrl.wellnessItemSelect.value = "All";
    // wellnessCtrl.getCurrentMonth();
    // wellnessCtrl.createYear();
    // wellnessCtrl.setYear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      wellnessCtrl.wellnessQuestionnaireChart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseText(
          value: 'Wellness',
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
        buildSizeHeight(25),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 280,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BaseText(
                    value: 'Wellness',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: BaseColors.lightBlue.withOpacity(0.4))),
                        color: BaseColors.white,
                        offset: const Offset(0, 2),
                        position: PopupMenuPosition.under,
                        onSelected: (v) {
                          setState(() {
                            // print('!!!===== $v');
                            wellnessCtrl.wellnessItemSelect.value = v;
                          });
                        },
                        itemBuilder: (context) {
                          return wellnessCtrl.wellnessItems.map((str) {
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
                              value: wellnessCtrl.wellnessItemSelect.value,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: BaseColors.grey5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
              buildSizeHeight(10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  wellnessCtrl.colorList.length,
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
                              color: wellnessCtrl.colorList[index]['color']),
                        ),
                        buildSizeWidth(5),
                        BaseText(
                          value: wellnessCtrl.colorList[index]['title'],
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                        buildSizeWidth(10),
                      ],
                    );
                  },
                ),
              ),
              buildSizeHeight(10),
              Expanded(
                child: GetBuilder<WellnessController>(
                  builder: (ctrl) {
                    return SfCartesianChart(
                      key: UniqueKey(),
                      // tooltipBehavior: TooltipBehavior(enable: true),
                      zoomPanBehavior: wellnessCtrl.zoomPanBehavior,
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
                          wellnessCtrl.isZoomedIn.value = false;
                        } else {
                          wellnessCtrl.isZoomedIn.value = true;
                        }

                        if (currentZoomLevel == 1.0) {
                          wellnessCtrl.isZoomedOut.value = false;
                        } else {
                          wellnessCtrl.isZoomedOut.value = true;
                        }
                      },

                      series: <CartesianSeries>[
                        // Renders spline chart

                        if (ctrl.wellnessItemSelect.value == "All" ||
                            ctrl.wellnessItemSelect.value == "Sleep")
                          SplineSeries<SplineData, String>(
                            dataSource: ctrl.sleepDataList,
                            xValueMapper: (SplineData data, _) => data.x,
                            yValueMapper: (SplineData data, _) => data.y,
                            color: ctrl.colorList[0]['color'],
                            // enableTooltip: true,
                            // markerSettings: const MarkerSettings( // Renders the marker
                            //     isVisible: true
                            // ),
                          ),
                        if (ctrl.wellnessItemSelect.value == "All" ||
                            ctrl.wellnessItemSelect.value == "Stress")
                          SplineSeries<SplineData, String>(
                            dataSource: ctrl.stressDataList,
                            xValueMapper: (SplineData data, _) => data.x,
                            yValueMapper: (SplineData data, _) => data.y,
                            color: ctrl.colorList[1]['color'],
                            // enableTooltip: true,
                            // markerSettings: const MarkerSettings( // Renders the marker
                            //     isVisible: true
                            // ),
                          ),
                        if (ctrl.wellnessItemSelect.value == "All" ||
                            ctrl.wellnessItemSelect.value == "Fatigue")
                          SplineSeries<SplineData, String>(
                            dataSource: ctrl.fatigueDataList,
                            xValueMapper: (SplineData data, _) => data.x,
                            yValueMapper: (SplineData data, _) => data.y,
                            color: ctrl.colorList[2]['color'],
                            // enableTooltip: true,
                            // markerSettings: const MarkerSettings( // Renders the marker
                            //     isVisible: true
                            // ),
                          ),
                        if (ctrl.wellnessItemSelect.value == "All" ||
                            ctrl.wellnessItemSelect.value == "REP")
                          SplineSeries<SplineData, String>(
                            dataSource: ctrl.rpeDataList,
                            xValueMapper: (SplineData data, _) => data.x,
                            yValueMapper: (SplineData data, _) => data.y,
                            color: ctrl.colorList[3]['color'],
                            // enableTooltip: true,
                            // markerSettings: const MarkerSettings( // Renders the marker
                            //     isVisible: true
                            // ),
                          ),
                        if (ctrl.wellnessItemSelect.value == "All" ||
                            ctrl.wellnessItemSelect.value == "Muscle Soreness")
                          SplineSeries<SplineData, String>(
                            dataSource: ctrl.sorenessDataList,
                            xValueMapper: (SplineData data, _) => data.x,
                            yValueMapper: (SplineData data, _) => data.y,
                            color: ctrl.colorList[4]['color'],
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
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  return GestureDetector(
                    onTap: () => wellnessCtrl.zoomPanBehavior.zoomOut(),
                    child: wellnessCtrl.isZoomedOut.value
                        ? SvgPicture.asset(BaseAssets.zoomOutEnable)
                        : SvgPicture.asset(BaseAssets.zoomOutDisable),
                  );
                }),
                buildSizeWidth(10),
                Obx(() {
                  return GestureDetector(
                    onTap: () => wellnessCtrl.zoomPanBehavior.zoomIn(),
                    child: wellnessCtrl.isZoomedIn.value
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
