import 'package:fitness_metrics/ui/athlete/archive_workout/archive_workout.dart';
import 'package:fitness_metrics/ui/athlete/workout/controller/workout_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
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
  var workoutCtrl = Get.find<WorkoutController>();

  @override
  Widget build(BuildContext context) {
    var planData = workoutCtrl.planDataList[widget.itemIndex];

    return GestureDetector(
      onTap: () {
        if(planData.status != 2) {
          Get.to(() =>
              ArchiveWorkout(
                title: planData.name ?? '',
                planId: planData.id ?? '',
              ));
        }
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
                    value: planData.name ?? '',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: BaseColors.black1,
                  ),
                  BaseText(
                    value:
                        '${dateDDMMYY(planData.startDate ?? '')} - ${dateDDMMYY(planData.finishDate ?? '')}',
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: BaseColors.grey2,
                  ),
                ],
              ),
            ),
            buildSizeWidth(20),
            BaseText(
              value: planData.status == 2 ? 'Inactive' : 'Active',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color:
                  planData.status == 2 ? BaseColors.grey2 : BaseColors.green1,
            ),
          ],
        ),
      ),
    );
  }
}
