import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/auth/sign_in/sign_in.dart';
import 'package:fitness_metrics/ui/auth/sign_up/controller/sign_up_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var signUpCtrl = Get.put(SignUpController());
  var commonCtrl = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: signUpCtrl.formKeySignUp,
            child: BaseColumn(
              leftPadding: 28,
              rightPadding: 28,
              children: [
                buildSizeHeight(10),
                const BaseText(
                  value: 'Sign Up',
                  color: BaseColors.black1,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(35),
                BaseTextField(
                  controller: signUpCtrl.fullName,
                  textInputType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                  labelText: '',
                  hintText: 'Full Name',
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.textFilledBorder,
                  fillColor: BaseColors.textFilledFill,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 17.0),
                  borderRadius: 15,
                  bottomMargin: 8,
                  validator: (val) {
                    if (signUpCtrl.fullName.value.text.trim().isEmpty) {
                      return "Please Enter Full Name";
                    }
                    return null;
                  },
                ),
                BaseTextField(
                  controller: signUpCtrl.mobile,
                  textInputType: TextInputType.number,
                  // textCapitalization: TextCapitalization.sentences,
                  labelText: '',
                  hintText: 'Mobile Number',
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.textFilledBorder,
                  fillColor: BaseColors.textFilledFill,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 17.0,
                  ),
                  borderRadius: 15,
                  bottomMargin: 8,
                  maxLength: 15,
                  validator: (val) {
                    if (signUpCtrl.mobile.value.text.trim().isEmpty) {
                      return "Please Enter Mobile Number";
                    }
                    if (val!.trim().length < 6 || val.trim().length > 15) {
                      return "Mobile number length should be between 6 to 15";
                    }
                    return null;
                  },
                ),
                BaseTextField(
                    controller: signUpCtrl.email,
                    textInputType: TextInputType.emailAddress,
                    // textCapitalization: TextCapitalization.sentences,
                    labelText: '',
                    hintText: 'Email',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.textFilledBorder,
                    fillColor: BaseColors.textFilledFill,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 17.0,
                    ),
                    borderRadius: 15,
                    bottomMargin: 8,
                    validator: (val) {
                      if (signUpCtrl.email.value.text.trim().isEmpty) {
                        return "Please Enter Your Email";
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val!)) {
                        return "Please Enter A Valid Email";
                      }
                      return null;
                    },
                ),
                Obx(() {
                  return BaseTextField(
                    controller: signUpCtrl.password,
                    textInputType: TextInputType.text,
                    // textCapitalization: TextCapitalization.sentences,
                    labelText: '',
                    hintText: 'Password',
                    obscureText: signUpCtrl.isPasswordHide.value,
                    suffixIcon: InkWell(
                      onTap: signUpCtrl.showPassword,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SvgPicture.asset(
                          signUpCtrl.isPasswordHide.value
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
                      String password = signUpCtrl.password.value.text.trim();
                      if (password.isEmpty) {
                        return "Please Enter Your Password";
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
                BaseTextField(
                  controller: signUpCtrl.dob,
                  textInputType: TextInputType.name,
                  // textCapitalization: TextCapitalization.sentences,
                  labelText: '',
                  hintText: 'Date of Birth',
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.textFilledBorder,
                  fillColor: BaseColors.textFilledFill,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SvgPicture.asset(BaseAssets.calendar),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 17.0),
                  borderRadius: 15,
                  bottomMargin: 8,
                  readOnly: true,
                  validator: (val) {
                    if (signUpCtrl.dob.value.text.trim().isEmpty) {
                      return "Please Select Date Of Birth";
                    }else if(!signUpCtrl.isAdult(signUpCtrl.dobDate)){
                      return "Your Age Should Be Above 13";
                    }
                    return null;
                  },
                  onTap: () {
                    showBaseDatePicker(
                      context,
                      // firstDate: checkOutCtrl.currentDate,
                      lastDate: DateTime.now(),
                    ).then((val) {
                      if (val.isNotEmpty) {
                        signUpCtrl.dob.text = dateDDMMYY(val);
                        signUpCtrl.dobDate = dateYYMMDD(val);
                      }
                    });
                  },
                ),
                Visibility(
                  visible: (commonCtrl.roleId ?? 0) == CheckRoleId().athlete,
                  child: BaseTextField(
                    controller: signUpCtrl.coachCode,
                    textInputType: TextInputType.number,
                    // textCapitalization: TextCapitalization.sentences,
                    labelText: '',
                    hintText: '',
                    maxLength: 7,
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.textFilledBorder,
                    fillColor: BaseColors.textFilledFill,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 17.0),
                    borderRadius: 15,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildSizeHeight(3),
                              const BaseText(value: 'Coach Code'),
                            ],
                          ),
                          buildSizeWidth(10),
                          Container(
                            width: 1,
                            height: 38,
                            color: BaseColors.grey1,
                          )
                        ],
                      ),
                    ),
                    bottomMargin: 8,
                    validator: (val) {
                      if (signUpCtrl.coachCode.value.text.trim().isEmpty) {
                        return "Please Enter Your Coach Code";
                      }
                      return null;
                    },
                  ),
                ),
                buildSizeHeight(10),
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
                    if (signUpCtrl.formKeySignUp.currentState?.validate() ??
                        false) {
                      signUpCtrl.signup(isCoach: (commonCtrl.roleId ?? 0) == CheckRoleId().coach);
                    }
                  },
                ),
                buildSizeHeight(25),
                GestureDetector(
                  onTap: () {
                    Get.off(() => const SignIn());
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
                        value: "Sign In",
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
    );
  }
}
