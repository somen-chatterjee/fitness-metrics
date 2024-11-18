import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/athlete_dashboard.dart';
import 'package:fitness_metrics/ui/auth/otp/otp.dart';
import 'package:fitness_metrics/ui/auth/sign_in/models/forgot_password_model.dart';
import 'package:fitness_metrics/ui/auth/sign_in/models/sign_in_model.dart';
import 'package:fitness_metrics/ui/coach/dashboard/coach_dashboard.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  var commonController = Get.find<CommonController>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool isPasswordHide = true.obs;

  final signInFormKey = GlobalKey<FormState>();
  final emailFormKey = GlobalKey<FormState>();

  void showPassword() {
    isPasswordHide.value = !isPasswordHide.value;
  }

  void goDashboardScreen() {
    // print("object ${commonController.roleId}");
    if ((commonController.roleId ?? 0) == CheckRoleId().coach) {
      Get.offAll(() => const CoachDashboard());
    } else if ((commonController.roleId ?? 0) == CheckRoleId().athlete) {
      Get.offAll(() => const AthleteDashboard());
    } else {
      showSnackBar(
        title: "Error",
        subtitle: "Please select a role first.",
      );
    }
  }

  void signIn() async {
    triggerHapticFeedback();
    Map<String, dynamic> data = {
      "role": commonController.roleId.toString(),
      "email": email.text.trim().toString(),
      "password": password.text.trim().toString()
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().signIn, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          SignInModel response = SignInModel.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            commonController.saveLoginDetails(
              accessToken: response.data?.accessToken,
              roleId: commonController.roleId.toString(),
              userId: response.data?.userId,
            );
            goDashboardScreen();
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

  void forgotPassword() async {
    triggerHapticFeedback();
    Map<String, dynamic> data = {
      "role": commonController.roleId.toString(),
      "email": email.text.trim().toString()
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().forgotPassword, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          ForgotPasswordModels response =
              ForgotPasswordModels.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            Get.to(() => Otp(
                  screen: 1,
                  userEmail: email.text.trim().toString(),
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
