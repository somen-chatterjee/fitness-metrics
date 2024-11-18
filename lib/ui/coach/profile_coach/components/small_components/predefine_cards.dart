
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/controller/coach_preferences_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PredefineCards extends StatefulWidget {
  final int itemIndex;

  const PredefineCards({super.key, required this.itemIndex});

  @override
  State<PredefineCards> createState() => _PredefineCardsState();
}

class _PredefineCardsState extends State<PredefineCards> {
  var profileCtrl = Get.find<CoachPreferencesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: BaseColors.grey5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: BaseText(
                value: profileCtrl.trainingList[widget.itemIndex].name ?? "",
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: BaseColors.black1,
              ),
            ),
            buildSizeWidth(20),
            CustomSwitch(
              value: profileCtrl.trainingList[widget.itemIndex].status ?? false,
              activeColor: BaseColors.green2,
              onChanged: (bool val) {
                setState(() {
                  profileCtrl.setTrainingId(itemIndex: widget.itemIndex);
                });
              },
            ),
            // BaseText(
            //   value: itemIndex != 0 ? 'Inactive' : 'Active',
            //   fontWeight: FontWeight.w400,
            //   fontSize: 14,
            //   color: itemIndex != 0 ? BaseColors.grey2 : BaseColors.green1,
            // ),
          ],
        ),
      );
    });
  }
}
