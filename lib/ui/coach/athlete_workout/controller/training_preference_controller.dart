import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/workout/models/training_preferences_models.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class TrainingPreferenceController extends GetxController {
  RxList<PreferenceData> preferenceList = <PreferenceData>[].obs;

  void coachWorkoutPreferenceQuestionList() async {
    var ctrl = Get.find<AthleteDataController>();

    Map<String, dynamic> mapData = {
      "athlete_id": ctrl.athleteData.value.userId ?? "",
    };

    // log("$data");
    BaseApiService()
        .post(
            apiEndPoint: ApiEndPoints().coachWorkoutPreferenceQuestionList,
            data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          TrainingPreferencesModel response =
              TrainingPreferencesModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            preferenceList.value = response.data ?? [];
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
}
