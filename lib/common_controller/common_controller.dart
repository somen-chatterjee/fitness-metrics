import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/athlete/athlete_essentials/components/weight_slider.dart';
import 'package:fitness_metrics/ui/athlete/athlete_essentials/models/athlete_body_details_model.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/common_ui/youtube_video_player.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/get_storage.dart';
import 'package:fitness_metrics/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  int? roleId;

  saveLoginDetails({String? accessToken, String? roleId, String? userId}) {
    // set token
    BaseStorage.write(
      StorageKeys.apiToken,
      accessToken ?? "",
    );

    //set Role Id
    BaseStorage.write(
      StorageKeys.roleId,
      roleId ?? "",
    );

    //set user Id
    BaseStorage.write(
      StorageKeys.userId,
      userId ?? "",
    );
  }

  Future<Object?> showLogoutDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: AlertDialog(
            title: const BaseText(
              value: 'Do you want to logout from this application?',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            content: const BaseText(value: 'We hate to see you leave...'),
            actions: <Widget>[
              BaseButton(
                btnHeight: 40,
                onPressed: () {
                  Navigator.of(context).pop(false);
                  logout();
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

  void logout() async {
    dynamic roleId = await BaseStorage.read(StorageKeys.roleId) ?? "";

    Map<String, dynamic> data = {
      "role": roleId,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().logout, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            clearSessionData();
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

  RxDouble weight = 55.0.obs;

  Rx<WeightType> weightType = (WeightType.kg).obs;

  Rx<File?> selectedFrontImage = File("").obs;
  Rx<File?> selectedSideImage = File("").obs;
  Rx<File?> selectedBackImage = File("").obs;

  void imageDispose() {
    selectedFrontImage.value = File("");
    selectedSideImage.value = File("");
    selectedBackImage.value = File("");
  }

  Future<bool> athleteDetails(
      {required String athleteId, required bool isWeightScreen}) async {
    bool isSuccess = false;

    dio.FormData formData = dio.FormData.fromMap({
      "_method": "POST",
      "athlete_id": athleteId,
      // "weight": isWeightScreen ? weight : null,
      // "height": null,
      // "heightUnit": null,
      // "weightUnit": weightType.value.name.toLowerCase(),
    });
    if (isWeightScreen) {
      formData.fields.add(MapEntry("weight", weight.value.toString()));
      formData.fields.add(MapEntry("weightUnit", weightType.value.name.toLowerCase()));
    }

    if (!isWeightScreen &&
        selectedFrontImage.value?.path != null &&
        selectedFrontImage.value!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        "front_image",
        await dio.MultipartFile.fromFile(
          selectedFrontImage.value!.path,
          filename: selectedFrontImage.value!.path.split('/').last,
        ),
      ));
    }

    if (!isWeightScreen &&
        selectedSideImage.value?.path != null &&
        selectedSideImage.value!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        "side_image",
        await dio.MultipartFile.fromFile(
          selectedSideImage.value!.path,
          filename: selectedSideImage.value!.path.split('/').last,
        ),
      ));
    }

    if (!isWeightScreen &&
        selectedBackImage.value?.path != null &&
        selectedBackImage.value!.path.isNotEmpty) {
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
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().athleteDetails, data: formData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          AthleteBodyDetailsModel response =
              AthleteBodyDetailsModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.offAll(() => const AthleteDashboard());
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);

            isSuccess = true;
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

    return isSuccess;
  }

  Future<Object?> showYoutubePlayer(
      {required BuildContext context, required String videoUrl}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "wq",
      transitionBuilder: (dContext, a1, a2, _) {
        return Transform.scale(
          scale: a1.value,
          child: Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: YoutubeVideoPlayer(videoUrl: videoUrl),
          ),
        );
      },
      pageBuilder: (context, a1, a2) => const SizedBox(),
    );
  }

  var contactUsFormKey = GlobalKey<FormState>();

  var accountEmail = TextEditingController();
  var name = TextEditingController();
  var description = TextEditingController();

  void clearForm() {
    accountEmail.clear();
    name.clear();
    description.clear();
  }

  void contactUs() async {
    Map<String, dynamic> data = {
      "email": accountEmail.text.trim().toString(),
      "name": name.text.trim().toString(),
      "description": description.text.trim().toString()
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().contactUs, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
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
