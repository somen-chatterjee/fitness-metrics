import 'dart:io';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/coach/dashboard/controller/coach_dash_controller.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/coach_preferences.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/exercise_library.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/profile.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';

class ProfileController extends GetxController{

  List<Widget> bodyList = [
    const Profile(),
    const CoachPreferences(),
    const ExerciseLibrary(),
  ];

  RxInt selectedIndex = 0.obs;

  void selectBody(int index) {
    selectedIndex.value = index;
  }

  String selectedText() {
    if(selectedIndex.value == 0){
      return "Profile";
    }
    if(selectedIndex.value == 1){
      return "Coach preference";
    }
    if(selectedIndex.value == 2){
      return "Exercise Library";
    }

    return "";
  }

  String selectedTitleText() {
    if(selectedIndex.value == 0){
      return "Settings";
    }
    if(selectedIndex.value == 1){
      return "Coach preference";
    }
    if(selectedIndex.value == 2){
      return "Plan List";
    }

    return "";
  }

  List<String> exerciseList = [
    'Run',
    'Push-ups',
    'Bench Press',
    'Leg press',
    'Dumbbell Clean',
    'Squats',
  ];

  List<String> settingsList = [
    'Sets',
    'REP',
    'ROM',
    'RIR',
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

  var coachDashCtrl = Get.find<CoachDashController>();

  // RxString genderValue = 'Male'.obs;
  //
  // List<Map<String, String>> genderList = [
  //   {"type": 'Male', 'icon': BaseAssets.male},
  //   {"type": 'Female', 'icon': BaseAssets.female},
  // ];

  Rx<File?> selectedProfileImage = File("").obs;
  Rx<File?> selectedResume = File("").obs;

  var profileUpdateKey = GlobalKey<FormState>();

  String dobDate = "";

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var ageController = TextEditingController();
  var igProfileController = TextEditingController();
  var whatsappController = TextEditingController();
  var websiteController = TextEditingController();
  var resumeController = TextEditingController();


  bool isAdult(String dob) {
    final dateOfBirth = DateFormat("yyyy-MM-dd").parse(dob);
    final now = DateTime.now();
    final thirteenYearsAgo = DateTime(
      now.year - 13,
      now.month,
      now.day + 1, // add day to return true on birthday
    );
    return dateOfBirth.isBefore(thirteenYearsAgo);
  }

  void setData() {
    nameController.text = coachDashCtrl.profileData.value.name ?? "";
    phoneController.text = coachDashCtrl.profileData.value.mobile ?? "";
    emailController.text = coachDashCtrl.profileData.value.email ?? "";
    ageController.text = dateDDMMYY(coachDashCtrl.profileData.value.dateOfBirth ?? "");
    whatsappController.text = coachDashCtrl.profileData.value.whatsappNumber ?? "";
    igProfileController.text = coachDashCtrl.profileData.value.profileUrl ?? "";
    websiteController.text = coachDashCtrl.profileData.value.websiteUrl ?? "";
    dobDate = coachDashCtrl.profileData.value.dateOfBirth ?? "";
    // resumeController.text = "${coachDashCtrl.profileData.value. ?? ""}";

    //set gender
    // if ((athleteDashCtrl.profileData.value.gender ?? "").isNotEmpty) {
    //   genderValue.value = athleteDashCtrl.profileData.value.gender ?? "";
    // }
  }

  void setUpdatedData() {
    nameController.text = coachDashCtrl.profileData.value.name ?? "";
    phoneController.text = coachDashCtrl.profileData.value.mobile ?? "";
    emailController.text = coachDashCtrl.profileData.value.email ?? "";
    ageController.text = "${coachDashCtrl.profileData.value.age ?? ""}";

    //set gender
    // if ((athleteDashCtrl.profileData.value.gender ?? "").isNotEmpty) {
    //   genderValue.value = athleteDashCtrl.profileData.value.gender ?? "";
    // }
  }

  void updateProfileCoach() async {
    dio.FormData formData = dio.FormData.fromMap({
      "name": nameController.text.trim(),
      // "age": ageController.text.trim(),
      "date_of_birth": dobDate,
      // "gender": genderValue,
      "email": emailController.text.trim(),
      "mobile": phoneController.text.trim(),
      "whatsapp_number": whatsappController.text.trim(),
      "profile_url": igProfileController.text.trim(),
      "website_url": websiteController.text.trim(),
    });

    if (selectedProfileImage.value?.path != null && selectedProfileImage.value!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        "image",
        await dio.MultipartFile.fromFile(
          selectedProfileImage.value!.path,
          filename: selectedProfileImage.value!.path.split('/').last,
        ),
      ));
    }

    if (selectedResume.value?.path != null && selectedResume.value!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        "resume",
        await dio.MultipartFile.fromFile(
          selectedResume.value!.path,
          filename: selectedResume.value!.path.split('/').last,
        ),
      ));
    }

    // log("${formData.fields}");
    // log("${formData.files}");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().updateProfileCoach, data: formData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response = BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            coachDashCtrl.profileDataCoach();
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
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