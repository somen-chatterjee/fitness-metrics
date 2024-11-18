import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/edit_exercise_library.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/models/exercise_edit_data.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/models/exercises_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExerciseController extends GetxController {
  // exercise list get process
  RxList<ExerciseData> exerciseList = <ExerciseData>[].obs;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int currentPage = 1;

  int lastPage = 0;

  void getExerciseList({required String searchKey, required int page}) async {
    if (page == 1) {
      currentPage = 1;
      exerciseList.clear();
    }

    Map<String, dynamic> mapData = {
      "sreach_key": searchKey,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().exerciseList, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          ExercisesModel response = ExercisesModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            exerciseList.value = response.data ?? [];
            // lastPage = response.lastPage ?? 0;
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

  //exercise create process
  var exerciseCreateFormKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var videoUrlController = TextEditingController();
  var noteController = TextEditingController();

  int isLoaded = 0;

  void clearController() {
    nameController.clear();
    videoUrlController.clear();
    noteController.clear();
  }

  void exerciseCreate() async {
    Map<String, dynamic> mapData = {
      "name": nameController.text.trim().toString(),
      "video_url": videoUrlController.text.trim().toString(),
      "note": noteController.text.trim().toString(),
      // "load": isLoaded,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().exerciseCreate, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // exerciseList.value = response.data ?? [];
            getExerciseList(page: 1, searchKey: "");
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

  Future<Object?> showLoadQuestion({required BuildContext context}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            title: const BaseText(
              value: 'Dose this exercise has some load?',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            // content: const BaseText(value: 'We are glad to see your progress...'),
            actions: <Widget>[
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);

                  isLoaded = 1;

                  exerciseCreate();

                  // finishAthleteWorkout(
                  //   workoutId: workoutId,
                  //   sectionId: sectionId,
                  // );
                  // clearSessionData();
                },
                title: 'Yes',
              ),
              buildSizeHeight(5),
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);
                  isLoaded = 0;
                  exerciseCreate();
                },
                title: 'No',
              ),
            ],
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }

  // exercise edt process
  Rx<EditData> editData = EditData().obs;
  var exerciseEditFormKey = GlobalKey<FormState>();
  var videoUrlEditController = TextEditingController();
  var notesEditController = TextEditingController();

  void getExerciseEditData({required String exerciseId}) async {
    Map<String, dynamic> mapData = {"exercise_id": exerciseId};

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().exerciseEdit, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          ExerciseEditData response = ExerciseEditData.fromJson(value?.data);
          if (response.status ?? false) {
            Get.to(() => const EditExerciseLibrary());
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            editData.value = response.data ?? EditData();
            videoUrlEditController.text = response.data?.videoUrl ?? "";
            notesEditController.text = response.data?.note ?? "";
            // exerciseList.value = response.data ?? [];
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

  void exerciseUpdate(
      {required String exerciseId, required String name}) async {
    Map<String, dynamic> mapData = {
      "exercise_id": exerciseId,
      "name": name,
      "video_url": videoUrlEditController.text.trim().toString(),
      "note": notesEditController.text.trim().toString()
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().exerciseUpdate, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // editData.value = response.data ?? EditData();
            // exerciseList.value = response.data ?? [];
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

  // exercise delete process
  void exerciseDelete({required String exerciseId, required int index}) async {
    Map<String, dynamic> mapData = {
      "exercise_id": exerciseId,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().exerciseDelete, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // getExerciseList(page: 1, searchKey: "");
            exerciseList.removeAt(index);
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

  Future<Object?> showExerciseDelete(
      {required BuildContext context,
      required String exerciseId,
      required int index}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            title: const BaseText(
              value:
                  'Are you sure you want to delete this exercise? This action wil not revert back...',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            // content: const BaseText(value: 'We are glad to see your progress...'),
            actions: <Widget>[
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);
                  exerciseDelete(exerciseId: exerciseId, index: index);
                },
                title: 'Yes',
              ),
              buildSizeHeight(5),
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                title: 'No',
              ),
            ],
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }
}
