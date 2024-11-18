import 'dart:developer';
import 'dart:io';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/backend/base_success_response.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/controller/athlete_dash_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';

class DataEditController extends GetxController {
  var athleteDashCtrl = Get.find<AthleteDashController>();

  var profileUpdateFormKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var ageController = TextEditingController();
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var bmiController = TextEditingController();

  RxInt feet = 0.obs;
  RxInt kg = 0.obs;

  RxString genderValue = 'Male'.obs;

  List<Map<String, String>> genderList = [
    {"type": 'Male', 'icon': BaseAssets.male},
    {"type": 'Female', 'icon': BaseAssets.female},
  ];

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

  Rx<File?> selectedProfileImage = File("").obs;

  String dobDate = "";

  void setData() {
    nameController.text = athleteDashCtrl.athleteData.value.name ?? "";
    phoneController.text = athleteDashCtrl.athleteData.value.mobile ?? "";
    emailController.text = athleteDashCtrl.athleteData.value.email ?? "";
    ageController.text =
        dateDDMMYY(athleteDashCtrl.athleteData.value.dateOfBirth ?? "");
    weightController.text = athleteDashCtrl.athleteData.value.weight ?? "";
    heightController.text = athleteDashCtrl.athleteData.value.height ?? "";
    bmiController.text = athleteDashCtrl.athleteData.value.bmi ?? "";
    dobDate = athleteDashCtrl.athleteData.value.dateOfBirth ?? "";

    //set gender
    if ((athleteDashCtrl.athleteData.value.gender ?? "").isNotEmpty) {
      genderValue.value = athleteDashCtrl.athleteData.value.gender ?? "";
    }

    // set weight unit
    if ((athleteDashCtrl.athleteData.value.weightUnit ?? "").isNotEmpty) {
      kg.value =
          athleteDashCtrl.athleteData.value.weightUnit!.toLowerCase() == 'kg'
              ? 1
              : 0;
    }

    // set height unit
    if ((athleteDashCtrl.athleteData.value.heightUnit ?? "").isNotEmpty) {
      feet.value =
          athleteDashCtrl.athleteData.value.heightUnit!.toLowerCase() == 'cm'
              ? 1
              : 0;
    }

    calculateBMI();
  }

  void updateProfileAthlete() async {
    dio.FormData formData = dio.FormData.fromMap({
      "name": nameController.text.trim(),
      "gender": genderValue,
      "email": emailController.text.trim(),
      "mobile": phoneController.text.trim(),
      "date_of_birth": dobDate,
      "height": heightController.text.trim(),
      "weight": weightController.text.trim(),
      "weightUnit": kg.value == 1 ? "kg" : "lb",
      "heightUnit": feet.value == 0 ? "feet" : "cm",
      "bmi": bmiController.text.trim(),
    });

    if (selectedProfileImage.value?.path != null &&
        selectedProfileImage.value!.path.isNotEmpty) {
      formData.files.add(MapEntry(
        "image",
        await dio.MultipartFile.fromFile(
          selectedProfileImage.value!.path,
          filename: selectedProfileImage.value!.path.split('/').last,
        ),
      ));
    }

    // log("${formData.fields}");
    // log("${formData.files}");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().updateProfileAthlete, data: formData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          BaseSuccessResponse response =
              BaseSuccessResponse.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            athleteDashCtrl.profileDataAthlete();
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

  // double calculateBMI() {
  //
  //   var weight = (weightController.text.trim().isEmpty ? 0.0: double.parse(weightController.text.trim()));
  //   var height = (heightController.text.trim().isEmpty ? 0.0: double.parse(heightController.text.trim()));
  //
  //   // Convert weight to kilograms if it's in lbs
  //   if (kg.value != 0) {
  //     weight = weight * 0.453592; // 1 lb = 0.453592 kg
  //   }
  //
  //   // Convert height to meters if it's in cm
  //   if (feet.value != 0) {
  //     height = height / 100; // 1 cm = 0.01 meters
  //   } else {
  //     height = height * 0.3048; // 1 foot = 0.3048 meters
  //   }
  //
  //   if (height <= 0 || weight <= 0) {
  //     throw ArgumentError('Height and weight must be greater than zero.');
  //   }
  //
  //   var bmi = weight / (height * height);
  //
  //   bmiController.text = bmi.toString();
  //
  //   return bmi; // BMI calculation
  // }

  void changeWeightHeight({required int index}) {
    if (kg.value != index) {
      double currentWeight =
          double.tryParse(weightController.text.trim()) ?? 0.0;
      if (index == 0) {
        // KG to LBS
        weightController.text = (currentWeight * 2.20462).toStringAsFixed(2);
      } else {
        // LBS to KG
        weightController.text = (currentWeight * 0.453592).toStringAsFixed(2);
      }
      kg.value = index;
    }

    if (feet.value != index) {
      double currentHeight =
          double.tryParse(heightController.text.trim()) ?? 0.0;
      if (index == 0) {
        // CM to Feet
        heightController.text = (currentHeight * 0.0328084).toStringAsFixed(2);
      } else {
        // Feet to CM
        heightController.text = (currentHeight * 30.48).toStringAsFixed(2);
      }
      feet.value = index;
    }

    calculateBMI();
  }

  void calculateBMI() {
    double weight = weightController.text.trim().isEmpty
        ? 0.0
        : double.parse(weightController.text.trim());

    double height = heightController.text.trim().isEmpty
        ? 0.0
        : double.parse(heightController.text.trim());

    // Check if Kilograms or Pounds are selected
    bool isKgSelected = kg.value != 0; // Assume 0 means kg, 1 means lbs
    bool isCmSelected = feet.value != 0; // Assume 0 means cm, 1 means feet.inches

    log("Converted : $isKgSelected $isCmSelected");

    // Calculate BMI only if weight and height are valid
    if (weight > 0 && height > 0) {
      double heightInMeters;
      double weightInKg;

      // Handle height conversion
      if (isCmSelected) {
        // Height is in centimeters, convert to meters
        heightInMeters = height / 100;
      } else {
        // Height is in feet.inches, convert to meters
        // Example: height = 5.84 feet -> 5 feet and 10 inches
        int feetValue = height.floor(); // Get the feet (integer part)
        double inchesValue = (height - feetValue) * 10; // Decimal part as inches
        heightInMeters = (feetValue * 0.3048) + (inchesValue * 0.0254); // Convert to meters
      }

      // Handle weight conversion
      if (isKgSelected) {
        // Weight is in kilograms
        weightInKg = weight;
      } else {
        // Weight is in pounds, convert to kilograms
        weightInKg = weight * 0.453592;
      }

      // Debug logs
      log("Converted height (meters): $heightInMeters");
      log("Converted weight (kg): $weightInKg");

      // Calculate BMI: weight (kg) / [height (meters)]^2
      double calculatedBmi = weightInKg / (heightInMeters * heightInMeters);

      // Display the result with 1 decimal precision
      bmiController.text = calculatedBmi.toStringAsFixed(1);
      log("Calculated BMI: $calculatedBmi");
    } else {
      // Clear the BMI if inputs are invalid
      bmiController.text = "";
    }
  }

}
