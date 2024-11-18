import 'dart:developer';

import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/components/coach_dashboard_app_bar.dart';
import 'package:fitness_metrics/ui/coach/dashboard/controller/coach_dash_controller.dart';
import 'package:fitness_metrics/ui/coach/task_add/task_add.dart';
import 'package:fitness_metrics/ui/coach/tasks/components/tasks_card.dart';
import 'package:fitness_metrics/ui/coach/tasks/controller/task_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:table_calendar/table_calendar.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  var coachDashCtrl = Get.find<CoachDashController>();
  var taskController = Get.put(TaskController());
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskController.getTaskList();
      taskController.monthWiseTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CoachDashboardAppBar(),
          buildSizeHeight(15),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                taskController.getTaskList();
                taskController.monthWiseTaskList();
                _refreshController.refreshCompleted();
              },
              child: SingleChildScrollView(
                child: BaseColumn(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const BaseText(
                          value: 'Tasks',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: BaseColors.black1,
                        ),
                        InkWell(
                          onTap: () => Get.to(() => const TaskAdd()),
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
                    buildSizeHeight(10),
                    Obx(() {
                      if (taskController.taskList.isNotEmpty) {
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: taskController.taskList.length,
                          itemBuilder: (context, index) {
                            return TasksCard(
                              index: index,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return buildSizeHeight(12);
                          },
                        );
                      } else {
                        return const BaseNoData(message: "No Tasks For Today");
                      }
                    }),
                    buildSizeHeight(35),
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
                                        '${months[taskController.month.value - 1]} ${taskController.year}',
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
                              coachDashCtrl.weekList.length,
                              (index) {
                                return Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(
                                      right: index ==
                                              coachDashCtrl.weekList.length - 1
                                          ? 0
                                          : 3,
                                    ),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    decoration: BoxDecoration(
                                      color: BaseColors.primaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: BaseText(
                                      value: coachDashCtrl.weekList[index],
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
                          padding: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: BaseColors.grey5),
                          ),
                          child: GetBuilder<TaskController>(builder: (logic) {
                            return TableCalendar(
                              availableGestures: AvailableGestures.horizontalSwipe,
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: taskController.currentFocusedDay,
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
                                markerBuilder: (context, day, focusedDay) {
                                  // log("sam $day");
                                  if (taskController.isDateWithTask(day)) {
                                    return Center(
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          // color: BaseColors.primaryColor,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: BaseColors.primaryColor)
                                        ),
                                      ),
                                    );
                                  }
                                  return null;
                                },
                                selectedBuilder: (context, start, end) {
                                  return Center(
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: BaseColors.primaryColor,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              onDaySelected: (selectedDay, l) {
                                if (taskController
                                    .isDateWithTask(selectedDay)) {
                                  // If the date has a task with status true, show a message

                                  taskController.getDateTaskList(
                                      date: dateYYMMDD(selectedDay.toString()));

                                } else {
                                  // If no task with status true, navigate to AddEvent
                                  Get.to(() => const TaskAdd());
                                }
                              },
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              onPageChanged: (date) {
                                log("sam $date");
                                taskController.currentFocusedDay = date;

                                taskController.month.value = date.month;
                                taskController.year.value = date.year;

                                taskController.monthWiseTaskList();
                              },
                            );
                          }),
                        ),
                      ],
                    ),
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
