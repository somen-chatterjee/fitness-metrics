import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/ui/coach/components/coach_dashboard_app_bar1.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteData extends StatefulWidget {
  final String profileTitle;
  final String athleteId;

  const AthleteData({super.key, required this.profileTitle, required this.athleteId});

  @override
  State<AthleteData> createState() => _AthleteDataState();
}

class _AthleteDataState extends State<AthleteData> {
  var athleteDataCtrl = Get.put(AthleteDataController());

  @override
  void initState() {
    super.initState();
    athleteDataCtrl.profileAthleteView(athleteId: widget.athleteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CoachDashboardAppBar1(profileTitle: widget.profileTitle),
          buildSizeHeight(15),
          Expanded(
            child: Obx(() {
              return BaseColumn(
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: BaseColors.grey5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => athleteDataCtrl.selectBody(0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: athleteDataCtrl.selectedIndex.value == 0
                                    ? BaseColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: BaseText(
                                value: 'Data',
                                fontSize: 14,
                                fontWeight:
                                    athleteDataCtrl.selectedIndex.value == 0
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                color: athleteDataCtrl.selectedIndex.value == 0
                                    ? BaseColors.white
                                    : BaseColors.black1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        // buildSizeWidth(10),
                        Expanded(
                          child: InkWell(
                            onTap: () => athleteDataCtrl.selectBody(1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: athleteDataCtrl.selectedIndex.value == 1
                                    ? BaseColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: BaseText(
                                value: 'Evaluation',
                                fontSize: 14,
                                fontWeight:
                                    athleteDataCtrl.selectedIndex.value == 1
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                color: athleteDataCtrl.selectedIndex.value == 1
                                    ? BaseColors.white
                                    : BaseColors.black1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => athleteDataCtrl.selectBody(2),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: athleteDataCtrl.selectedIndex.value == 2
                                    ? BaseColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: BaseText(
                                value: 'Workouts',
                                fontSize: 14,
                                fontWeight:
                                    athleteDataCtrl.selectedIndex.value == 2
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                color: athleteDataCtrl.selectedIndex.value == 2
                                    ? BaseColors.white
                                    : BaseColors.black1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildSizeHeight(20),
                  Expanded(
                    child:
                        athleteDataCtrl.bodyList[athleteDataCtrl.selectedIndex.value],
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
