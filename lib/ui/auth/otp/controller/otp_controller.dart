import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/athlete/athlete_essentials/athlete_weight.dart';
import 'package:fitness_metrics/ui/auth/forgot_password/forgot_password.dart';
import 'package:fitness_metrics/ui/auth/otp/models/otp_models.dart';
import 'package:fitness_metrics/ui/coach/dashboard/coach_dashboard.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  var commonController = Get.find<CommonController>();

  TextEditingController otpTextCtrl = TextEditingController();
  RxBool countdownShow = true.obs;

  final otpFormKey = GlobalKey<FormState>();

  // 0 -> signup , 1 -> forgot password
  void navigateTo({required int screen, String? accessToken, String? userId, String? email}) {
    if (screen == 0) {
      if ((commonController.roleId ?? 0) != 0) {
        if (accessToken != null && accessToken.isNotEmpty) {
          commonController.saveLoginDetails(
            accessToken: accessToken,
            roleId: commonController.roleId.toString(),
            userId: userId,
          );
        }
        goNextScreen();
      }
    } else {
      Get.off(() => ForgotPassword(email: email ?? ''));
    }
  }

  void goNextScreen() {
    // print("object ${commonController.roleId}");
    if ((commonController.roleId ?? 0) == CheckRoleId().coach) {
      Get.offAll(() => const CoachDashboard());
    } else if ((commonController.roleId ?? 0) == CheckRoleId().athlete) {
      Get.offAll(() => const AthleteWeight());
    }
  }

  void verifyOtp({required String email, required int screen}) async {
    triggerHapticFeedback();
    Map<String, dynamic> data = {
      "role": commonController.roleId.toString(),
      "otp": otpTextCtrl.text.trim().toString(),
      "email": email,
      "changepassword": (screen == 1).toString()
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().verifyOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          OtpModels response = OtpModels.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            navigateTo(
              screen: screen,
              accessToken: response.data?.accessToken,
              email: email,
              userId: response.data?.userId,
            );
          } else {
            showSnackBar(subtitle: response.message ?? "");
            otpTextCtrl.clear();
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  void resendOtp({required String email}) async {
    triggerHapticFeedback();
    Map<String, dynamic> data = {
      "role": commonController.roleId.toString(),
      "email": email
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().resendOtp, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          OtpModels response = OtpModels.fromJson(value?.data);
          if (response.status ?? false) {
            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            countdownShow.value = true;
            // goNextScreen();
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
