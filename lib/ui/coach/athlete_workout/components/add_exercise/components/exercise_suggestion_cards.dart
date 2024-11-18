import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/add_exercise/controller/add_exercise_controller.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/models/exercises_model.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExerciseSuggestionCards extends StatefulWidget {
  final ExerciseData exerciseData;
  final String sectionId;

  const ExerciseSuggestionCards({
    super.key,
    required this.exerciseData,
    required this.sectionId,
  });

  @override
  State<ExerciseSuggestionCards> createState() => _ExerciseSuggestionCardsState();
}

class _ExerciseSuggestionCardsState extends State<ExerciseSuggestionCards> {
  var addExerciseCtrl = Get.find<AddExerciseController>();

  // bool _value = false;

  @override
  Widget build(BuildContext context) {
    var checkWidthHeight = 20.0;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          // _value = !_value;
        addExerciseCtrl.addDataToSelectedList(exerciseData: widget.exerciseData, sectionId: widget.sectionId);

        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
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
                value: widget.exerciseData.name ?? '',
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: BaseColors.black1,
              ),
            ),
            buildSizeWidth(20),
            Container(
              width: checkWidthHeight,
              height: checkWidthHeight,
              alignment: Alignment.center,
              child: widget.exerciseData.isSelected ?? false
                  ? SvgPicture.asset(BaseAssets.checked)
                  : SvgPicture.asset(BaseAssets.unchecked),
            ),
          ],
        ),
      ),
    );
  }
}
