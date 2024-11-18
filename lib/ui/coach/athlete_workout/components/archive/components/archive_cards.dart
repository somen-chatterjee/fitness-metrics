import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/create_workout.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/controller/coach_archive_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ArchiveCards extends StatefulWidget {
  final int itemIndex;

  const ArchiveCards({super.key, required this.itemIndex});

  @override
  State<ArchiveCards> createState() => _ArchiveCardsState();
}

class _ArchiveCardsState extends State<ArchiveCards> {
  var coachArchiveCtrl = Get.find<CoachArchiveController>();

  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _switchValue =
        (coachArchiveCtrl.planDataList[widget.itemIndex].status ?? 2) == 1;
  }

  @override
  Widget build(BuildContext context) {
    var planData = coachArchiveCtrl.planDataList[widget.itemIndex];

    return GestureDetector(
      onTap: () {
        coachArchiveCtrl.selectedPlan = planData;

        Get.to(() => CreateWorkout(
              planData: planData,
            ));
      },
      child: Container(
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: BaseColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                BaseAssets.plan,
                width: 22,
                height: 22,
              ),
            ),
            buildSizeWidth(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    value: planData.name ?? "",
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: BaseColors.black1,
                  ),
                  BaseText(
                    value:
                        '${dateDDMMYY(planData.startDate ?? "")} - ${dateDDMMYY(planData.finishDate ?? "")}',
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: BaseColors.grey2,
                  ),
                ],
              ),
            ),
            buildSizeWidth(20),
            CustomSwitch(
              value: _switchValue,
              activeColor: BaseColors.green2,
              onChanged: (bool val) async {
                coachArchiveCtrl
                    .planStatusUpdate(
                        planId: planData.id ?? "", status: val ? 1 : 2)
                    .then((value) {
                  if (value) {
                    setState(() {
                      _switchValue = val;
                    });
                  }
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
      ),
    );
  }
}
