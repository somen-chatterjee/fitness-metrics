import 'package:fitness_metrics/ui/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key, required this.email});

  final String email;

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var forgotPassCtrl = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Form(
            key: forgotPassCtrl.forgotFormKey,
            child: BaseColumn(
              leftPadding: 28,
              rightPadding: 28,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSizeHeight(10),
                const BaseText(
                  value: 'Forgot password',
                  color: BaseColors.black1,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(35),
                Obx(() {
                  return BaseTextField(
                    controller: forgotPassCtrl.newPassword,
                    textInputType: TextInputType.text,
                    // textCapitalization: TextCapitalization.sentences,
                    labelText: '',
                    hintText: 'New password',
                    obscureText: forgotPassCtrl.isNewPasswordHide.value,
                    suffixIcon: InkWell(
                      onTap: forgotPassCtrl.showNewPassword,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SvgPicture.asset(
                          forgotPassCtrl.isNewPasswordHide.value
                              ? BaseAssets.closeEye
                              : BaseAssets.eye,
                        ),
                      ),
                    ),
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.textFilledBorder,
                    fillColor: BaseColors.textFilledFill,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 17.0),
                    borderRadius: 15,
                    bottomMargin: 8,
                    validator: (val) {
                      String password = forgotPassCtrl.newPassword.value.text.trim();
                      if (password.isEmpty) {
                        return "Please Enter New Password";
                      } else if (password.length < 8 ||
                          !RegExp(r'[A-Z]').hasMatch(password) ||
                          !RegExp(r'[a-z]').hasMatch(password) ||
                          !RegExp(r'[0-9]').hasMatch(password) ||
                          !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
                        // return "Your Password Should Be In At Least 6 Digits";
                        return "The password must be at least 8 characters long. The password must contain at least one uppercase letter, one lowercase letter, one spacial character, and one number";
                      }
                      return null;
                    },
                  );
                }),
                Obx(() {
                  return BaseTextField(
                    controller: forgotPassCtrl.confirmPassword,
                    textInputType: TextInputType.text,
                    // textCapitalization: TextCapitalization.sentences,
                    labelText: '',
                    hintText: 'Confirm password',
                    obscureText: forgotPassCtrl.isConfirmPasswordHide.value,
                    suffixIcon: InkWell(
                      onTap: forgotPassCtrl.showConfirmPassword,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SvgPicture.asset(
                          forgotPassCtrl.isConfirmPasswordHide.value
                              ? BaseAssets.closeEye
                              : BaseAssets.eye,
                        ),
                      ),
                    ),
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.textFilledBorder,
                    fillColor: BaseColors.textFilledFill,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 17.0),
                    borderRadius: 15,
                    bottomMargin: 8,
                    validator: (val) {
                      String newPassword = forgotPassCtrl.newPassword.value.text.trim();
                      String confirmPassword = forgotPassCtrl.confirmPassword.value.text.trim();

                      if (confirmPassword.isEmpty) {
                        return "Please Enter Confirm Password";
                      } else if (confirmPassword != newPassword) {
                        return "Confirm Password And New Password Must Be Same";
                      }
                      return null;
                    },
                  );
                }),
                buildSizeHeight(20),
                BaseButton(
                  title: 'Continue',
                  btnTextColor: BaseColors.primaryColor,
                  btnFontWeight: FontWeight.w600,
                  fontSize: 18,
                  borderRadius: 15,
                  borderEnable: true,
                  btnColor: BaseColors.white2,
                  borderColor: BaseColors.primaryColor,
                  onPressed: () {
                    if(forgotPassCtrl.forgotFormKey.currentState!.validate()) {
                      forgotPassCtrl.changePassword(email: widget.email);
                    }
                  },
                ),
                buildSizeHeight(25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
