import 'dart:developer';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/add_exercise/models/section_exercise_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/controllers/create_workout_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/controller/coach_archive_controller.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/models/exercises_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class AddExerciseController extends GetxController{

  // exercise list get process
  RxList<ExerciseData> exerciseList = <ExerciseData>[].obs;

  RxList<ExerciseData> exerciseDisplayList = <ExerciseData>[].obs;

  Future<bool> getExerciseList() async {
    bool isSuccess = false;

    Map<String, dynamic> mapData = {};

    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().exerciseList, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          ExercisesModel response = ExercisesModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            exerciseList.value = response.data ?? [];
            isSuccess = true;
            suggestionsCallback("");
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
    return isSuccess;
  }

  // match the search string
  Future<List<ExerciseData>> suggestionsCallback(String pattern) async =>
      await Future<List<ExerciseData>>.delayed(
        const Duration(milliseconds: 100),
            () => exerciseList.where((product) {
          final nameLower = (product.name ?? '').toLowerCase().split(' ').join('');
          final patternLower = pattern.toLowerCase().split(' ').join('');
          return nameLower.contains(patternLower);
        }).toList(),
      );

  List<ExerciseData> exerciseSelectedList = <ExerciseData>[];

  addDataToSelectedList({required ExerciseData exerciseData, required String sectionId}) async {
    log("printList ${exerciseData.name} ${exerciseData.id}");

    if(!exerciseData.isSelected!) {
      exerciseSelectedList.add(exerciseData);
    }else{
      exerciseSelectedList.remove(exerciseData);
    }

    exerciseData.isSelected = !exerciseData.isSelected!;

    coachSectionExerciseCreate(sectionId: sectionId);
  }

  Future<bool> coachSectionExerciseCreate({required String sectionId}) async {
    var createWorkoutCtrl = Get.find<CreateWorkoutController>();
    var coachArchiveCtrl = Get.find<CoachArchiveController>();
    var athleteDataCtrl = Get.find<AthleteDataController>();

    bool isSuccess = false;

    Map<String, dynamic> mapData = {
      "athlete_id": athleteDataCtrl.athleteData.value.userId?.toString() ?? '',
      "plan_id": coachArchiveCtrl.selectedPlan.id?.toString() ?? '',
      "section_id": sectionId,
      "workout_id": createWorkoutCtrl.selectedWorkoutData?.id ?? '',
      "exercise_ids": exerciseSelectedList.map((obj) => obj.id.toString()).join(',')
    };

    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().coachSectionExerciseCreate, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            sectionExerciseList(sectionId: sectionId);
            // athleteData.value = response.data?.user ?? User();
            // exerciseList.value = response.data ?? [];
            // isSuccess = true;
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

  Future<bool> sectionExerciseList({required String sectionId}) async {
    var createWorkoutCtrl = Get.find<CreateWorkoutController>();
    bool isSuccess = false;

    Map<String, dynamic> mapData = {
      "section_id": sectionId,
      "workout_id": createWorkoutCtrl.selectedWorkoutData?.id ?? '',
    };

    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().sectionExerciseList, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          SectionExerciseModel response = SectionExerciseModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            exerciseDisplayList.value = response.data ?? [];
            setSelectedData(exerciseDisplayList);
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

  setSelectedData(List<ExerciseData> list) async{
    if(exerciseList.isNotEmpty) {
      for(var i in exerciseList) {
        bool isMatched = list.any((obj) => i.id == obj.id);

        if(isMatched) {
          i.isSelected = true;
          exerciseSelectedList.add(i);
        }

      }
    }
  }

// void monitorListChanges(Sections newItem) {
//   if (oldItems.contains(newItem) || oldItems.isEmpty) {
//     // Show the button if a specific new item is added
//     isButtonVisible.value = true;
//   }
//   // else {
//   //   // Hide the button if the item is not present
//   //   isButtonVisible.value = false;
//   // }
// }

}


