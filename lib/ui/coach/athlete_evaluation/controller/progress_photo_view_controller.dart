import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/models/progress_images_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class ProgressPhotoViewController extends GetxController{

  // progress photo processing starts here -->

  RxList<ProgressImageData> imageList = <ProgressImageData>[].obs;

  RxInt pageIndex = 0.obs;

  RxString currentDate = ''.obs;

  void progressImageList() async {
    var ctrl = Get.find<AthleteDataController>();

    Map<String, dynamic> mapData = {
      "athlete_id": ctrl.athleteData.value.userId ?? "",
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().evaluationCoachViewList, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          ProgressImagesModel response = ProgressImagesModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            imageList.value = response.data ?? [];
            getCurrentData();
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

  void getCurrentData() {
    if(imageList.isNotEmpty){
      currentDate.value = imageList[pageIndex.value].date ?? '';
    }
  }

  // compare photo processing starts here -->

  String setImage({required int index, required String title}) {
    if (title == "Side Photo") {
      return imageList[index].sideImage ?? '';
    }

    if (title == "Front Photo") {
      return imageList[index].sideImage ?? '';
    }

    if (title == "Back Photo") {
      return imageList[index].sideImage ?? '';
    }

    return '';
  }

  RxString firstDate = ''.obs;
  RxInt firstImageIndex = 0.obs;
  void getFirstData({required int itemIndex}) {
    firstImageIndex.value = itemIndex;
    if(imageList.isNotEmpty){
      firstDate.value = imageList[firstImageIndex.value].date ?? '';
    }
  }

  RxString secondDate = ''.obs;
  RxInt secondImageIndex = 0.obs;
  void getSecondData({required int itemIndex}) {
    secondImageIndex.value = itemIndex;
    if(imageList.isNotEmpty){
      secondDate.value = imageList[secondImageIndex.value].date ?? '';
    }
  }

}