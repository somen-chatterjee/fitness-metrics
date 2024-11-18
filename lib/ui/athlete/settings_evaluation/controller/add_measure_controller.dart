

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/controller/athlete_measurement_controller.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/get_storage.dart';
import 'package:fitness_metrics/utils/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddMeasureController extends GetxController {

  RxString selectedDate = (DateTime.now().toString()).obs;

  final addMeasureFormKey = GlobalKey<FormState>();

  var chestCtrl = TextEditingController();

  var leftArmCtrl = TextEditingController();
  var rightArmCtrl = TextEditingController();

  var leftThighCtrl = TextEditingController();
  var rightThighCtrl = TextEditingController();

  var leftHipsCtrl = TextEditingController();
  var rightHipsCtrl = TextEditingController();

  var absCtrl = TextEditingController();
  var calvesCtrl = TextEditingController();

  void measurementsCreate() async {
    var userId = await BaseStorage.read(StorageKeys.userId) ?? "";

    Map<String, dynamic> mapData = {
      "athlete_id": userId.toString(),
      "date": dateYYMMDD(selectedDate.value.toString()),
      "chest": chestCtrl.text.trim().toString(),
      "armRight": rightArmCtrl.text.trim().toString(),
      "armLight": leftArmCtrl.text.trim().toString(),
      "thighRight": rightThighCtrl.text.trim().toString(),
      "thighLight": leftThighCtrl.text.trim().toString(),
      "hips_1": leftHipsCtrl.text.trim().toString(),
      "hips_2": rightHipsCtrl.text.trim().toString(),
      "abs": absCtrl.text.trim().toString(),
      "calves": calvesCtrl.text.trim().toString(),
    };

    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().measurementsCreate, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
          BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // chartData = response.data ?? [];
            Get.find<AthleteMeasurementController>().measurementChart();

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