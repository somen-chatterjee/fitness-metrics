

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/tasks/components/task_list.dart';
import 'package:fitness_metrics/ui/coach/tasks/models/calendar_data_list_model.dart';
import 'package:fitness_metrics/ui/coach/tasks/models/date_task_list_model.dart';
import 'package:fitness_metrics/ui/coach/tasks/models/task_list_model.dart';
import 'package:fitness_metrics/ui/coach/tasks/models/task_view_model.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {

  RxInt year = DateTime.now().year.obs;
  RxInt month = DateTime.now().month.obs;

  RxList<TaskData> taskList = <TaskData>[].obs;
  RxList<CalendarData> calendarDataList = <CalendarData>[].obs;

  void getTaskList() async {

    Map<String, dynamic> mapData = {};
    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().taskList, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          TaskListModel response =
          TaskListModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            taskList.value = response.data ?? [];
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          // log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  DateTime currentFocusedDay = DateTime.now();

  bool isDateWithTask(DateTime day) {
    String formattedDate = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    // log("sam  $formattedDate");
    return calendarDataList.any((task) => task.date == formattedDate && (task.status ?? false));
  }

  void monthWiseTaskList() async {

    Map<String, dynamic> mapData = {
      "month": months[month.value - 1],
      "year": year.value,
    };
    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().monthWiseTaskList, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          CalendarDataListModel response =
          CalendarDataListModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            calendarDataList.value = response.data ?? [];
            update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          // log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  void taskComplete({required String taskId}) async {

    Map<String, dynamic> mapData = {
      "task_id": taskId,
    };
    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().taskComplete, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
          BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            getTaskList();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          // log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  void taskDelete({required String taskId}) async {

    Map<String, dynamic> mapData = {
      "task_id": taskId,
    };
    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().taskDelete, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
          BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            getTaskList();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          // log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  RxList<DateTaskData> dateTaskList = <DateTaskData>[].obs;

  void getDateTaskList({required String date}) async {
    Map<String, dynamic> mapData = {
      "date": date,
    };

    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().dateWiseTaskList, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          DateTaskListModel response = DateTaskListModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // setChartData(chartData: response.data ?? []);
            dateTaskList.value = response.data ?? [];

            Get.to(() => const TaskList());

          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          // log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  Rx<TaskViewData> taskViewData = TaskViewData().obs;

  Future<bool> getTaskView({required String taskId}) async {
    bool isSuccess = false;
    Map<String, dynamic> mapData = {
      "task_id": taskId,
    };

    // log("$mapData");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().taskView, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          TaskViewModel response = TaskViewModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // setChartData(chartData: response.data ?? []);
            taskViewData.value = response.data ?? TaskViewData();

            isSuccess = true;

          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          // log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });

    return isSuccess;
  }

  Future<Object?> showTaskDelete(
      {required BuildContext context,
        required String taskId}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            title: const BaseText(
              value:
              'Are you sure you want to delete this task? This action wil not revert back...',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            // content: const BaseText(value: 'We are glad to see your progress...'),
            actions: <Widget>[
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);
                  taskDelete(taskId: taskId);
                },
                title: 'Yes',
              ),
              buildSizeHeight(5),
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                title: 'No',
              ),
            ],
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }

  Future<Object?> showTaskComplete(
      {required BuildContext context,
        required String taskId}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            title: const BaseText(
              value:
              'Are you sure you want to mark this task as finished for today? This action wil not revert back...',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            content: const BaseText(value: 'We are glad to see your progress...'),
            actions: <Widget>[
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);
                  taskComplete(taskId: taskId);
                },
                title: 'Yes',
              ),
              buildSizeHeight(5),
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                title: 'No',
              ),
            ],
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }

  Future<Object?> showTaskView(
      {required BuildContext context}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              // height: 400,
              padding:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BaseText(
                          value: 'View Task',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          color: BaseColors.black1,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: SvgPicture.asset(BaseAssets.cancel),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: BaseColors.grey),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Task Title: ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        color: BaseColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      BaseText(
                        value: taskViewData.value.title ?? '',
                        color: BaseColors.black1,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ],
                  ),
                  buildSizeHeight(8),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Task description: ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        color: BaseColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      BaseText(
                        value: taskViewData.value.description ?? '',
                        color: BaseColors.black1,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ],
                  ),
                  buildSizeHeight(8),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Task days and time: ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        color: BaseColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      BaseText(
                        value: '${taskViewData.value.days ?? ""} at ${convertTo12HourFormat(taskViewData.value.time ?? "")}',
                        color: BaseColors.black1,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ],
                  ),
                  buildSizeHeight(5),
                ],
              ),
            ),
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }
}