// ignore_for_file: unnecessary_import

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/coach/task_edit/models/task_edit_models.dart';
import 'package:fitness_metrics/ui/coach/tasks/controller/task_controller.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskEditController extends GetxController {
  List<String> selectedItems = [];

  List<String> weekList = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final taskFormKey = GlobalKey<FormState>();

  var taskNameCtrl = TextEditingController();
  var descriptionCtrl = TextEditingController();

  // var dayCtrl = TextEditingController();
  var timeCtrl = TextEditingController();

  TimeOfDay? selectedTimeOfDay;

  RxString selectedTime = "".obs;

  void setTime(TimeOfDay time) {
    selectedTimeOfDay = time;
    timeCtrl.text = formatTimeOfDay(time);

    selectedTime.value = "${time.hour}:${time.minute}";

    // log("time ${selectedTime.value}");

    // if (time.hour <= 12) {
    //   timeCtrl.text = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    // } else {
    //   timeCtrl.text = (time.hour % 12).toString().padLeft(2, '0');
    // }
  }

  void editTask({required String taskId}) async {
    Map<String, dynamic> mapData = {
      "task_id": taskId,
    };

    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().editTask, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          TaskEditModels response = TaskEditModels.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // setChartData(chartData: response.data ?? []);

            setTaskData(taskData: response.data ?? TaskData());

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

  void setTaskData({required TaskData taskData}) {
    taskNameCtrl.text =  taskData.title ?? '';
    descriptionCtrl.text =  taskData.description ?? '';
    (taskData.days ?? '').split(',').map((item) => selectedItems.add(item)).toList();

    setTime(stringToTimeOfDay(taskData.time ?? ''));

    update();

  }

  void taskUpdate({required String taskId}) async {
    Map<String, dynamic> mapData = {
      "title": taskNameCtrl.text.trim().toString(),
      "description": descriptionCtrl.text.trim().toString(),
      "days": selectedItems.join(","),
      "time": selectedTime.value,
      "task_id": taskId
    };

    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().taskUpdate, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
          BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // setChartData(chartData: response.data ?? []);
            Get.find<TaskController>().getTaskList();
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
}
