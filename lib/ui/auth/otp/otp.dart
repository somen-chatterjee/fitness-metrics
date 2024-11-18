import 'package:fitness_metrics/ui/auth/otp/controller/otp_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:slide_countdown/slide_countdown.dart';

class Otp extends StatefulWidget {
  // 0 -> signup , 1 -> forgot password
  final int screen;
  final String userEmail;

  const Otp({
    super.key,
    required this.screen,
    required this.userEmail,
  });

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  var otpCtrl = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    double pinWidth = 64.0;
    double pinHeight = 56.0;
    double horizontalPadding = 5.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Form(
            key: otpCtrl.otpFormKey,
            child: BaseColumn(
              leftPadding: 28,
              rightPadding: 28,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildSizeHeight(10),
                const BaseText(
                  value: 'Enter OTP ',
                  color: BaseColors.black1,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                buildSizeHeight(25),
                Column(
                  children: [
                    const BaseText(
                      value: "We’ve sent an OTP code to your email,",
                      color: BaseColors.grey3,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                    ),
                    BaseText(
                      value: widget.userEmail,
                      color: BaseColors.grey4,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                buildSizeHeight(50),
                Align(
                  alignment: Alignment.center,
                  child: Pinput(
                    controller: otpCtrl.otpTextCtrl,
                    // obscureText: true,
                    validator: (value) {
                      if (otpCtrl.otpTextCtrl.text.trim().isEmpty) {
                        return "Please Enter OTP First";
                      } else if (otpCtrl.otpTextCtrl.text.trim().length < 4) {
                        return "Please Enter Full OTP";
                      }
                      return null;
                    },
                    focusedPinTheme: PinTheme(
                      width: pinWidth,
                      height: pinHeight,
                      margin:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      textStyle: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: BaseColors.textFilledFill,
                        border: Border.all(
                          color: BaseColors.textFilledBorder,
                          width: 1,
                        ),
                      ),
                    ),
                    defaultPinTheme: PinTheme(
                      width: pinWidth,
                      height: pinHeight,
                      margin:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      textStyle: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        color: BaseColors.textFilledFill,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: BaseColors.textFilledBorder,
                          width: 1,
                        ),
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      width: pinWidth,
                      height: pinHeight,
                      margin:
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      textStyle: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: BoxDecoration(
                        color: BaseColors.textFilledFill,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: BaseColors.textFilledBorder,
                          width: 1,
                        ),
                      ),
                    ),
                    onCompleted: (pin) {},
                  ),
                ),
                buildSizeHeight(30),
                Obx(() {
                  return Visibility(
                    visible: otpCtrl.countdownShow.value,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BaseText(
                          value: "We will resend the code in ",
                          color: BaseColors.lightPurple,
                          fontSize: 16,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Visibility(
                            visible: otpCtrl.countdownShow.value,
                            child: SlideCountdownSeparated(
                              key: UniqueKey(),
                              duration: const Duration(seconds: 30),
                              showZeroValue: false,
                              shouldShowHours: (v) => false,
                              shouldShowDays: (v) => false,
                              suffixIcon: const BaseText(
                                value: "s",
                                color: BaseColors.primaryColor,
                                fontSize: 16,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                              ),
                              style: const TextStyle(
                                color: BaseColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              padding: EdgeInsets.zero,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              onDone: () {
                                otpCtrl.countdownShow.value = false;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Obx(() {
                  return Visibility(
                    visible: !otpCtrl.countdownShow.value,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        otpCtrl.resendOtp(email: widget.userEmail);
                      },
                      child: const BaseText(
                        value: "Resend It",
                        color: BaseColors.primaryColor,
                        fontSize: 16,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
                buildSizeHeight(30),
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
                    if (otpCtrl.otpFormKey.currentState?.validate() ?? false) {
                      otpCtrl.verifyOtp(
                        email: widget.userEmail,
                        screen: widget.screen
                      );
                      // otpCtrl.navigateTo(
                      //   screen: widget.screen,
                      //   email: widget.userEmail,
                      // );
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
