import 'package:fitness_metrics/ui/athlete/athlete_essentials/components/height_slider.dart';
import 'package:fitness_metrics/ui/athlete/athlete_essentials/controllers/athlete_details_controllers.dart';
import 'package:fitness_metrics/ui/athlete/athlete_essentials/upload_photo.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteHeight extends StatefulWidget {
  const AthleteHeight({super.key});

  @override
  State<AthleteHeight> createState() => _AthleteHeightState();
}

class _AthleteHeightState extends State<AthleteHeight> {
  final athleteDetailsCtrl = Get.find<AthleteDetailsControllers>();
  ValueNotifier<int> selectedIndex = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BaseColumn(
          leftPadding: 28,
          rightPadding: 28,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildSizeHeight(40),
            const BaseText(
              value: 'What Is Your Height?',
              color: BaseColors.black1,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            buildSizeHeight(20),
            const BaseText(
              value:
                  "Please add your height to help coach to create a customized fitness plan that's tailored to your unique body metrics. Accurate information will allow us to provide better insights and recommendations for your goals.",
              color: BaseColors.black1,
              fontSize: 14,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
            ),
            buildSizeHeight(30),
            Expanded(
              child: Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: selectedIndex,
                      builder: (context, selectedVal, child) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: BaseColors.primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        selectedIndex.value = 0;
                                        athleteDetailsCtrl.heightType.value =
                                            HeightType.cm;
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: selectedVal == 0
                                            ? BoxDecoration(
                                          color: BaseColors.primaryColor,
                                          borderRadius:
                                          BorderRadius.circular(14),
                                        )
                                            : null,
                                        child: BaseText(
                                          value: "CM",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          onTapTopPadding: 5,
                                          onTapBottomPadding: 5,
                                          color: selectedVal == 0
                                              ? BaseColors.white
                                              : BaseColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: BaseColors.primaryColor,
                                    thickness: 3,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        selectedIndex.value = 1;
                                        athleteDetailsCtrl.heightType.value =
                                            HeightType.feet;
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: selectedVal == 1
                                            ? BoxDecoration(
                                          color: BaseColors.primaryColor,
                                          borderRadius:
                                          BorderRadius.circular(14),
                                        )
                                            : null,
                                        child: BaseText(
                                          value: "Feet",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          onTapTopPadding: 5,
                                          onTapBottomPadding: 5,
                                          color: selectedVal == 1
                                              ? BaseColors.white
                                              : BaseColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),

                  buildSizeHeight(100),
                  Obx(() {
                    return Flexible(
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(270 / 360),
                        child: HeightSlider(
                          from: 0,
                          max: 500,
                          initialValue: athleteDetailsCtrl.height.value,
                          type: athleteDetailsCtrl.heightType.value,
                          onChanged: (value) {
                            // print("height $value");
                            athleteDetailsCtrl.height.value = value;
                          },
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () => Get.off(() => const UploadPhoto()),
            //   child: const BaseText(
            //     value: "Answer later",
            //     color: BaseColors.lightPurple,
            //     fontSize: 16,
            //     underline: true,
            //     textAlign: TextAlign.center,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            buildSizeHeight(12),
            BaseButton(
              title: 'Continue',
              btnTextColor: BaseColors.primaryColor,
              btnFontWeight: FontWeight.w600,
              fontSize: 18,
              borderRadius: 15,
              borderEnable: true,
              btnColor: BaseColors.white2,
              borderColor: BaseColors.primaryColor,
              onPressed: () => Get.to(() => const UploadPhoto()),
            ),
            buildSizeHeight(35),
          ],
        ),
      ),
    );
  }
}
