
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/small_components/predefine_cards.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/controller/coach_preferences_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachPreferences extends StatefulWidget {
  const CoachPreferences({super.key});

  @override
  State<CoachPreferences> createState() => _CoachPreferencesState();
}

class _CoachPreferencesState extends State<CoachPreferences> {
  late CoachPreferencesController coachPrefCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<CoachPreferencesController>();
    coachPrefCtrl = Get.put(CoachPreferencesController());
    coachPrefCtrl.getSectionList(sectionId: '');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: BaseText(
                value: 'Wellness Frequency',
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Obx(() {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: BaseColors.yellowGreen,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 40,
                child: PopupMenuButton<String>(
                  position:PopupMenuPosition.under,
                  itemBuilder: (context) {
                    return coachPrefCtrl.timeList.map((obj) {
                      return PopupMenuItem(
                        height: 35,
                        value: "${obj.time ?? ""}",
                        child: BaseText(
                          value: obj.time ?? "",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        onTap: () {
                          if (obj.time != coachPrefCtrl.preferenceTime.value) {
                            coachPrefCtrl.preferenceTime.value = obj;
                          }
                        },
                      );
                    }).toList();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      BaseText(
                        value: coachPrefCtrl.preferenceTime.value.time ?? "",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: BaseColors.black1,
                      ),
                    ],
                  ),
                  onSelected: (v) {
                  },
                ),
              );
            }),
          ],
        ),
        buildSizeHeight(20),
        const Align(
          alignment: Alignment.center,
          child: BaseText(
            value: 'Predefined training variables',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        buildSizeHeight(15),
        Obx(() {
          return IntrinsicWidth(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: BaseColors.yellowGreen,
                borderRadius: BorderRadius.circular(5),
              ),
              height: 40,
              child: PopupMenuButton<String>(
                position:PopupMenuPosition.under,
                itemBuilder: (context) {
                  return coachPrefCtrl.sectionList.map((obj) {
                    return PopupMenuItem(
                      height: 35,
                      value: "${obj.name ?? ""}",
                      child: BaseText(
                        value: obj.name ?? "",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      onTap: () {
                        // log("message ${obj.name}");
                        if (obj.name != coachPrefCtrl.sectionType.value) {
                          coachPrefCtrl.getCurrentSectionData(
                            selectedSection: obj,
                          );
                        }
                      },
                    );
                  }).toList();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    BaseText(
                      value: coachPrefCtrl.sectionType.value,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: BaseColors.black1,
                    ),
                  ],
                ),
                onSelected: (v) {},
              ),
            ),
          );
        }),
        Expanded(
          child: Obx(() {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 42),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 25,
                crossAxisSpacing: 35,
                childAspectRatio: 3.5,
              ),
              shrinkWrap: true,
              itemCount: coachPrefCtrl.trainingList.length,
              itemBuilder: (context, index) {
                return PredefineCards(itemIndex: index);
              },
            );
          }),
        ),
        buildSizeHeight(10),
        Obx(() {
          return Visibility(
            visible: coachPrefCtrl.trainingIdList.isNotEmpty,
            child: BaseButton(
              title: 'Save',
              btnHeight: 45,
              leftMargin: 20,
              rightMargin: 20,
              onPressed: () => coachPrefCtrl.sectionCoachRulesCreate(),
            ),
          );
        }),
      ],
    );
  }
}
