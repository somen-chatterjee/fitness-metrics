import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/onboardings/onboarding_02.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Onboarding01 extends StatefulWidget {
  const Onboarding01({super.key});

  @override
  State<Onboarding01> createState() => _Onboarding01State();
}

class _Onboarding01State extends State<Onboarding01>
    with TickerProviderStateMixin {
  late AnimationController controller;

  bool isImageChanged = false;

  int totalSeconds = 6;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: Duration(seconds: totalSeconds ~/2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    changeImage() ;
    changeScreen();
    super.initState();
  }

  void changeScreen() {
    Future.delayed(Duration(seconds: totalSeconds),
        () => Get.offAll(() => const Onboarding02()));
  }

  void changeImage() {
    Future.delayed(
        Duration(seconds: totalSeconds ~/ 2), () => isImageChanged = true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (!isImageChanged)
              Positioned(
                bottom: 70,
                left: 0,
                right: 0,
                child: Image.asset(
                  // width: 200,
                  height: 700,
                  BaseAssets.boardingImage2,
                  fit: BoxFit.fill,
                ),
              )
            else
              Image.asset(
                width: size.width,
                height: size.height,
                BaseAssets.boardingImage3,
                fit: BoxFit.fill,
              ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: SvgPicture.asset(
                    BaseAssets.boardingShape1,
                    fit: BoxFit.fill,
                  ),
                ),
                BaseColumn(
                  leftPadding: 35,
                  rightPadding: 35,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(BaseAssets.appIcon),
                    buildSizeHeight(60),
                    const BaseText(
                      value: "Personalized Fitness\nPlans",
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
                  ],
                )
              ],
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90.0),
                child: LinearProgressIndicator(
                  value: controller.value,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  minHeight: 7,
                  backgroundColor: BaseColors.white.withOpacity(0.32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
