import 'dart:developer';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/models/coach_preference_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class CoachPreferencesController extends GetxController {
  RxString sectionType = ''.obs;
  RxList<Sections> sectionList = <Sections>[].obs;

  RxList<Trainings> trainingList = <Trainings>[].obs;

  Rx<TrainingTimes> preferenceTime = TrainingTimes().obs;
  RxList<TrainingTimes> timeList = <TrainingTimes>[].obs;

  String sectionId = "";
  RxList<String> trainingIdList = <String>[].obs;

  void getSectionList({required String sectionId}) async {
    Map<String, dynamic> mapData = {
      "section_id": sectionId,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().sectionList, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          CoachPreferenceModel response =
              CoachPreferenceModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            sectionList.value = response.data?.sections ?? [];
            trainingList.value = response.data?.trainings ?? [];
            timeList.value = response.data?.trainingTimes ?? [];
            setCurrentRules(trainingList: trainingList);
            if(sectionId.isEmpty) {
              setCurrentData();
            }
            // getCurrentData();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  void setCurrentData() {
    if (sectionList.isNotEmpty) {
      sectionType.value = sectionList[0].name;
      sectionId = sectionList[0].id.toString();
    }

    if (timeList.isNotEmpty) {
      preferenceTime.value = timeList[0];
    }
  }

  setCurrentRules({required List<Trainings> trainingList}) {
    trainingIdList.clear();
    trainingList.map((obj) {
      if(obj.status ?? false){
        trainingIdList.add(obj.id.toString());
      }
    }).toList();
  }

  void getCurrentSectionData({required Sections selectedSection}) {

    sectionType.value = selectedSection.name ?? "";
    sectionId = selectedSection.id?.toString() ?? '';

    getSectionList(sectionId: selectedSection.id?.toString() ?? "");

  }

  setTrainingId({required int itemIndex}){

    if(trainingIdList.contains(trainingList[itemIndex].id.toString())) {
      // if(profileCtrl.trainingList[widget.itemIndex].status ?? false) {
      trainingIdList.remove(trainingList[itemIndex].id.toString());
      // }
    } else {
      trainingIdList.add(trainingList[itemIndex].id.toString());
    }

    trainingList[itemIndex].status = !trainingList[itemIndex].status;
  }

  void sectionCoachRulesCreate() async {
    Map<String, dynamic> mapData = {
      "section_id": sectionId,
      "traning_ids": trainingIdList.join(","),
      "time": preferenceTime.value.id.toString(),
    };

    // log("$mapData");
    BaseApiService()
        .post(
            apiEndPoint: ApiEndPoints().sectionCoachRulesCreate, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
          BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // sectionList.value = response.data?.sections ?? [];

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
