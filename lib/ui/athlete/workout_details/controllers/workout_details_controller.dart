import 'dart:developer';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/start_workout/controller/start_workout_controller.dart';
import 'package:fitness_metrics/ui/athlete/workout_details/models/finish_workout_model.dart';
import 'package:fitness_metrics/ui/athlete/workout_details/models/workout_details_model.dart';
import 'package:fitness_metrics/ui/athlete/workout_finish/workout_finish.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkoutDetailsController extends GetxController {
  RxList<ExercisesData> exercisesDataList = <ExercisesData>[].obs;

  void exerciseRulesEdit(
      {required String workoutId, required String sectionId}) async {
    Map<String, dynamic> mapData = {
      // "exercise_id": exerciseId,
      "workout_id": workoutId,
      "section_id": sectionId
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().exerciseRulesEdit, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          WorkoutDetailsModel response =
              WorkoutDetailsModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            exercisesDataList.value = response.data ?? [];
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  Future<Object?> showNotes(
      {required BuildContext context, required String notes}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              // height: 400,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BaseText(
                          value: 'Block Notes',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          color: BaseColors.black1,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: SvgPicture.asset(BaseAssets.cancel),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: BaseColors.grey),
                  BaseText(
                    value: notes,
                    color: BaseColors.black1,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }

  Future<Object?> showMarkFinished(
      {required BuildContext context,
      required String workoutId,
      required String sectionId}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            title: const BaseText(
              value: 'Are you sure you want to mark this exercise as finished?',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            content:
                const BaseText(value: 'We are glad to see your progress...'),
            actions: <Widget>[
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);

                  finishAthleteWorkout(
                    workoutId: workoutId,
                    sectionId: sectionId,
                  );
                  // clearSessionData();
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

  void finishAthleteWorkout(
      {required String workoutId, required String sectionId}) async {
    Map<String, dynamic> mapData = {
      // "exercise_id": exerciseId,
      "workout_id": workoutId,
      "section_id": sectionId
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().finishAthleteWorkout, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          FinishWorkoutModel response =
              FinishWorkoutModel.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            Get.find<StartWorkoutController>()
                .workoutSectionGet(workoutId: workoutId);
            Get.to(() => WorkoutFinish(finishData: response.data ?? FinishData(),));

            // athleteData.value = response.data?.user ?? User();
            // exercisesDataList.value = response.data ?? [];
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
