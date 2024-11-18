import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/components/athlete_cards.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/components/group_cards.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/components/view_all_athletes.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/controller/client_athlete_controller.dart';
import 'package:fitness_metrics/ui/coach/group_athletes/group_athletes.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClientAthletes extends StatefulWidget {
  const ClientAthletes({super.key});

  @override
  State<ClientAthletes> createState() => _ClientAthletesState();
}

class _ClientAthletesState extends State<ClientAthletes> {
  var clientAthleteCtrl = Get.put(ClientAthleteController());

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    clientAthleteCtrl.getGroupDashboardList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Athletes',
            showBackIcon: false,
          ),
          buildSizeHeight(15),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                clientAthleteCtrl.getGroupDashboardList();
                _refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                child: BaseColumn(
                  children: [
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const BaseText(
                          value: 'Athletes',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: BaseColors.black1,
                        ),
                        GestureDetector(
                          onTap: () => Get.to(() => const GroupAthletes()),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(BaseAssets.editNotes),
                              buildSizeWidth(10),
                              const BaseText(
                                value: 'Add',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: BaseColors.black1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    buildSizeHeight(20),*/

                    // athlete group
                    Obx(() {
                      if (clientAthleteCtrl.athleteList.isNotEmpty) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const BaseText(
                                  value: 'Athletes Group',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: BaseColors.grey,
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Get.to(() => const GroupAthletes()),
                                  child: const BaseText(
                                    value: "View All",
                                    underline: true,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: BaseColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            buildSizeHeight(15),
                            Obx(() {
                              return clientAthleteCtrl.groupList.isNotEmpty
                                  ? ListView.separated(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          clientAthleteCtrl.groupList.length,
                                      itemBuilder: (context, index) {
                                        return GroupCards(
                                          groupData: clientAthleteCtrl
                                              .groupList[index],
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return buildSizeHeight(12);
                                      },
                                    )
                                  : const BaseNoData(
                                      message: "No Group Found!");
                            }),
                            buildSizeHeight(25),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),

                    // athlete list
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BaseText(
                          value: 'Athletes List',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: BaseColors.grey,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ViewAllAthletes());
                          },
                          child: const BaseText(
                            value: "View All",
                            underline: true,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: BaseColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    buildSizeHeight(15),
                    Obx(() {
                      return clientAthleteCtrl.athleteList.isNotEmpty
                          ? ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: clientAthleteCtrl.athleteList.length,
                              itemBuilder: (context, index) {
                                return AthleteCards(
                                  athleteData:
                                      clientAthleteCtrl.athleteList[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return buildSizeHeight(12);
                              },
                            )
                          : const Padding(
                              padding: EdgeInsets.only(top: 50.0),
                              child: BaseNoData(message: "No Athlete Found!"),
                            );
                    }),
                    buildSizeHeight(35),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
