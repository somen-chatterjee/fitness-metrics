
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class WellnessQuestionController extends GetxController {

  List<String> title = [
    'Sleep',
    'Stress',
    'Fatigue',
    'Muscle Soreness'
  ];

  RxList<int> answers = [
    3,
    3,
    3,
    3
  ].obs;
  
  void setAnswer(int questionIndex, int index){
    answers.removeAt(questionIndex);
    answers.insert(questionIndex, index);
    // log("list $answers");
  }

  void wellnessQuestionnaireCreate() async {
    Map<String,dynamic> dataMap = {
      "date": dateYYMMDD(DateTime.now().toString()),
      "sleep": (answers[0]+1).toString(),
      "stress": (answers[1]+1).toString(),
      "fatigue": (answers[2]+1).toString(),
      "muscle_soreness": (answers[3]+1).toString()
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().wellnessQuestionnaireCreate, data: dataMap)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
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

