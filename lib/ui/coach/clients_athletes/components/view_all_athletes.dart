import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/components/athlete_cards.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/controller/all_athlete_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ViewAllAthletes extends StatefulWidget {
  const ViewAllAthletes({super.key});

  @override
  State<ViewAllAthletes> createState() => _ViewAllAthletesState();
}

class _ViewAllAthletesState extends State<ViewAllAthletes> {
  var allAthleteCtrl = Get.put(AllAthleteController());

  @override
  void initState() {
    super.initState();
    allAthleteCtrl.getAthleteForCoach(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(title: 'All Athletes'),
          buildSizeHeight(15),
          Expanded(
            child: BaseColumn(
              children: [
                // athlete list
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseText(
                      value: 'Athletes List',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: BaseColors.grey,
                    ),
                  ],
                ),
                buildSizeHeight(15),
                Flexible(
                  child: Obx(() {
                    return SmartRefresher(
                      enablePullUp:
                          allAthleteCtrl.currentPage != allAthleteCtrl.lastPage,
                      controller: allAthleteCtrl.refreshController,
                      onLoading: () {
                        if (allAthleteCtrl.currentPage !=
                            allAthleteCtrl.lastPage) {
                          allAthleteCtrl.getAthleteForCoach(
                              page: allAthleteCtrl.currentPage += 1);
                        }
                      },
                      onRefresh: () {
                        allAthleteCtrl.getAthleteForCoach(page: 1);
                      },
                      child: allAthleteCtrl.athleteList.isNotEmpty
                          ? ListView.separated(
                        padding: const EdgeInsets.only(bottom: 25),
                        // shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: allAthleteCtrl.athleteList.length,
                        itemBuilder: (context, index) {
                          return AthleteCards(
                            athleteData: allAthleteCtrl.athleteList[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return buildSizeHeight(12);
                        },
                      )
                      : const BaseNoData(message: "No Athletes Found!"),
                    );
                  }),
                ),
                // buildSizeHeight(35),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
