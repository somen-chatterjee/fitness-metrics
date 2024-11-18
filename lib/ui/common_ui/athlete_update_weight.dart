
import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/athlete/athlete_essentials/components/weight_slider.dart';
import 'package:fitness_metrics/ui/athlete/workout_edit/controller/workout_edit_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/controller/weight_view_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:fitness_metrics/utils/get_storage.dart';
import 'package:fitness_metrics/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteUpdateWeight extends StatefulWidget {
  const AthleteUpdateWeight({super.key});

  @override
  State<AthleteUpdateWeight> createState() => _AthleteWeightState();
}

class _AthleteWeightState extends State<AthleteUpdateWeight> {
  final commonCtrl = Get.find<CommonController>();

  ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BaseColumn(
              leftPadding: 28,
              rightPadding: 28,
              children: [
                buildSizeHeight(80),
                const BaseText(
                  value: 'What Is Your Weight?',
                  color: BaseColors.black1,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                buildSizeHeight(20),
                const BaseText(
                  value:
                      "Please enter your current weight to help coach to tailor your fitness plan and track your progress over time. Keeping this information up to date ensures accurate insights and recommendations for your goals.",
                  color: BaseColors.black1,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                ),
                buildSizeHeight(30),
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
                                      commonCtrl.weightType.value =
                                          WeightType.kg;
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
                                        value: "KG",
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
                                      commonCtrl.weightType.value =
                                          WeightType.lb;
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
                                        value: "LB",
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
              ],
            ),
            Obx(() {
              return Expanded(
                child: WeightSlider(
                  from: 0,
                  max: 500,
                  initialValue: commonCtrl.weight.value,
                  type: commonCtrl.weightType.value,
                  onChanged: (value) {
                    // print("weight $value");
                    commonCtrl.weight.value = value;
                  },
                ),
              );
            }),
            BaseColumn(
              leftPadding: 28,
              rightPadding: 28,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     Get.off(() => const AthleteHeight());
                //   },
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
                  onPressed: () async {
                    dynamic roleId =
                        await BaseStorage.read(StorageKeys.roleId) ?? "";

                    String athleteId;

                    if (int.parse(roleId.toString()) == CheckRoleId().athlete) {
                      athleteId =
                          await BaseStorage.read(StorageKeys.userId) ?? "";
                    } else {
                      var ctrl = Get.find<AthleteDataController>();
                      athleteId = ctrl.athleteData.value.userId ?? "";
                    }

                    commonCtrl
                        .athleteDetails(athleteId: athleteId, isWeightScreen: true)
                        .then((value) {
                      if (int.parse(roleId.toString()) == CheckRoleId().athlete) {
                        Get.find<WorkoutEditController>().athleteDetailsChart();
                      } else {
                        var weightViewCtrl = Get.find<WeightViewController>();
                        weightViewCtrl.athleteDetailsCoachViewChart();
                      }
                    });
                  },
                ),
                buildSizeHeight(35),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
