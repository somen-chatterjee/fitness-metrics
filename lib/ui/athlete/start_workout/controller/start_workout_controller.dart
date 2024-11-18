import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/start_workout/models/workout_section_model.dart';
import 'package:fitness_metrics/ui/athlete/workout_details/workout_details.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class StartWorkoutController extends GetxController {
  RxInt visibleFAQ = (-1).obs;

  // dynamic data
  RxList<WorkoutData> workoutDataList = <WorkoutData>[].obs;

  void workoutSectionGet({required String workoutId}) async {
    Map<String, dynamic> mapData = {
      "workout_id": workoutId,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().workoutSectionGet, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          WorkoutSectionModel response =
              WorkoutSectionModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            workoutDataList.value = response.data ?? [];
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

  void getExerciseData({required int index, required String workoutId}) {
    if ((workoutDataList[index].exercise ?? []).isNotEmpty
        && workoutDataList[index].section?.status == 0
        ) {
      Get.to(() {
        return WorkoutDetails(
          workoutTitle: workoutDataList[index].section?.name?.toString() ?? "",
          workoutId: workoutId,
          sectionId: workoutDataList[index].section?.sectionId?.toString() ?? "",
          index: index,
        );
      });
    }
  }

  void extendData({required int index}) {
    if (visibleFAQ.value == index) {
      visibleFAQ.value = -1; // Collapse
    } else {
      visibleFAQ.value = index; // Expand
    }
  }
}
