import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/edit_exercise/controllers/edit_workout_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicViewField extends StatefulWidget {
  const DynamicViewField({super.key});

  @override
  State<DynamicViewField> createState() => _DynamicViewFieldState();
}

class _DynamicViewFieldState extends State<DynamicViewField> {
  var editWorkoutCtrl = Get.find<EditWorkoutController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 16,
      ),
      child: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: editWorkoutCtrl.rulesViewList.toSet().map<Widget>((entry) {
            return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BaseText(
                      value: entry.training ?? "",
                      color: BaseColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    BaseText(
                      value: entry.value.toString(),
                      color: BaseColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ],
                )
            );
          }).toList(),
        );
      }),
    );
  }
}