// ignore: unused_import
import 'dart:developer';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/athlete_profile/athlete_profile.dart';
import 'package:fitness_metrics/ui/athlete/settings/settings.dart';
import 'package:fitness_metrics/ui/athlete/settings_data/models/athlete_profile_data_model.dart';
import 'package:fitness_metrics/ui/athlete/workout/workout.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AthleteDashController extends GetxController {

  List<Widget> bodyList = [
    const AthleteProfile(),
    const Workout(),
    const Settings(),
  ];

  RxInt selectedIndex = 0.obs;

  void selectBody(int index) {
   selectedIndex.value = index;
  }

  RxInt year = DateTime.now().year.obs;
  RxInt month = DateTime.now().month.obs;

  List<String> weekList= [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  Rx<User> athleteData = User().obs;
  Rx<CoachDetails> coachData = CoachDetails().obs;

  RxList<Details> bodyCompareList = <Details>[].obs;

  RxInt pageIndex = 0.obs;

  RxString currentDate = ''.obs;
  RxString currentWeight = ''.obs;
  RxString currentHeight = ''.obs;

  void profileDataAthlete() async {
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().editProfileAthlete, data: {})
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          AthleteProfileDataModel response = AthleteProfileDataModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            athleteData.value = response.data?.user ?? User();
            coachData.value = response.data?.coachDetails ?? CoachDetails();
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
    if(bodyCompareList.isNotEmpty){
      currentDate.value = bodyCompareList[pageIndex.value].date ?? '';
      currentWeight.value ='${bodyCompareList[pageIndex.value].weight ?? ""} ${(bodyCompareList[pageIndex.value].weightUnit ?? "").toUpperCase()}';
      currentHeight.value ='${bodyCompareList[pageIndex.value].height ?? ""} ${(bodyCompareList[pageIndex.value].heightUnit ?? "").toUpperCase()}';
    }
  }

}
