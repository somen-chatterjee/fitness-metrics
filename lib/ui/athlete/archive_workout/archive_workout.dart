// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/athlete/archive_workout/controller/archive_controller.dart';
import 'package:fitness_metrics/ui/athlete/start_workout/start_workout.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ArchiveWorkout extends StatefulWidget {
  final String title;
  final String planId;

  const ArchiveWorkout({
    super.key,
    required this.title,
    required this.planId,
  });

  @override
  State<ArchiveWorkout> createState() => _ArchiveWorkoutState();
}

class _ArchiveWorkoutState extends State<ArchiveWorkout> {
  ArchiveController archiveCtrl = Get.put(ArchiveController());

  @override
  void initState() {
    super.initState();
    archiveCtrl.planWorkoutGet(planId: widget.planId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BaseAppBar(
            title: widget.title,
          ),
          buildSizeHeight(20),
          Expanded(
            child: BaseColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Obx(() {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: archiveCtrl.planWorkoutDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return workoutTypeCard(
                            unSelectedImage:
                                archiveCtrl.planWorkoutDataList[index].icon ??
                                    "",
                            title:
                                archiveCtrl.planWorkoutDataList[index].name ??
                                    "",
                            isSelected: archiveCtrl
                                    .planWorkoutDataList[index].isSelected ??
                                false,
                            onPressed: () =>
                                archiveCtrl.selectWorkout(index: index),
                          );
                        },
                      );
                    }),
                  ),
                ),
                // Expanded(
                //   child: Center(
                //     child: Obx(() {
                //       return Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           workoutTypeCard(
                //               selectedImage: BaseAssets.pushSelect,
                //               unSelectedImage: BaseAssets.pushUnselect,
                //               title: "Push",
                //               isSelected: archiveCtrl.workoutType.value == 0,
                //               onPressed: () => archiveCtrl.selectType(type: 0),
                //           ),
                //           buildSizeHeight(60),
                //           workoutTypeCard(
                //               selectedImage: BaseAssets.pullSelect,
                //               unSelectedImage: BaseAssets.pullUnselect,
                //               title: "Pull",
                //               isSelected: archiveCtrl.workoutType.value == 1,
                //               onPressed: () => archiveCtrl.selectType(type: 1),
                //           ),
                //         ],
                //       );
                //     }),
                //   ),
                // ),
                GetBuilder<ArchiveController>(
                  builder: (logic) {
                    return Visibility(
                      visible: logic.selectedIndex != null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: horizontalScreenPadding,
                        ),
                        child: BaseButton(
                          title: 'Start Workout',
                          btnTextColor: BaseColors.white,
                          btnFontWeight: FontWeight.w600,
                          fontSize: 18,
                          borderRadius: 15,
                          btnColor: BaseColors.primaryColor,
                          onPressed: () {
                            Get.to(() {
                              return StartWorkout(
                                workoutTitle: archiveCtrl
                                        .planWorkoutDataList[
                                            archiveCtrl.selectedIndex!]
                                        .name ??
                                    '',
                                workoutId: archiveCtrl
                                        .planWorkoutDataList[
                                            archiveCtrl.selectedIndex!]
                                        .id ??
                                    '',
                                workoutNote: archiveCtrl
                                        .planWorkoutDataList[
                                            archiveCtrl.selectedIndex!]
                                        .note ??
                                    '',
                              );
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                buildSizeHeight(40),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget workoutTypeCard({
    required String unSelectedImage,
    required String title,
    required bool isSelected,
    Function()? onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        triggerHapticFeedback();
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Column(
        children: [
          ClipOval(
            child: Container(
              width: 120,
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: BaseColors.primaryColor, width: 2)
                    : null,
              ),
              child: Container(
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.network(
                  unSelectedImage,
                  // fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? BaseColors.secondaryColor
                        : BaseColors.black,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          buildSizeHeight(12),
          BaseText(
            value: title,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }

/* Widget workoutTypeCard({
    required String selectedImage,
    required String unSelectedImage,
    required String title,
    required bool isSelected,
    Function()? onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        triggerHapticFeedback();
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(isSelected ? selectedImage : unSelectedImage),
          buildSizeHeight(12),
          BaseText(
            value: title,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }*/
}
