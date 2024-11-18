import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/client_athletes.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/models/coach_profile_model.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/profile_coach.dart';
import 'package:fitness_metrics/ui/coach/subscription/subscription.dart';
import 'package:fitness_metrics/ui/coach/tasks/tasks.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CoachDashController extends GetxController {

  List<Widget> bodyList = [
    const ClientAthletes(),
    const Tasks(),
    const ProfileCoach(),
  ];

  RxInt selectedIndex = 1.obs;

  void selectBody(int index) {
   selectedIndex.value = index;
  }


  List<String> weekList = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  Rx<ProfileData> profileData = ProfileData().obs;

  void profileDataCoach() async {
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().editProfileCoach, data: {})
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          CoachProfileModel response = CoachProfileModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            profileData.value = response.data ?? ProfileData();
            // bodyCompareList.value = response.data?.details ?? [];
            // getCurrentData();

            if(!(profileData.value.isSubscribed ?? true)) {
              Get.off(() => const Subscription());
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
  }

}
