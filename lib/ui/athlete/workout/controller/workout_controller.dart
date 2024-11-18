import 'dart:convert';
import 'dart:developer';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/athlete/workout/components/archive/archive.dart';
import 'package:fitness_metrics/ui/athlete/workout/components/training/training.dart';
import 'package:fitness_metrics/ui/athlete/workout/models/all_answer_model.dart';
import 'package:fitness_metrics/ui/athlete/workout/models/plan_model.dart';
import 'package:fitness_metrics/ui/athlete/workout/models/training_preferences_models.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WorkoutController extends GetxController {
  List<Widget> bodyList = [
    const Archive(),
    const Training(),
  ];

  RxInt selectedIndex = 0.obs;

  void selectBody(int index) {
    selectedIndex.value = index;
  }

  // Training Preference Process

  RxList<PreferenceData> preferenceList = <PreferenceData>[].obs;

  List<AllAnswerModel> allAnswersList = [];

  bool filledAll = false;

  RxBool answerGive = false.obs;

  void getPreferenceQuestionList() async {
    // log("$data");
    BaseApiService().post(
        apiEndPoint: ApiEndPoints().workoutPreferenceQuestionList,
        data: {}).then((value) {
      if (value?.statusCode == 200) {
        try {
          TrainingPreferencesModel response =
              TrainingPreferencesModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            preferenceList.value = response.data ?? [];
            if (preferenceList.isNotEmpty) {
              checkAllAnswers();
              // for(int i = 0; i < preferenceList.length; i++){
              //   preferenceEditControllers.add(TextEditingController());
              // }
            }
            // getCurrentData();
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

  void workoutPreferenceAnswersResult() async {
    Map<String, dynamic> mapData = {
      "answers": allAnswersList,
    };

    // log("$data");
    BaseApiService()
        .post(
            apiEndPoint: ApiEndPoints().workoutPreferenceAnswersResult,
            data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // preferenceList.value = response.data ?? [];

            selectBody(0);
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

  Future<List<AllAnswerModel>> getAllAnswers() async {
    allAnswersList.clear();
    for (int i = 0; i < preferenceList.length; i++) {
      if ((preferenceList[i].answerController?.text ?? '').isNotEmpty) {
        allAnswersList.add(AllAnswerModel(
            questionId: "${preferenceList[i].id ?? ''}",
            answer: preferenceList[i].answerController?.text ?? ''));
        filledAll = true;
      } else {
        showSnackBar(
            subtitle: "Please fill all answers to get suitable workout");
        filledAll = false;
        break;
      }
    }
    log("question Id => ${jsonEncode(allAnswersList)}");
    return allAnswersList;
  }

  void checkAllAnswers() async {
    allAnswersList.clear();
    for (int i = 0; i < preferenceList.length; i++) {
      if ((preferenceList[i].answer ?? '').isNotEmpty) {
        answerGive.value = true;
      } else {
        answerGive.value = false;
      }
    }

    log("question Id => $answerGive}");
  }

  // workout archive process

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  RxList<PlanData> planDataList = <PlanData>[].obs;

  int currentPage = 1;

  int lastPage = 0;

  // bool isLoading = false;

  void planGet({required int page}) async {
    // isLoading = true;

    if (page == 1) {
      currentPage = 1;
      planDataList.clear();
    }

    Map<String, dynamic> mapData = {
      "page": page,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().planAthleteGet, data: mapData, showLoader: page == 1)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          PlanModel response = PlanModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // planDataList.value = response.data ?? [];
            planDataList.addAll(response.data ?? []);
            lastPage = response.lastPage ?? 0;
            refreshController.loadComplete();
            refreshController.refreshCompleted();
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

      // isLoading = false;
    });
  }
}
