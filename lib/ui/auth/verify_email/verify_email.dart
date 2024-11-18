import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/auth/verify_email/controller/verify_email_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/common_ui/contact_us_form.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  var signInCtrl = Get.put(VerifyEmailController());
  var commonCtrl = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: BaseColumn(
            leftPadding: 28,
            rightPadding: 28,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSizeHeight(10),
              const BaseText(
                value: 'Forgot Password!',
                color: BaseColors.black1,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              buildSizeHeight(35),
              Form(
                key: signInCtrl.emailFormKey,
                child: BaseTextField(
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
              ),
              buildSizeHeight(40),
              BaseButton(
                title: 'Verify',
                btnTextColor: BaseColors.primaryColor,
                btnFontWeight: FontWeight.w600,
                fontSize: 18,
                borderRadius: 15,
                borderEnable: true,
                btnColor: BaseColors.white2,
                borderColor: BaseColors.primaryColor,
                onPressed: () {
                  if ((signInCtrl.emailFormKey.currentState?.validate() ?? false)) {
                    signInCtrl.forgotPassword();
                  }
                },
              ),
              buildSizeHeight(25),
            ],
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
