import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/controllers/create_workout_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectIconsDialog extends StatefulWidget {
  const SelectIconsDialog({super.key});

  @override
  State<SelectIconsDialog> createState() => _SelectIconsDialogState();
}

class _SelectIconsDialogState extends State<SelectIconsDialog> {
  var createWorkoutCtrl = Get.find<CreateWorkoutController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BaseText(
                  value: 'Workout Icons',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  color: BaseColors.black1,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(BaseAssets.cancel),
                ),
              ],
            ),
          ),
          const Divider(color: BaseColors.grey),
          Expanded(
            child: Obx(() {
              return GridView.builder(
                // shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemCount: createWorkoutCtrl.workoutIconsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return workoutTypeCard(
                    unSelectedImage:
                        createWorkoutCtrl.workoutIconsList[index].icon ?? "",
                    title: createWorkoutCtrl.workoutIconsList[index].name ?? "",
                    isSelected:
                        createWorkoutCtrl.workoutIconsList[index].isSelected ??
                            false,
                    onPressed: () =>
                        createWorkoutCtrl.selectWorkout(index: index),
                  );
                },
              );
            }),
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
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: BaseColors.primaryColor, width: 2)
                    : null,
              ),
              child: Container(
                // clipBehavior: Clip.hardEdge,
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: unSelectedImage.contains(".svg")
                    ? SvgPicture.network(
                        unSelectedImage,
                        // fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? BaseColors.secondaryColor
                              : BaseColors.black,
                          BlendMode.srcIn,
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: unSelectedImage,
                        // fit: BoxFit.contain,
                        color: isSelected
                            ? BaseColors.secondaryColor
                            : BaseColors.black,
                      ),
              ),
            ),
          ),
          buildSizeHeight(8),
          BaseText(
            value: title,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
