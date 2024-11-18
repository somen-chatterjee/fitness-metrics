
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/models/client_dashboard_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

import '../models/group_view_model.dart';

class GroupViewController extends GetxController {

  RxList<Athlete> athleteList = <Athlete>[].obs;

  Future<bool> getGroupView({required String groupId}) async {
    bool isSuccess = false;

    Map<String, dynamic> mapData = {
      "group_id": groupId
    };

    // log("$mapData");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().groupView, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          GroupViewModel response =
          GroupViewModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            athleteList.value = response.data ?? [];
            isSuccess =  true;
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

    return isSuccess;

  }
}