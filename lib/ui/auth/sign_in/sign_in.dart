import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/auth/sign_in/controller/sign_in_controller.dart';
import 'package:fitness_metrics/ui/auth/sign_up/sign_up.dart';
import 'package:fitness_metrics/ui/auth/verify_email/verify_email.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/common_ui/contact_us_form.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var signInCtrl = Get.put(SignInController());
  var commonCtrl = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Form(
            key: signInCtrl.signInFormKey,
            child: BaseColumn(
              leftPadding: 28,
              rightPadding: 28,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSizeHeight(10),
                const BaseText(
                  value: 'Sign In',
                  color: BaseColors.black1,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(35),
                BaseTextField(
                  controller: signInCtrl.email,
                  textInputType: TextInputType.emailAddress,
                  // textCapitalization: TextCapitalization.sentences,
                  labelText: '',
                  hintText: 'Email',
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.textFilledBorder,
                  fillColor: BaseColors.textFilledFill,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 17.0),
                  borderRadius: 15,
                  bottomMargin: 8,
                  validator: (val) {
                    if (signInCtrl.email.value.text.trim().isEmpty) {
                      return "Please Enter Your Email";
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val!)) {
                      return "Please Enter A Valid Email";
                    }
                    return null;
                  },
                ),
                Obx(() {
                  return BaseTextField(
                    controller: signInCtrl.password,
                    textInputType: TextInputType.text,
                    // textCapitalization: TextCapitalization.sentences,
                    labelText: '',
                    hintText: 'Password',
                    obscureText: signInCtrl.isPasswordHide.value,
                    suffixIcon: InkWell(
                      onTap: signInCtrl.showPassword,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SvgPicture.asset(
                          signInCtrl.isPasswordHide.value
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
                      String password = signInCtrl.password.value.text.trim();
                      if (password.isEmpty) {
                        return "Please Enter Your Password";
                      }
                      return null;
                    },
                  );
                }),
                buildSizeHeight(10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const VerifyEmail());
                    },
                    child: const BaseText(
                      value: "Forgot password?",
                      color: BaseColors.black1,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
                    if (signInCtrl.signInFormKey.currentState?.validate() ??
                        false) {
                      signInCtrl.signIn();
                    }
                  },
                ),
                buildSizeHeight(25),
                GestureDetector(
                  onTap: () {
                    // if (widget.isSignUp) {
                    //   Get.back();
                    // } else {
                    Get.off(() => const SignUp());
                    // }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const BaseText(
                        value: "Already have account?",
                        color: BaseColors.grey2,
                        fontSize: 14,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                      ),
                      buildSizeWidth(3),
                      const BaseText(
                        value: "Sign Up",
                        color: BaseColors.black1,
                        fontSize: 14,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                buildSizeHeight(25),
                const BaseText(
                  value: "Or",
                  color: BaseColors.grey2,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
                buildSizeHeight(25),
                SvgPicture.asset(BaseAssets.google),
                buildSizeHeight(25),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: (commonCtrl.roleId ?? 0) == CheckRoleId().athlete,
        child: GestureDetector(
          onTap: () => Get.to(() => const ContactUsForm()),
          child: const BaseText(
            value: "Contact Us!",
            textAlign: TextAlign.center,
            underline: true,
            color: BaseColors.primaryColor,
            bottomMargin: 10,
          ),
        ),
      ),
    );
  }
}
