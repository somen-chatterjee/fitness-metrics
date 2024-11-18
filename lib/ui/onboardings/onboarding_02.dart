import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/role/role_screen.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Onboarding02 extends StatefulWidget {
  const Onboarding02({super.key});

  @override
  State<Onboarding02> createState() => _Onboarding02State();
}

class _Onboarding02State extends State<Onboarding02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            BaseAssets.boardingImage1,
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: SvgPicture.asset(
                  BaseAssets.boardingShape,
                  fit: BoxFit.fill,
                ),
              ),
              BaseColumn(
                leftPadding: 35,
                rightPadding: 35,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(BaseAssets.appIcon),
                  buildSizeHeight(40),
                  const BaseText(
                    value: "Welcome To Fitness\nMetrics",
                    color: Colors.white,
                    fontSize: 24,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700,
                  ),
                  buildSizeHeight(12),
                  const BaseText(
                    value: "Choose your own fitness journey with",
                    color: Colors.white,
                    fontSize: 18,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ),
                  buildSizeHeight(30),
                  BaseButton(
                    title: 'Get Started',
                    btnColor: Colors.white,
                    btnTextColor: BaseColors.primaryColor,
                    btnFontWeight: FontWeight.w600,
                    fontSize: 16,
                    preFixIcon: SvgPicture.asset(BaseAssets.rightArrow),
                    onPressed: () => Get.offAll(() => const RoleScreen()),
                    borderRadius: 15,
                  ),
                  buildSizeHeight(30),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.offAll(() => const SignIn(isSignUp: false,));
                  //   },
                  //   child: const BaseText(
                  //     value: "Already have account?",
                  //     color: Colors.white,
                  //     fontSize: 16,
                  //     textAlign: TextAlign.center,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  buildSizeHeight(30),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
