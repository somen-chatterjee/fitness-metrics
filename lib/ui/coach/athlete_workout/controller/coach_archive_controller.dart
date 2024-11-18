
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/athlete/workout/models/plan_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/get_storage.dart';
import 'package:fitness_metrics/utils/storage_keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CoachArchiveController extends GetxController {
  // plan list get process
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  RxList<PlanData> planDataList = <PlanData>[].obs;

  int currentPage = 1;

  int lastPage = 0;

  void planGet({required int page}) async {
    var ctrl = Get.find<AthleteDataController>();
    dynamic userId = await BaseStorage.read(StorageKeys.userId) ?? "";

    if (page == 1) {
      currentPage = 1;
      planDataList.clear();
    }

    Map<String, dynamic> mapData = {
      "athlete_id": ctrl.athleteData.value.userId ?? "",
      "page": page,
      "coach_id": userId,
    };

    // log("$data");
    BaseApiService()
        .post(
            apiEndPoint: ApiEndPoints().planGet,
            data: mapData,
            showLoader: page == 1)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          PlanModel response = PlanModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // planDataList.value = response.data ?? [];
            planDataList.addAll(response.data ?? []);
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

      // isLoading = false;
    });
  }

  //plan update
  Future<bool> planStatusUpdate(
      {required String planId, required int status}) async {
    dynamic userId = await BaseStorage.read(StorageKeys.userId) ?? "";

    bool isSuccess = false;

    Map<String, dynamic> mapData = {
      "coach_id": userId,
      "plan_id": planId,
      "status": status.toString(),
    };

    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().planStatusUpdate, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // planDataList.value = response.data ?? [];
            isSuccess = true;
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

      // isLoading = false;
    });
    return isSuccess;
  }

  //create plan process
  var createPlanFormKey = GlobalKey<FormState>();
  var planNameController = TextEditingController();
  var startDateController = TextEditingController();
  var finishDateController = TextEditingController();

  void clearFields() {
    planNameController.clear();
    startDateController.clear();
    finishDateController.clear();
  }

  Future<bool> planCreate({required bool status}) async {
    var athleteDataCtrl = Get.find<AthleteDataController>();

    bool isSuccess = false;

    Map<String, dynamic> mapData = {
      "athlete_id": athleteDataCtrl.athleteData.value.userId ?? "",
      "name": planNameController.text.trim().toString(),
      "status": status ? 1 : 2,
      "start_date": dateYYMMDD(
        changeToDateTime(dateString: startDateController.text).toString(),
      ),
      "finish_date": dateYYMMDD(
        changeToDateTime(dateString: finishDateController.text).toString(),
      )
    };

    // log("$mapData");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().planCreate, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // planDataList.value = response.data ?? [];
            isSuccess = true;
            planGet(page: 1);
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

      // isLoading = false;
    });
    return isSuccess;
  }

  //to retrieve the data for future
  PlanData selectedPlan = PlanData();

}
