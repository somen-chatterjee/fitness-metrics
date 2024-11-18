import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/controller/exercise_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExerciseLibraryCards extends StatefulWidget {
  final int itemIndex;

  const ExerciseLibraryCards({super.key, required this.itemIndex});

  @override
  State<ExerciseLibraryCards> createState() => _ExerciseLibraryCardsState();
}

class _ExerciseLibraryCardsState extends State<ExerciseLibraryCards> {
  var exerciseCtrl = Get.find<ExerciseController>();

  @override
  Widget build(BuildContext context) {
    var exerciseData = exerciseCtrl.exerciseList[widget.itemIndex];
    return Container(
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
              value: exerciseData.name ?? "",
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: BaseColors.black1,
            ),
          ),
          buildSizeWidth(20),
          GestureDetector(
            onTap: () {
              exerciseCtrl.getExerciseEditData(exerciseId: "${exerciseData.id ?? ""}");
            },
            child: SvgPicture.asset(
              BaseAssets.editPencil,
              colorFilter: const ColorFilter.mode(BaseColors.black1, BlendMode.srcIn),
            ),
          ),
          buildSizeWidth(20),
          GestureDetector(
            onTap: () {
              exerciseCtrl.showExerciseDelete(
                context: context,
                exerciseId: "${exerciseData.id ?? ""}",
                index: widget.itemIndex,
              );
            },
            child: SvgPicture.asset(
              BaseAssets.delete,
              colorFilter: const ColorFilter.mode(BaseColors.black1, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
