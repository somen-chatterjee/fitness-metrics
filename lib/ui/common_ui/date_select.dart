
import 'dart:developer';

import 'package:fitness_metrics/common_controller/get_date_controller.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/controller/add_measure_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelect extends StatefulWidget {
  const DateSelect({super.key});

  @override
  State<DateSelect> createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  late GetDateController getDateCtrl;
  late AddMeasureController addMeasureCtrl;

  final List<String> _weekList = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  void initState() {
    super.initState();
    Get.delete<GetDateController>();
    getDateCtrl = Get.put(GetDateController());
    addMeasureCtrl = Get.find<AddMeasureController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDateCtrl.getCurrentMonth();
      getDateCtrl.setYear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(
              color: BaseColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: SingleChildScrollView(
                child: BaseColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Choose Date',
                          color: BaseColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
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
                                return getDateCtrl.years.reversed.map((str) {
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
                                    value: getDateCtrl.selectedYear.value
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
                                getDateCtrl.getCurrentCalender(year: int.parse(v));

                                // });
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                    buildSizeHeight(20),
                    //calender
                    Column(
                      children: [
                        Divider(
                          color: BaseColors.grey5.withOpacity(0.3),
                          height: 15,
                        ),
                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  getDateCtrl.getPreviousMonth(
                                      getDateCtrl.currentMonth.value);
                                },
                                child: const Icon(
                                  Icons.keyboard_arrow_left_rounded,
                                  color: BaseColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                              BaseText(
                                value: getDateCtrl.currentMonth.value,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              GestureDetector(
                                onTap: () {
                                  getDateCtrl.getNextMonth(
                                      getDateCtrl.currentMonth.value);
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
                        Divider(
                          color: BaseColors.grey5.withOpacity(0.3),
                          height: 15,
                        ),
                        buildSizeHeight(5),
                        // calender code
                        SizedBox(
                          width: double.infinity,
                          height: 22,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                              _weekList.length,
                                  (index) {
                                return Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                        right: index == _weekList.length - 1
                                            ? 0
                                            : 3),
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                    decoration: BoxDecoration(
                                      color: BaseColors.primaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: BaseText(
                                      value: _weekList[index],
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Obx(() {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: BaseColors.grey5),
                            ),
                            child: TableCalendar(
                              firstDay: DateTime.utc(1910, 1, 1),
                              lastDay: DateTime.now(),
                              focusedDay: getDateCtrl.focusedDay.value,
                              headerVisible: false,
                              daysOfWeekVisible: false,
                              rowHeight: 38,
                              availableGestures: AvailableGestures.none,
                              selectedDayPredicate: (day) {
                                // log("selectedDayPredicate $day");
                                return isSameDay(
                                    getDateCtrl.focusedDay.value, day);
                              },
                              calendarStyle: const CalendarStyle(
                                outsideDaysVisible: false,
                                canMarkersOverflow: false,
                                isTodayHighlighted: false,
                                selectedDecoration: BoxDecoration(
                                  color: BaseColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              onDaySelected: (selectedDay, focusedDay) {
                                log("message $focusedDay $selectedDay");
                                // getDateCtrl.selectedDate.value = selectedDay;
                                getDateCtrl.focusedDay.value = focusedDay;
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                    buildSizeHeight(10),
                    BaseButton(
                      title: 'Update',
                      btnHeight: 45,
                      leftMargin: 20,
                      rightMargin: 20,
                      onPressed: () {
                        log("selected ${getDateCtrl.focusedDay}");
                        addMeasureCtrl.selectedDate.value = getDateCtrl.focusedDay.value.toString();
                        Get.back();
                      },
                    ),
                    buildSizeHeight(20),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: BaseColors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(BaseAssets.cancel),
            ),
          ),
        ],
      ),
    );
  }
}