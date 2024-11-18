import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/task_edit/task_edit.dart';
import 'package:fitness_metrics/ui/coach/tasks/controller/task_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TasksCard extends StatefulWidget {
  final int index;

  const TasksCard({super.key, required this.index});

  @override
  State<TasksCard> createState() => _TasksCardState();
}

class _TasksCardState extends State<TasksCard> {
  var taskCtrl = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    var checkWidthHeight = 20.0;
    return GestureDetector(
      onTap: () async {
        await taskCtrl
            .getTaskView(taskId: taskCtrl.taskList[widget.index].id ?? '')
            .then((value) {
          if (value && context.mounted) {
            taskCtrl.showTaskView(
              context: context,
            );
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: BaseColors.grey5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (!(taskCtrl.taskList[widget.index].taskStatus ?? true)) {
                  taskCtrl.showTaskComplete(
                    context: context,
                    taskId: taskCtrl.taskList[widget.index].id ?? '',
                  );
                }
              },
              child: Container(
                width: checkWidthHeight,
                height: checkWidthHeight,
                alignment: Alignment.center,
                child: taskCtrl.taskList[widget.index].taskStatus ?? false
                    ? SvgPicture.asset(BaseAssets.checked)
                    : SvgPicture.asset(BaseAssets.unchecked),
              ),
            ),
            buildSizeWidth(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    value: taskCtrl.taskList[widget.index].title ?? "",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  BaseText(
                    value:
                        '${taskCtrl.taskList[widget.index].days ?? ""} at ${convertTo12HourFormat(taskCtrl.taskList[widget.index].time ?? "")}',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            buildSizeWidth(8),
            Row(
              children: [
                GestureDetector(
                    onTap: () => Get.to(() => TaskEdit(
                          taskId: taskCtrl.taskList[widget.index].id ?? '',
                        )),
                    child: SvgPicture.asset(BaseAssets.editPencil)),
                buildSizeWidth(8),
                GestureDetector(
                  onTap: () => taskCtrl.showTaskDelete(
                    context: context,
                    taskId: taskCtrl.taskList[widget.index].id ?? '',
                  ),
                  child: SvgPicture.asset(BaseAssets.delete),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
