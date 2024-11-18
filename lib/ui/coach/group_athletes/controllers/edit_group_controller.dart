import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/controller/client_athlete_controller.dart';
import 'package:fitness_metrics/ui/coach/group_athletes/models/group_edit_view_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditGroupController extends GetxController {
  final createGroupFromKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  GroupData groupData = GroupData();

  RxList<int> idList = <int>[].obs;

  RxList<Athlete> combinedList = <Athlete>[].obs;

  Future<bool> getGroupEdit({required String groupId}) async {
    bool isSuccess = false;

    Map<String, dynamic> mapData = {
      "group_id": groupId,
    };

    // log("$mapData");
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().groupEdit, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          GroupEditViewModel response =
              GroupEditViewModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // athleteList.value = response.data ?? [];
            groupData = response.data ?? GroupData();
            nameController.text = response.data?.groupName ?? '';
            combinedList.value = mergeGroupAndAthletes();
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
    });

    return isSuccess;
  }

  // Method to merge members (group) and anotherAthlete, ensuring selection status
  List<Athlete> mergeGroupAndAthletes() {
    List<Athlete> combinedList = [];

    // Ensure members (group) are selected
    if (groupData.group != null) {
      combinedList.addAll(groupData.group!.map((athlete) {
        athlete.isSelected = true; // Mark members as selected
        if (athlete.userId != null) {
          idList.add(athlete.userId!);
        }
        return athlete;
      }));
    }

    // Ensure anotherAthlete are not selected
    if (groupData.anotherAthlete != null) {
      combinedList.addAll(groupData.anotherAthlete!.map((athlete) {
        athlete.isSelected = false; // Mark anotherAthlete as not selected
        return athlete;
      }));
    }

    return combinedList;
  }

  void athleteUpdateGroup({required String groupId}) async {
    Map<String, dynamic> mapData = {
      "name": nameController.text.trim().toString(),
      "group_id": groupId,
      "athlete_ids": idList.join(","),
    };

    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().athleteUpdateGroup, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            Get.back();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // groupList.value = response.data?.group ?? [];

            Get.find<ClientAthleteController>().getGroupDashboardList();
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
