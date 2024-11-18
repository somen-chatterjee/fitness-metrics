import 'package:dotted_border/dotted_border.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/controllers/create_workout_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/models/plan_workout_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/workout_category.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkoutGridCards extends StatefulWidget {
  final WorkoutData workoutData;
  const WorkoutGridCards({super.key, required this.workoutData});

  @override
  State<WorkoutGridCards> createState() => _WorkoutGridCardsState();
}

class _WorkoutGridCardsState extends State<WorkoutGridCards> {
  // bool _value = false;
  var createWorkoutCtrl = Get.find<CreateWorkoutController>();

  @override
  Widget build(BuildContext context) {
    var value = (widget.workoutData.exerciseStatus ?? false);
    var checkWidthHeight = 16.0;
    return GestureDetector(
      onTap: () {
        createWorkoutCtrl.selectedWorkoutData = widget.workoutData;
        Get.to(
          () => const WorkoutCategory(),
        );
        //     ?.then((v) {
        //   setState(() {
        //     _value = !_value;
        //   });
        // });
      },
      child: DottedBorder(
        color: value ? BaseColors.primaryColor : BaseColors.grey3,
        borderType: BorderType.RRect,
        radius: const Radius.circular(15),
        // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        dashPattern: const <double>[3, 2],
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.network(
                    widget.workoutData.icon ?? "",
                    // fit: BoxFit.cover,
                    width: 35,
                    height: 35,
                    colorFilter: ColorFilter.mode(
                      value ? BaseColors.primaryColor : BaseColors.grey2,
                      BlendMode.srcIn,
                    ),
                  ),
                  buildSizeHeight(8),
                  BaseText(
                    value: widget.workoutData.name ?? '',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: value ? BaseColors.primaryColor : BaseColors.grey2,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: checkWidthHeight,
                height: checkWidthHeight,
                alignment: Alignment.center,
                child: value ? SvgPicture.asset(BaseAssets.checked) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
