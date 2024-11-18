import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/models/athlete_profile_view_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/models/status_update_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/athlete_evaluation.dart';
import 'package:fitness_metrics/ui/coach/athlete_view_data/athlete_view_data.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/athlete_workout.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class AthleteDataController extends GetxController {
  List<Widget> bodyList = [
    const AthleteViewData(),
    const AthleteEvaluation(),
    const AthleteWorkout(),
  ];

  RxInt selectedIndex = 0.obs;

  void selectBody(int index) {
    selectedIndex.value = index;
  }

  Rx<User> athleteData = User().obs;

  RxList<Details> bodyCompareList = <Details>[].obs;

  RxInt pageIndex = 0.obs;

  RxString currentDate = ''.obs;
  RxString currentWeight = ''.obs;
  RxString currentHeight = ''.obs;
  RxInt currentGoalValue = 20.obs;

  RxInt status = 2.obs;

  void profileAthleteView({required String athleteId}) async {
    Map<String, dynamic> mapData = {
      "athlete_id": athleteId,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().profileAthleteView, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          AthleteProfileViewModel response =
              AthleteProfileViewModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            athleteData.value = response.data?.user ?? User();

            status.value = athleteData.value.status ?? 2;

            currentGoalValue.value =
                int.parse(response.data?.user?.monthlyGoals ?? "0");
            bodyCompareList.value = response.data?.details ?? [];
            getCurrentData();
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

  void getCurrentData() {
    if (bodyCompareList.isNotEmpty) {
      currentDate.value = bodyCompareList[pageIndex.value].date ?? '';
      currentWeight.value =
          '${bodyCompareList[pageIndex.value].weight ?? ""} ${(bodyCompareList[pageIndex.value].weightUnit ?? "").toUpperCase()}';
      currentHeight.value =
          '${bodyCompareList[pageIndex.value].height ?? ""} ${(bodyCompareList[pageIndex.value].heightUnit ?? "").toUpperCase()}';
    }
  }

  Future<Object?> showConfirmationDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            title: const BaseText(
              value: 'Are you sure you want to inactive this athlete? This Action will never revert back...',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            // content: Obx(() {
            //   return NumberPicker(
            //     value: currentGoalValue.value,
            //     minValue: 0,
            //     maxValue: 200,
            //     onChanged: (value) => currentGoalValue.value = value,
            //   );
            // }),
            actions: <Widget>[
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  statusUpdateAthlete();
                },
                title: 'Yes',
              ),
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Get.back();
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

  void statusUpdateAthlete() async {
    Map<String, dynamic> mapData = {
      'athlete_id': athleteData.value.userId ?? '',
      'status': status.value != 1,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().statusUpdateAthlete, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          StatusUpdateModel response =
          StatusUpdateModel.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            status.value = response.data?.status ?? 2;
            // bodyCompareList.value = response.data?.details ?? [];
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

  Future<Object?> showGoalEditDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            title: const BaseText(
              value: 'Set athlete\'s monthly goals...',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            content: Obx(() {
              return NumberPicker(
                value: currentGoalValue.value,
                minValue: 0,
                maxValue: 200,
                onChanged: (value) => currentGoalValue.value = value,
              );
            }),
            actions: <Widget>[
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  updateGoalAthlete();
                },
                title: 'Submit',
              ),
            ],
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }

  void updateGoalAthlete() async {
    Map<String, dynamic> mapData = {
      "athlete_id": athleteData.value.userId ?? '',
      "monthly_goal": currentGoalValue.value.toString(),
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().updateGoalAthlete, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            profileAthleteView(athleteId: athleteData.value.userId ?? '');
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
