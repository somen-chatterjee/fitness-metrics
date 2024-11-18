
import 'dart:developer';
import 'dart:io';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/athlete_essentials/components/height_slider.dart';
import 'package:fitness_metrics/ui/athlete/athlete_essentials/components/weight_slider.dart';
import 'package:fitness_metrics/ui/athlete/athlete_essentials/models/athlete_body_details_model.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/athlete_dashboard.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class AthleteDetailsControllers extends GetxController {

  RxDouble weight = 55.0.obs;

  Rx<WeightType> weightType = (WeightType.kg).obs;

  RxDouble height = 55.0.obs;

  Rx<HeightType> heightType = (HeightType.cm).obs;

  Rx<File?> selectedFrontImage = File("").obs;
  Rx<File?> selectedSideImage = File("").obs;
  Rx<File?> selectedBackImage = File("").obs;

  void imageDispose() {
    // selectedSideImage.value.
  }

  void athleteDetails({required String athleteId}) async {

    dio.FormData formData = dio.FormData.fromMap({
      "_method": "POST",
      "athlete_id": athleteId,
      "weight": weight,
      "height": height,
      "heightUnit": heightType.value.name.toLowerCase(),
      "weightUnit": weightType.value.name.toLowerCase(),
    });

    if (selectedFrontImage.value?.path != null && selectedFrontImage.value!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        "front_image",
        await dio.MultipartFile.fromFile(
          selectedFrontImage.value!.path,
          filename: selectedFrontImage.value!.path.split('/').last,
        ),
      ));
    }

    if (selectedSideImage.value?.path != null && selectedSideImage.value!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        "side_image",
        await dio.MultipartFile.fromFile(
          selectedSideImage.value!.path,
          filename: selectedSideImage.value!.path.split('/').last,
        ),
      ));
    }

    if (selectedBackImage.value?.path != null && selectedBackImage.value!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        "back_image",
        await dio.MultipartFile.fromFile(
          selectedBackImage.value!.path,
          filename: selectedBackImage.value!.path.split('/').last,
        ),
      ));
    }

    log("${formData.fields}");
    log("${formData.files}");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().athleteDetails, data: formData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          AthleteBodyDetailsModel response = AthleteBodyDetailsModel.fromJson(value?.data);
          if (response.status ?? false) {
            Get.offAll(() => const AthleteDashboard());
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

}