import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/controller/athlete_dash_controller.dart';
import 'package:fitness_metrics/ui/athlete/settings_data/components/profile_page_card.dart';
import 'package:fitness_metrics/ui/athlete/settings_data_edit/settings_data_edit.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SettingsData extends StatefulWidget {
  const SettingsData({super.key});

  @override
  State<SettingsData> createState() => _SettingsDataState();
}

class _SettingsDataState extends State<SettingsData> {
  var athleteDashCtrl = Get.find<AthleteDashController>();

  final PageController _scrollController = PageController();
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () {
        athleteDashCtrl.profileDataAthlete();
        _refreshController.refreshCompleted();
      },
      child: athleteDashCtrl.athleteData.value.name != null
          ? SingleChildScrollView(
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(15),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                                    (athleteDashCtrl.athleteData.value.image ??
                                                "")
                                            .isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: athleteDashCtrl
                                                    .athleteData.value.image ??
                                                '',
                                            width: 83,
                                            height: 83,
                                            fit: BoxFit.fill,
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
                                      value: athleteDashCtrl
                                              .athleteData.value.name ??
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
                                              "${athleteDashCtrl.athleteData.value.age ?? ""}",
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
                              const BaseText(
                                value: 'Active',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: BaseColors.green1,
                              ),
                            ],
                          ),
                          if ((athleteDashCtrl.athleteData.value.time ?? "")
                              .isNotEmpty)
                            BaseText(
                              value:
                                  'Last workout: ${athleteDashCtrl.athleteData.value.time ?? ""}',
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
                            value:
                                athleteDashCtrl.athleteData.value.mobile ?? "",
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
                            value:
                                athleteDashCtrl.athleteData.value.email ?? "",
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
                            value:
                                athleteDashCtrl.athleteData.value.dateOfBirth !=
                                        null
                                    ? dateDDMMYY(athleteDashCtrl
                                        .athleteData.value.dateOfBirth!)
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 18),
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
                                              '${athleteDashCtrl.currentWeight}',
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
                                              '${athleteDashCtrl.currentHeight}',
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
                                'Last Update on ${dateDDMMYY(athleteDashCtrl.currentDate.value)}',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: BaseColors.grey3,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: BaseText(
                              value:
                                  '${(athleteDashCtrl.pageIndex.value + 1).toString().padLeft(2)}/${athleteDashCtrl.bodyCompareList.length}',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: BaseColors.grey3,
                            ),
                          ),
                        ],
                      );
                    }),
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
                                  SvgPicture.asset(BaseAssets.leftIndicator)),
                          buildSizeWidth(5),
                          Expanded(
                            child: PageView.builder(
                              controller: _scrollController,
                              // physics: const NeverScrollableScrollPhysics(),
                              // padding: EdgeInsets.zero,
                              itemCount: athleteDashCtrl.bodyCompareList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return ProfilePageCard(index: index);
                              },
                              onPageChanged: (value) {
                                athleteDashCtrl.pageIndex.value = value;
                                athleteDashCtrl.getCurrentData();
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
                            child: SvgPicture.asset(BaseAssets.rightIndicator),
                          ),
                        ],
                      ),
                    ),
                    buildSizeHeight(45),
                    BaseButton(
                      title: "Edit Info",
                      borderRadius: 15,
                      fontSize: 18,
                      btnColor: BaseColors.primaryColor,
                      leftMargin: 30,
                      rightMargin: 30,
                      onPressed: () {
                        Get.to(() => const SettingsDataEdit());
                      },
                    ),
                    buildSizeHeight(10),
                    BaseButton(
                      title: "Log Out",
                      borderRadius: 15,
                      fontSize: 18,
                      btnColor: BaseColors.primaryColor,
                      leftMargin: 30,
                      rightMargin: 30,
                      onPressed: () {
                        Get.find<CommonController>().showLogoutDialog(context);
                        // clearSessionData();
                      },
                    ),
                    buildSizeHeight(25),
                  ],
                );
              }),
            )
          : const Center(child: BaseNoData(message: "No Athlete Data Found!")),
    );
  }
}
