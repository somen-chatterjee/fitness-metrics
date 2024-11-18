
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/models/client_dashboard_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class ClientAthleteController extends GetxController {

  RxList<Group> groupList = <Group>[].obs;
  RxList<Athlete> athleteList = <Athlete>[].obs;

  void getGroupDashboardList() async {

    Map<String, dynamic> mapData = {};
    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().groupDashboardList, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          ClientDashboardModel response =
          ClientDashboardModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            groupList.value = response.data?.group ?? [];
            athleteList.value = response.data?.athlete ?? [];
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