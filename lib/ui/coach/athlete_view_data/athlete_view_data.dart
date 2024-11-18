import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_view_data/components/profile_page_card.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AthleteViewData extends StatefulWidget {
  const AthleteViewData({super.key});

  @override
  State<AthleteViewData> createState() => _AthleteViewDataState();
}

class _AthleteViewDataState extends State<AthleteViewData> {
  var athleteDataCtrl = Get.find<AthleteDataController>();

  final PageController _scrollController = PageController();

  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () {
          athleteDataCtrl.profileAthleteView(
              athleteId: athleteDataCtrl.athleteData.value.userId ?? '');
          _refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(15),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: BaseColors.grey5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipOval(
                            child:
                                (athleteDataCtrl.athleteData.value.image ?? "")
                                        .isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: athleteDataCtrl
                                                .athleteData.value.image ??
                                            '',
                                        width: 83,
                                        height: 83,
                                        fit: BoxFit.fill,
                                        errorWidget: (context, url, error) =>
                                            errorWidget(),
                                      )
                                    : Image.asset(
                                        BaseAssets.athleteProfile,
                                        width: 83,
                                        height: 83,
                                      ),
                          ),
                          buildSizeWidth(15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BaseText(
                                  value:
                                      athleteDataCtrl.athleteData.value.name ??
                                          "",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: BaseColors.black1,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const BaseText(
                                      value: 'Age:',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: BaseColors.black,
                                    ),
                                    buildSizeWidth(5),
                                    BaseText(
                                      value:
                                          "${athleteDataCtrl.athleteData.value.age ?? ""}",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      color: BaseColors.grey3,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          buildSizeWidth(20),
                          Obx(() {
                            return CustomSwitch(
                              value: athleteDataCtrl.status.value == 1,
                              activeColor: BaseColors.green2,
                              onChanged: (bool val) {
                                athleteDataCtrl.showConfirmationDialog(context);
                              },
                            );
                          }),
                        ],
                      ),
                      BaseText(
                        value:
                            'Last workout: ${athleteDataCtrl.athleteData.value.time ?? ''}',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: BaseColors.black1,
                      ),
                    ],
                  ),
                ),
                buildSizeHeight(25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BaseText(
                      value: 'Phone Number',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: BaseColors.black2,
                    ),
                    buildSizeWidth(20),
                    Expanded(
                      child: BaseText(
                        value: athleteDataCtrl.athleteData.value.mobile ?? "",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 26,
                  color: BaseColors.grey5.withOpacity(.3),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BaseText(
                      value: 'Email',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: BaseColors.black2,
                    ),
                    buildSizeWidth(20),
                    Expanded(
                      child: BaseText(
                        value: athleteDataCtrl.athleteData.value.email ?? "",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 26,
                  color: BaseColors.grey5.withOpacity(.3),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BaseText(
                      value: 'Date of Birth',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: BaseColors.black2,
                    ),
                    buildSizeWidth(20),
                    Expanded(
                      child: BaseText(
                        value: athleteDataCtrl.athleteData.value.dateOfBirth !=
                                null
                            ? dateDDMMYY(
                                athleteDataCtrl.athleteData.value.dateOfBirth!)
                            : "",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 26,
                  color: BaseColors.grey5.withOpacity(.3),
                ),
                buildSizeHeight(15),
                Obx(() {
                  if (athleteDataCtrl.bodyCompareList.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: BaseColors.grey5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: BaseColors.yellowGreen,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  buildSizeWidth(10),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BaseText(
                                        value:
                                            '${athleteDataCtrl.currentWeight}',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: BaseColors.black,
                                      ),
                                      buildSizeWidth(5),
                                      const BaseText(
                                        value: 'Weight',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: BaseColors.grey3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      color: BaseColors.yellowGreen,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  buildSizeWidth(10),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      BaseText(
                                        value:
                                            '${athleteDataCtrl.currentHeight}',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: BaseColors.black,
                                      ),
                                      buildSizeWidth(5),
                                      const BaseText(
                                        value: 'Height',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: BaseColors.grey3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        buildSizeHeight(25),
                        BaseText(
                          value:
                              'Last Update on ${dateDDMMYY(athleteDataCtrl.currentDate.value)}',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: BaseColors.grey3,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: BaseText(
                            value:
                                '${(athleteDataCtrl.pageIndex.value + 1).toString().padLeft(2)}/${athleteDataCtrl.bodyCompareList.length}',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: BaseColors.grey3,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 170,
                          child: Row(
                            children: [
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  _scrollController.previousPage(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child:
                                    SvgPicture.asset(BaseAssets.leftIndicator),
                              ),
                              buildSizeWidth(5),
                              Expanded(
                                child: PageView.builder(
                                  controller: _scrollController,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  // padding: EdgeInsets.zero,
                                  itemCount:
                                      athleteDataCtrl.bodyCompareList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return ProfilePageCard(index: index);
                                  },
                                  onPageChanged: (value) {
                                    athleteDataCtrl.pageIndex.value = value;
                                    athleteDataCtrl.getCurrentData();
                                  },

                                  // separatorBuilder: (BuildContext context, int index) =>
                                  //     buildSizeWidth(6),
                                ),
                              ),
                              buildSizeWidth(5),
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  _scrollController.nextPage(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child:
                                    SvgPicture.asset(BaseAssets.rightIndicator),
                              ),
                            ],
                          ),
                        ),
                        buildSizeHeight(20),
                        GestureDetector(
                          onLongPress: () {
                            athleteDataCtrl.showGoalEditDialog(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: BaseColors.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  BaseAssets.myGoal,
                                  width: 30,
                                ),
                                buildSizeWidth(10),
                                const BaseText(
                                  value: 'Monthly Goal',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: Obx(() {
                                    var finishedWorkout = athleteDataCtrl
                                            .athleteData
                                            .value
                                            .finishedWorkout ??
                                        '';
                                    var monthlyGoal = athleteDataCtrl
                                            .athleteData.value.monthlyGoals ??
                                        '';
                                    return BaseText(
                                      value: '$finishedWorkout/$monthlyGoal',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: BaseColors.grey5,
                                      textAlign: TextAlign.end,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        buildSizeHeight(20),
                      ],
                    );
                  } else {
                    return const SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: BaseText(value: "Athlete Data Not Found."),
                      ),
                    );
                  }
                }),
                buildSizeHeight(35),
              ],
            );
          }),
        ),
      ),
    );
  }
}
