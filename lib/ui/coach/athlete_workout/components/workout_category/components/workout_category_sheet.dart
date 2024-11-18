import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/models/plan_workout_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/components/workout_category_cards.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/workout_category/controller/workout_category_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WorkoutCategorySheet extends StatefulWidget {
  final WorkoutData workoutData;
  const WorkoutCategorySheet({super.key, required this.workoutData});

  @override
  State<WorkoutCategorySheet> createState() => _WorkoutCategorySheetState();
}

class _WorkoutCategorySheetState extends State<WorkoutCategorySheet> {
  var workoutCategoryCtrl = Get.find<WorkoutCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(
              color: BaseColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: BaseColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        value: 'Add section',
                        color: BaseColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  buildSizeHeight(10),
                  Expanded(
                    child: GridView.builder(
                      // shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      // padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 42),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 18,
                        crossAxisSpacing: 18,
                        childAspectRatio: 1.9,
                      ),
                      itemCount: workoutCategoryCtrl.sectionList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return WorkoutCategoryCards(categoryIndex: index);
                      },
                    ),
                  ),
                  buildSizeHeight(10),
                  BaseButton(
                    title: 'Create',
                    btnHeight: 45,
                    leftMargin: 20,
                    rightMargin: 20,
                    onPressed: () {
                      // workoutCategoryCtrl.addAllCategory();
                      workoutCategoryCtrl.workoutSectionCreate(
                        workoutId: widget.workoutData.id ?? '',
                      );
                      Get.back();
                    },
                  ),
                  buildSizeHeight(10),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: BaseColors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(BaseAssets.cancel),
            ),
          ),
        ],
      ),
    );
  }
}
