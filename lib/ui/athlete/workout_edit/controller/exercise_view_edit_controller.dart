import 'dart:convert';
import 'dart:developer';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/athlete/start_workout/controller/start_workout_controller.dart';
import 'package:fitness_metrics/ui/athlete/workout_details/controllers/workout_details_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/edit_exercise/models/exercise_view_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ExerciseViewEditController extends GetxController {

  RxBool isEdit = false.obs;

  RxList<Rules> rulesViewList = <Rules>[].obs;
  RxList<Rules> rulesEditList = <Rules>[].obs;
  RxString section = ''.obs;
  RxString exerciseName = ''.obs;
  RxBool load = false.obs;
  RxInt setIndex = 0.obs;

  RxString videoUrl = ''.obs;
  RxString blockNote = ''.obs;

  var exerciseFormKey = GlobalKey<FormState>();

  Future<bool> exerciseRulesView(
      {required String workoutId,required String sectionId, required String exerciseId}) async {

    bool isSuccess = false;

    Map<String, dynamic> mapData = {
      "workout_id": workoutId,
      "exercise_id": exerciseId,
      "section_id": sectionId
    };

    // log("$mapData");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().exerciseRulesViewAthlete, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          ExerciseViewModel response = ExerciseViewModel.fromJson(value?.data);
          if (response.status ?? false) {
            isSuccess = true;
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            rulesEditList.value = response.data?.rules ?? [];
            rulesViewList.value = response.data?.rules ?? [];
            section.value = response.data?.section ?? '';
            exerciseName.value = response.data?.name ?? '';
            videoUrl.value = response.data?.videoUrl ?? '';
            blockNote.value = response.data?.note ?? '';

            if (rulesViewList.isNotEmpty) {
              // check the training has load or not
              load.value = rulesViewList
                  .any((value) => value.trainingId.toString() == "5");
            }
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


  TextInputType? setInputType({required Rules rules}) {
    return rules.trainingId.toString() == "1" ||
            rules.trainingId.toString() == "2" ||
            rules.trainingId.toString() == "5"
        ? TextInputType.number
        : null;
  }

  List<TextInputFormatter>? setInputFormatter({required Rules rules}) {
    return rules.trainingId.toString() == "1" ||
            rules.trainingId.toString() == "2" ||
            rules.trainingId.toString() == "5"
        ? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*$')),
          ]
        : null;
  }

  // The new function to handle the onChanged logic for load and sets
  Future<void> handleLoadChange(String val) async {
    if (val.isNotEmpty) {
      // Parse the input value as an integer
      int numberOfSets = int.tryParse(val) ?? 0;

      // Find and store the original REP and Load training names and IDs

      var loadEntry =
          rulesEditList.firstWhere((element) => element.trainingId.toString() == "5");

      // Get the base names (without numbers)
      String baseLoadName = loadEntry.training.split(' ')[0]; // "Load"

      // Remove only existing REP and Load entries, leave ROM intact
      rulesEditList.removeWhere((element) => element.trainingId.toString() == "5");

      // Insert new REP and Load entries dynamically
      for (int i = 1; i <= numberOfSets; i++) {
        rulesEditList.add(newLoad("$baseLoadName $i",
            loadEntry.trainingId.toString())); // E.g., "Load 1", "Load 2"
      }

      await Future.delayed(const Duration(seconds: 1));
      // Refresh the list to update the UI
      rulesEditList.refresh();
    }
  }

  // The new function to handle the onChanged logic for sets
  Future<void> handleRepChange({required String onChangeVal, bool? initialValue}) async {
    if (onChangeVal.isNotEmpty) {
      // Parse the input value as an integer
      int numberOfSets = int.tryParse(onChangeVal) ?? 0;

      // Find and store the original REP and Load training names and IDs
      var repEntry =
          rulesEditList.firstWhere((element) => element.trainingId.toString() == "2");

      // Get the base names (without numbers)
      String baseRepName = repEntry.training.split(' ')[0]; // "REP"

      // Remove only existing REP and Load entries, leave ROM intact
      rulesEditList.removeWhere((element) => element.trainingId.toString() == "2");

      // Insert new REP and Load entries dynamically
      for (int i = 1; i <= numberOfSets; i++) {
        rulesEditList.add(newRep(
            "$baseRepName $i", initialValue ?? repEntry.trainingId.toString())); // E.g., "REP 1", "REP 2"
      }

      await Future.delayed(const Duration(seconds: 1));

      // Refresh the list to update the UI
      rulesEditList.refresh();
    }
  }

  Future<void> initialRepChange({required String onChangeVal}) async {
    if (onChangeVal.isNotEmpty) {
      // Parse the input value as an integer

      // Find and store the original REP and Load training names and IDs
      var repEntry = rulesEditList.firstWhere((element) => element.trainingId.toString() == "2");

      // Split REP and Load values
      List<String> repValues = repEntry.value.split('/');

      // Get the base REP name (without numbers)
      String baseRepName = repEntry.training.split(' ')[0]; // "REP"

      // Remove only existing REP and Load entries, leave ROM intact
      rulesEditList.removeWhere((element) => element.trainingId.toString() == "2");

      // Insert new REP and Load entries dynamically
      // if (initialValue == true) {
        // If initialValue is true, create dynamic list with individual REP and Load values
        for (int i = 0; i < repValues.length; i++) {
          // Add REP entries like {"training_id": "2", "training": "REP", "value": "12"}

          rulesEditList.add(newRep1("$baseRepName ${i+1}", repEntry.trainingId, repValues[i]));
        }
      // } else {
      //   // If initialValue is false or null, insert REP entries with numbers
      //   for (int i = 1; i <= numberOfSets; i++) {
      //     rulesEditList.add(newRep("$baseRepName $i", initialValue ?? repEntry.trainingId.toString())); // E.g., "REP 1", "REP 2"
      //   }
      // }

      await Future.delayed(const Duration(seconds: 1));

      // Refresh the list to update the UI
      rulesEditList.refresh();

      log("sam ${jsonEncode(rulesEditList)}");

    }
  }

  Future<void> initialLoadChange({required String onChangeVal}) async {
    if (onChangeVal.isNotEmpty) {
      // Parse the input value as an integer
      // int numberOfSets = int.tryParse(onChangeVal) ?? 0;

      // Find and store the original REP and Load training names and IDs
      // var repEntry = rulesEditList.firstWhere((element) => element.trainingId.toString() == "2");
      var loadEntry = rulesEditList.firstWhere((element) => element.trainingId.toString() == "5");

      // Split REP and Load values
      List<String> loadValues = loadEntry.value.split('/');

      // Get the base REP name (without numbers)
      String baseRepName = loadEntry.training.split(' ')[0]; // "REP"

      // Remove only existing REP and Load entries, leave ROM intact
      rulesEditList.removeWhere((element) => element.trainingId.toString() == "5");

      // Insert new REP and Load entries dynamically
        for (int i = 0; i < loadValues.length; i++) {
          // Add REP entries like {"training_id": "2", "training": "REP", "value": "12"}

          rulesEditList.add(newRep1("$baseRepName ${i+1}", loadEntry.trainingId, loadValues[i]));
        }

      await Future.delayed(const Duration(seconds: 1));

      // Refresh the list to update the UI
      rulesEditList.refresh();

      log("sam ${jsonEncode(rulesEditList)}");

    }
  }

  setInitEditData() {
    for(var i = 0; i < rulesEditList.length; i++) {
      var rules = rulesEditList[i];
      if (rules.trainingId.toString() == "1") {
        log("sam ${jsonEncode(rules)}");
        initialRepChange(onChangeVal: rules.value);
      }

      if (rules.trainingId.toString() == "1" && load.value) {
        initialLoadChange(onChangeVal: rules.value);
      }
    }
  }

  newRep1(name, trainingId,value) {
    return Rules(value: value, trainingId: trainingId, training: name);
  }

  newRep(name, trainingId) {
    return Rules(value: "", trainingId: trainingId, training: name);
  }

  newLoad(name, trainingId) {
    return Rules(value: "", trainingId: trainingId, training: name);
  }

  String? trainingIds;

  List<String> resultParts = [];

  Future<void> getTrainingIdsAndValues() async {
    resultParts.clear();

    trainingIds = rulesViewList
        .map((obj) => obj.trainingId.toString())
        .toSet()
        .join('--');

    await Future.delayed(Duration.zero);

    List<String> ids = (trainingIds ?? '').split('--');

    for (String i in ids) {
      var repValues = rulesEditList
          .where((item) => item.trainingId.toString() == i)
          .map((item) => item.valueCtrl!.text.toString())
          .join('/');
      resultParts.add(repValues);
      // log("sam ${repValues.map((item) => item.valueCtrl!.text.toString())}");
    }

    // log("sam ${resultParts}");
  }

  void exerciseRulesUpdate(
      {required String workoutId,
        required String sectionId,
        required String exerciseId,
        required String coachId,
      }) async {

    await getTrainingIdsAndValues();

    Map<String, dynamic> mapData = {
      "workout_id": workoutId,
      "load": load.value,
      "traning_ids": trainingIds ?? '',
      "values": resultParts.map((obj) => obj.toString()).join('--'),
      'section_id': sectionId,
      'coach_id': coachId,
      'exercise_id': exerciseId
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().exerciseRulesUpdate, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // chartData = response.data ?? [];
            Get.find<WorkoutDetailsController>()
                .exerciseRulesEdit(workoutId: workoutId, sectionId: sectionId);
            Get.find<StartWorkoutController>()
                .workoutSectionGet(workoutId: workoutId);
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
