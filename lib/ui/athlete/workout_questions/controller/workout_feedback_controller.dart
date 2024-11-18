import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/athlete/workout_questions/models/workout_feedback_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class WorkoutFeedbackController extends GetxController {
  RxList<Answers> answersList = <Answers>[].obs;
  RxString question = ''.obs;
  int? questionId;

  void questionnairesList() async {
    Map<String, dynamic> mapData = {};

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().questionnairesList, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          WorkoutFeedbackModel response =
              WorkoutFeedbackModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            answersList.value = response.data?.answers ?? [];
            question.value = response.data?.question ?? '';
            questionId = response.data?.id ?? 0;
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

  selectAnswer({required int index}) {
    answersList.map((obj) {
      if (obj.id == answersList[index].id) {
        // log("tre ${planWorkoutDataList[index].isSelected}");
        obj.isSelected = true;
        selectedIndex = index;
        update();
      } else {
        obj.isSelected = false;
      }
    }).toList();
    answersList.refresh();
  }

  void rpeQuestionsSubmit() async {
    Map<String, dynamic> mapData = {
      "question_id": questionId.toString(),
      "answer_id": answersList[selectedIndex ?? 0].id.toString(),
      "date": dateYYMMDD(DateTime.now().toString())
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().rpeQuestionsSubmit, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // answersList.value = response.data?.answers ?? [];
            // question.value = response.data?.question ?? '';
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
