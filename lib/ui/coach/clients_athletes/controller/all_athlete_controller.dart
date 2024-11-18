import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/models/client_dashboard_model.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/models/coach_athlete_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllAthleteController extends GetxController {
  RxList<Athlete> athleteList = <Athlete>[].obs;

  final RefreshController refreshController =
  RefreshController(initialRefresh: false);

  int currentPage = 1;

  int lastPage = 0;

  void getAthleteForCoach({required int page}) async {

    if (page == 1) {
      currentPage = 1;
      athleteList.clear();
    }

    Map<String, dynamic> mapData = {
      "page": page,
    };
    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().coachWaiseAthlete, data: mapData, showLoader: page == 1)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          CoachAthleteModel response = CoachAthleteModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            athleteList.addAll(response.data ?? []);
            lastPage = response.lastPage ?? 0;
            refreshController.loadComplete();
            refreshController.refreshCompleted();
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
