import 'dart:developer';

import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/components/group_cards.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/controller/all_group_controller.dart';
import 'package:fitness_metrics/ui/coach/group_athletes/create_group.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GroupAthletes extends StatefulWidget {
  const GroupAthletes({super.key});

  @override
  State<GroupAthletes> createState() => _GroupAthletesState();
}

class _GroupAthletesState extends State<GroupAthletes> {
  var allGroupCtrl = Get.put(AllGroupController());

  @override
  void initState() {
    super.initState();
    allGroupCtrl.getGroupList(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    log("sam ${allGroupCtrl.currentPage} ${allGroupCtrl.lastPage}");
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(title: 'Athletes group'),
          buildSizeHeight(15),
          Expanded(
            child: BaseColumn(
              children: [
                buildSizeHeight(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BaseText(
                      value: 'Athletes',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: BaseColors.black1,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => Get.to(() => const CreateGroup()),
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
                buildSizeHeight(15),
                Flexible(
                  child: Obx(() {
                    return SmartRefresher(
                      enablePullUp:
                          allGroupCtrl.currentPage != allGroupCtrl.lastPage,
                      controller: allGroupCtrl.refreshController,
                      onLoading: () {
                        if (allGroupCtrl.currentPage != allGroupCtrl.lastPage) {
                          allGroupCtrl.getGroupList(
                            page: allGroupCtrl.currentPage += 1,
                          );
                        }
                      },
                      onRefresh: () {
                        allGroupCtrl.getGroupList(page: 1);
                      },
                      child: allGroupCtrl.groupList.isNotEmpty
                          ? ListView.separated(
                              padding: const EdgeInsets.only(
                                bottom: 35,
                              ),
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: allGroupCtrl.groupList.length,
                              itemBuilder: (context, index) {
                                return GroupCards(
                                  groupData: allGroupCtrl.groupList[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return buildSizeHeight(12);
                              },
                            )
                          : const BaseNoData(
                              message: "No Group Found!",
                            ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
