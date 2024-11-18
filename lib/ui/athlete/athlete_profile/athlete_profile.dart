import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/athlete/athlete_profile/components/coach_view_profile.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/components/dashboard_app_bar.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/controller/athlete_dash_controller.dart';
import 'package:fitness_metrics/ui/athlete/wellness_question/wellness_question.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AthleteProfile extends StatefulWidget {
  const AthleteProfile({super.key});

  @override
  State<AthleteProfile> createState() => _AthleteProfileState();
}

class _AthleteProfileState extends State<AthleteProfile> {
  var athleteDashCtrl = Get.find<AthleteDashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const DashboardAppBar(),
          buildSizeHeight(15),
          Expanded(
            child: SingleChildScrollView(
              child: BaseColumn(
                children: [
                  //my plan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'My Plan',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      buildSizeHeight(10),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: BaseColors.primaryColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(BaseAssets.myGoal),
                                    buildSizeHeight(10),
                                    const BaseText(
                                      value: 'Monthly Goal',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    Obx(() {
                                      var finishedWorkout = athleteDashCtrl.athleteData.value.finishedWorkout ?? '';
                                      var monthlyGoal = athleteDashCtrl.athleteData.value.monthlyGoals ?? '';
                                      return BaseText(
                                        value: '$finishedWorkout/$monthlyGoal Workouts completed',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: BaseColors.grey5,
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            buildSizeWidth(16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  athleteDashCtrl.selectBody(1);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: BaseColors.grey5),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const BaseText(
                                        value: 'Start\nWorkout',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: BaseColors.black1,
                                      ),
                                      buildSizeHeight(5),
                                      Container(
                                        width: 65,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: BaseColors.yellowGreen,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildSizeHeight(15),
                  //calender
                  Column(
                    children: [
                      const Divider(
                        thickness: 1,
                        height: 22,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const BaseText(
                            value: 'Choose Date',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: BaseColors.black1,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() {
                                return BaseText(
                                  value:
                                  '${months[athleteDashCtrl.month.value -
                                      1]} ${athleteDashCtrl.year}',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: BaseColors.black1,
                                );
                              }),
                              buildSizeWidth(10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(BaseAssets.rightArrow1),
                                  buildSizeHeight(4),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        height: 22,
                      ),
                      buildSizeHeight(5),
                      // calender code
                      SizedBox(
                        width: double.infinity,
                        height: 22,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            athleteDashCtrl.weekList.length,
                                (index) {
                              return Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(
                                      right: index ==
                                          athleteDashCtrl.weekList.length -
                                              1
                                          ? 0
                                          : 3),
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                    color: BaseColors.primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: BaseText(
                                    value: athleteDashCtrl.weekList[index],
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: BaseColors.grey5),
                        ),
                        child: TableCalendar(
                          availableGestures: AvailableGestures.horizontalSwipe,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: DateTime.now(),
                          headerVisible: false,
                          daysOfWeekVisible: false,
                          rowHeight: 38,
                          calendarStyle: const CalendarStyle(
                            outsideDaysVisible: false,
                            todayDecoration: BoxDecoration(
                              color: BaseColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          calendarBuilders: CalendarBuilders(
                            selectedBuilder: (context, start, end) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: BaseColors.primaryColor,
                                ),
                              );
                            },
                          ),
                          onDaySelected: (_, l) {
                            // Get.to(() => const AddEvent());
                          },
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          onPageChanged: (date) {
                            athleteDashCtrl.month.value = date.month;
                            athleteDashCtrl.year.value = date.year;
                          },
                        ),
                      ),
                    ],
                  ),
                  buildSizeHeight(20),
                  // wellness questionnaire
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const WellnessQuestion());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: BaseColors.grey5),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(BaseAssets.wellnessQuestion),
                          buildSizeWidth(5),
                          const BaseText(
                            value: 'Wellness questionnaire',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: BaseColors.black1,
                          )
                        ],
                      ),
                    ),
                  ),
                  buildSizeHeight(25),
                  // coach profile
                  Obx(() {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: BaseColors.grey5),
                      ),
                      child: Row(
                        children: [
                          ClipOval(
                            child: (athleteDashCtrl.coachData.value.image ?? "")
                                .isNotEmpty
                                ? CachedNetworkImage(
                              imageUrl:
                              athleteDashCtrl.coachData.value.image ??
                                  '',
                              width: 44,
                              height: 44,
                              fit: BoxFit.fill,
                            )
                                : Image.asset(
                              BaseAssets.coachProfile,
                              width: 44,
                              height: 44,
                            ),
                          ),
                          buildSizeWidth(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BaseText(
                                  value: athleteDashCtrl.coachData.value.name ??
                                      '',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: BaseColors.black1,
                                ),
                                BaseText(
                                  value:
                                  athleteDashCtrl.coachData.value.mobile ??
                                      '',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: BaseColors.grey3,
                                ),
                              ],
                            ),
                          ),
                          buildSizeWidth(10),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () => Get.to(() => const CoachViewProfile()),
                            child: const BaseText(
                              value: 'View Profile',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: BaseColors.grey3,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                  buildSizeHeight(25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
