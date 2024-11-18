import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/auth/forgot_password/models/forgot_pass_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{
  var commonController = Get.find<CommonController>();

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final forgotFormKey = GlobalKey<FormState>();

  RxBool isNewPasswordHide = true.obs;
  RxBool isConfirmPasswordHide = true.obs;

  void showNewPassword() {
    isNewPasswordHide.value = !isNewPasswordHide.value;
  }

  void showConfirmPassword() {
    isConfirmPasswordHide.value = !isConfirmPasswordHide.value;
  }

  void changePassword({required String email}) async {
    triggerHapticFeedback();
    Map<String, dynamic> data = {
      "role": commonController.roleId,
      "new_password": newPassword.text.trim().toString(),
      "confirm_password": confirmPassword.text.trim().toString(),
      "email": email
    };
    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().changePassword, data: data)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          ForgotPasswordModel response = ForgotPasswordModel.fromJson(value?.data);
          if (response.status ?? false) {
            Get.back();
            Get.back();

            showSnackBar(subtitle: response.message ?? "", isSuccess: true);
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