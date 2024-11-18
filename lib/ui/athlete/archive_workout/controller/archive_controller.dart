// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/archive_workout/models/plan_workout_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class ArchiveController extends GetxController {
  RxInt workoutType = 0.obs;

  selectType({required int type}) {
    workoutType.value = type;
  }

  RxList<PlanWorkoutData> planWorkoutDataList = <PlanWorkoutData>[].obs;

  void planWorkoutGet({required String planId}) async {
    Map<String, dynamic> mapData = {
      "plan_id": planId,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().planWorkoutGet, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          PlanWorkoutModel response = PlanWorkoutModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            planWorkoutDataList.value = response.data ?? [];
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

  int? selectedIndex;

  selectWorkout({required int index}) {
    planWorkoutDataList.map((obj){
      if (obj.id == planWorkoutDataList[index].id) {
        // log("tre1 ${selectedIndex} $index");
        obj.isSelected = true;
        selectedIndex = index;
        update();
        // log("tre2 ${selectedIndex} $index");

      }else{
        obj.isSelected = false;
      }
    }).toList();
    planWorkoutDataList.refresh();
  }
}
