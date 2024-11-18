
import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsForm extends StatefulWidget {
  const ContactUsForm({super.key});

  @override
  State<ContactUsForm> createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  var commonCtrl = Get.find<CommonController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonCtrl.clearForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Form(
            key: commonCtrl.contactUsFormKey,
            child: BaseColumn(
              leftPadding: 28,
              rightPadding: 28,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSizeHeight(10),
                const BaseText(
                  value: 'Contact Us!',
                  color: BaseColors.black1,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(35),
                BaseTextField(
                  controller: commonCtrl.name,
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  labelText: '',
                  hintText: 'Account Name',
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.textFilledBorder,
                  fillColor: BaseColors.textFilledFill,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 17.0),
                  borderRadius: 15,
                  bottomMargin: 8,
                  validator: (val) {
                    if (commonCtrl.name.value.text.trim().isEmpty) {
                      return "Please Enter Your Account Name";
                    }
                    return null;
                  },
                ),
                buildSizeHeight(12),
                // account email
                BaseTextField(
                  controller: commonCtrl.accountEmail,
                  textInputType: TextInputType.emailAddress,
                  // textCapitalization: TextCapitalization.sentences,
                  labelText: '',
                  hintText: 'Account Email',
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.textFilledBorder,
                  fillColor: BaseColors.textFilledFill,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 17.0),
                  borderRadius: 15,
                  bottomMargin: 8,
                  validator: (val) {
                    if (commonCtrl.accountEmail.value.text.trim().isEmpty) {
                      return "Please Enter Your Account Email";
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val!)) {
                      return "Please Enter A Valid Email";
                    }
                    return null;
                  },
                ),
                buildSizeHeight(12),
                // description
                BaseTextField(
                  controller: commonCtrl.description,
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  labelText: '',
                  hintText: 'Description',
                  maxLine: 4,
                  hintTextColor: BaseColors.grey,
                  borderColor: BaseColors.textFilledBorder,
                  fillColor: BaseColors.textFilledFill,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 17.0),
                  borderRadius: 15,
                  bottomMargin: 8,

                  validator: (val) {
                    if (commonCtrl.description.value.text.trim().isEmpty) {
                      return "Please Enter Description";
                    }
                    return null;
                  },
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
                    if ((commonCtrl.contactUsFormKey.currentState?.validate() ??
                        false)) {
                      commonCtrl.contactUs();
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
