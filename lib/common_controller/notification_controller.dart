
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/notifications/models/notification_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationController extends GetxController{

  RxList<NotificationData> notificationDataList = <NotificationData>[].obs;

  final RefreshController refreshController =
  RefreshController(initialRefresh: false);

  int currentPage = 1;

  int lastPage = 0;

  void getNotificationsList({required int page}) async {

    if (page == 1) {
      currentPage = 1;
      notificationDataList.clear();
    }

    Map<String, dynamic> mapData = {
      "page": page,
    };
    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().notificationsList, data: mapData, showLoader: page == 1)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          NotificationModel response = NotificationModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            notificationDataList.addAll(response.data ?? []);
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

  void notificationsDelete() async {

    Map<String, dynamic> mapData = {
      // "page": page,
    };

    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().notificationsDelete, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            getNotificationsList(page: 1);
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

  Future<Object?> showDeleteNotification(
      {required BuildContext context}) {
    return showGeneralDialog(
      context: context,
      // barrierDismissible: fa,
      // barrierLabel: "wq",
        transitionBuilder: (dContext, a1, a2, _) {
          return Transform.scale(
            scale: a1.value,
            child: AlertDialog(
              title: const BaseText(
                value:
                'Are you sure you want to delete all notifications?',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              content: const BaseText(value: 'Please make sure you read all notifications...'),
              actions: <Widget>[
                BaseButton(
                  btnHeight: 40,
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    notificationsDelete();
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