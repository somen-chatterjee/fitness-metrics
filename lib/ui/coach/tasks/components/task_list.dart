import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/task_add/task_add.dart';
import 'package:fitness_metrics/ui/coach/tasks/controller/task_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskList> {
  var taskCtrl = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Task List',
            showIcon: false,
          ),
          buildSizeHeight(2),
          Expanded(
            child: BaseColumn(
              children: [
                buildSizeHeight(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    buildSizeHeight(5),
                    Divider(
                      color: BaseColors.grey5.withOpacity(0.4),
                      height: 5,
                    ),
                  ],
                ),
                buildSizeHeight(10),
                //task list
                Expanded(
                  child: Obx(() {
                    return taskCtrl.dateTaskList.isNotEmpty
                        ? ListView.separated(
                            padding: const EdgeInsets.only(bottom: 35),
                            itemCount: taskCtrl.dateTaskList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: BaseColors.grey5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BaseText(
                                            value: taskCtrl.dateTaskList[index]
                                                    .title ??
                                                "",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                          BaseText(
                                            value:
                                                '${taskCtrl.dateTaskList[index].dayName ?? ""} at ${convertTo12HourFormat(taskCtrl.dateTaskList[index].time ?? "")}',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                    buildSizeWidth(8),
                                    GestureDetector(
                                      onTap: () async {
                                        await taskCtrl
                                            .getTaskView(
                                                taskId: taskCtrl
                                                        .dateTaskList[index]
                                                        .id ??
                                                    "")
                                            .then((value) {
                                          if (value && context.mounted) {
                                            taskCtrl.showTaskView(
                                                context: context,
                                            );
                                          }
                                        });
                                      },
                                      child: SvgPicture.asset(BaseAssets.eye),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return buildSizeHeight(10);
                            },
                          )
                        : const BaseNoData(message: "No Task This Date!");
                  }),
                ),
                buildSizeHeight(10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
