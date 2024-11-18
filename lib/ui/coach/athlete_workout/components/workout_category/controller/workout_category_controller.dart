import 'dart:convert';
import 'dart:developer';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/add_exercise/add_exercise.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/add_exercise/controller/add_exercise_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/controllers/create_workout_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/models/workout_section_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/controller/coach_archive_controller.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/models/coach_preference_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class WorkoutCategoryController extends GetxController {
  RxInt visibleFAQ = 0.obs;

  // section select process
  RxString sectionType = ''.obs;
  RxList<Sections> sectionList = <Sections>[].obs;

  // list of section data display on list
  RxList<PredefinedSectionData> predefinedSectionData = <PredefinedSectionData>[].obs;

  RxList<Sections> selectedWorkoutList = <Sections>[].obs;

  //to display all the list of selected on button click
  RxList<Sections> selectedWorkoutNameList = <Sections>[].obs;

  void addOrRemove({required int categoryIndex}) {
    if (selectedWorkoutList.contains(sectionList[categoryIndex])) {
      // remove item
      selectedWorkoutList.remove(sectionList[categoryIndex]);
      // selectedWorkoutNameList.remove(categoryList[categoryIndex]);
      // refresh();
    } else {
      // add item
      selectedWorkoutList.add(sectionList[categoryIndex]);
      // selectedWorkoutNameList.add(categoryList[categoryIndex]);
    }
  }

  void addAllCategory() {
    selectedWorkoutNameList.clear();
    for (var i in selectedWorkoutList) {
      selectedWorkoutNameList.add(i);
    }
  }

  Future<void> getSectionList() async {
    Map<String, dynamic> mapData = {
      // "section_id": sectionId,
    };

    // log("$data");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().sectionList, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          CoachPreferenceModel response =
              CoachPreferenceModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            sectionList.value = response.data?.sections ?? [];
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

  // display the predefined list of section process
  void getWorkoutSections({required String workoutId}) async {
    Map<String, dynamic> mapData = {
      "workout_id": workoutId,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().workoutSections, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          WorkoutSectionModel response =
              WorkoutSectionModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            predefinedSectionData.value = response.data ?? [];

            setAllSectionToList(data: predefinedSectionData);
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

  setAllSectionToList({required List<PredefinedSectionData> data}) {
    if (sectionList.isNotEmpty) {
      for (var section in sectionList) {
        bool contain = data.any((s) => (s.section?.sectionId ?? 0) == section.id);

        if (contain) {
          // Add the same object reference to selectedWorkoutList and selectedWorkoutNameList
          if (!selectedWorkoutList.contains(section)) {
            selectedWorkoutList.insert(0,section);
          }
          if (!selectedWorkoutNameList.contains(section)) {
            selectedWorkoutNameList.insert(0,section);
          }
        }
      }

      oldItems = List<Sections>.from(selectedWorkoutNameList);
    }
  }

  // This will control the button's visibility
  RxBool isButtonVisible = false.obs;

  List<Sections> oldItems = []; // Initial copy of the list

  // display the predefined list of section process
  void workoutSectionCreate({required String workoutId}) async {
    var ctrl = Get.find<AthleteDataController>();
    var coachArchiveCtrl = Get.find<CoachArchiveController>();
    addAllCategory();

    Map<String, dynamic> mapData = {
      "plan_id" : coachArchiveCtrl.selectedPlan.id?.toString() ?? '',
      "athlete_id": ctrl.athleteData.value.userId ?? "",
      "workout_id": workoutId,
      "section_ids":
          selectedWorkoutNameList.map((obj) => obj.id.toString()).join(',')
    };

    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().workoutSectionCreate, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // sectionList.value = response.data?.sections ?? [];
            getWorkoutSections(workoutId: workoutId);
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


  void gotoNextScreen({required int index}) async {
    var sectionData = selectedWorkoutNameList[index];

    log("data ${jsonEncode(sectionData)}");

    var addExerciseCtrl = Get.put(AddExerciseController());

    await addExerciseCtrl.getExerciseList().then((value) {
      // if (value) {
        Get.to(() => AddExercise(
              sectionData: sectionData,
            ))?.then((_) {
          Get.delete<AddExerciseController>();
          var createWorkoutCtrl = Get.find<CreateWorkoutController>();
          getWorkoutSections(
              workoutId: createWorkoutCtrl.selectedWorkoutData?.id.toString() ?? "");
        });
      // }
    });

    await addExerciseCtrl.sectionExerciseList(sectionId: sectionData.id?.toString() ?? '');
  }
}
