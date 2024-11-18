import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/auth/otp/otp.dart';
import 'package:fitness_metrics/ui/auth/sign_up/models/sign_up_models.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignUpController extends GetxController {
  TextEditingController fullName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController coachCode = TextEditingController();
  String dobDate = "";

  RxBool isPasswordHide = true.obs;

  final formKeySignUp = GlobalKey<FormState>();

  void showPassword() {
    isPasswordHide.value = !isPasswordHide.value;
  }

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

  void signup({required bool isCoach}) async {
    Map<String, dynamic> data = {
      "role": isCoach ? CheckRoleId().coach.toString() : CheckRoleId().athlete.toString(),
      "name": fullName.text.trim(),
      "date_of_birth": dobDate,
      "email": email.text.trim(),
      "mobile": mobile.text.trim(),
      "password": password.text.trim(),
      "confirm_password": password.text.trim(),
      "device_token": "055bf0f3940bd685bb83431617f90f83",
      "coach_code": isCoach ? '' : coachCode.text.trim(),
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().signup, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          SignUpModels response = SignUpModels.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            triggerHapticFeedback();
            Get.to(() => Otp(
                  screen: 0,
                  userEmail: response.data!.email.toString(),
                ));
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
