
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/components/select_icons_dialog.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/models/plan_workout_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/models/workout_icons_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CreateWorkoutController extends GetxController{

  //get workout list
  RxList<WorkoutData> workoutList = <WorkoutData>[].obs;

  final RefreshController refreshController =
  RefreshController(initialRefresh: false);

  int currentPage = 1;

  int lastPage = 0;

  String? note;

  void planWorkoutGetCoach({required int page,required String planId}) async {
    var ctrl = Get.find<AthleteDataController>();

    if (page == 1) {
      currentPage = 1;
      workoutList.clear();
    }

    Map<String, dynamic> mapData = {
      "athlete_id": ctrl.athleteData.value.userId ?? "",
      "plan_id": planId,
      "page": page,
    };

    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().planWorkoutGetCoach, data: mapData, showLoader: page == 1)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          PlanWorkoutModel response = PlanWorkoutModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            note = response.data?.note ?? '';
            workoutList.addAll(response.data?.workouts ?? []);
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

  // workout icon get set process
  RxList<IconsData> workoutIconsList = <IconsData>[].obs;

  Future<bool> getWorkoutIcon() async {

    bool isSuccess = false;

    Map<String, dynamic> mapData = {
    };

    // log("$mapData");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().workoutIcon, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          WorkoutIconsModel response = WorkoutIconsModel.fromJson(value?.data);
          if (response.status ?? false) {
            isSuccess = true;
            workoutIconsList.clear();
            selectedIcon.value = '';
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            workoutIconsList.addAll(response.data ?? []);
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
    return isSuccess;
  }

  IconsData? iconData;

  Future<Object?> showIcons(
      {required BuildContext context}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: const Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 18.0),
            child: SelectIconsDialog(),
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }

  RxString selectedIcon = ''.obs;

  selectWorkout({required int index}) {
    workoutIconsList.map((obj){
      if (obj.id == workoutIconsList[index].id) {
        // log("tre1 ${selectedIndex} $index");
        obj.isSelected = true;

        iconData = obj;
        workoutName.text = obj.name ?? '';
        workoutIcon.text = obj.name ?? '';
        selectedIcon.value = obj.icon ?? '';

        update();
        // log("tre2 ${selectedIndex} $index");
        Get.back();
      }else{
        obj.isSelected = false;
      }
    }).toList();
    workoutIconsList.refresh();
  }

  // create workout
  var workoutName = TextEditingController();
  var workoutIcon = TextEditingController();
  var createWorkoutFormKey = GlobalKey<FormState>();

  Future<bool> workoutCreate({required String planId}) async {

    var athleteDataCtrl = Get.find<AthleteDataController>();

    bool isSuccess = false;

    Map<String, dynamic> mapData = {
      "athlete_id": athleteDataCtrl.athleteData.value.userId ?? "",
      "name": workoutName.text.trim(),
      "plan_id": planId,
      "icon_id": iconData?.id ??""
    };

    // log("$mapData");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().workoutCreate, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            isSuccess = true;
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            planWorkoutGetCoach(page: 1, planId: planId);
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

  //create notes
  var noteController = TextEditingController();
  var noteFormKey = GlobalKey<FormState>();

  Future<bool> planNoteAdd({required String planId}) async {

    bool isSuccess = false;

    Map<String, dynamic> mapData = {
      "plan_id": planId,
      "note": noteController.text.trim(),
    };

    // log("$mapData");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().planNoteAdd, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            isSuccess = true;
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            planWorkoutGetCoach(page: 1, planId: planId);
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

  WorkoutData? selectedWorkoutData;

}