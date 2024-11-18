import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/add_exercise/controller/add_exercise_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/edit_exercise/edit_exercise.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExerciseCards extends StatefulWidget {
  final int itemIndex;
  final String exerciseFor;
  final String sectionId;

  const ExerciseCards({
    super.key,
    required this.itemIndex,
    required this.exerciseFor,
    required this.sectionId,
  });

  @override
  State<ExerciseCards> createState() => _ExerciseCardsState();
}

class _ExerciseCardsState extends State<ExerciseCards> {
  var addExerciseCtrl = Get.find<AddExerciseController>();

  @override
  Widget build(BuildContext context) {
    var cardTitle = addExerciseCtrl.exerciseDisplayList[widget.itemIndex];
    return GestureDetector(
      onTap: () {
        if ((cardTitle.rules ?? []).isNotEmpty) {
          Get.to(() => EditExercise(
                exerciseTitle:
                    '${cardTitle.name ?? ''} - ${widget.exerciseFor}',
                exerciseId: cardTitle.id?.toString() ?? '',
                sectionId: widget.sectionId,
              ));
        } else {
          showSnackBar(
            title: "Invalid data!",
            subtitle: "Please set some preferences for this section.",
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                value: cardTitle.name ?? '',
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: BaseColors.black1,
              ),
            ),
            buildSizeWidth(20),
            SvgPicture.asset(BaseAssets.rightArrow2),
          ],
        ),
      ),
    );
  }
}
