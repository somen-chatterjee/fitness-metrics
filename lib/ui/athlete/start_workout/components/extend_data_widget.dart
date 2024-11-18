import 'package:fitness_metrics/ui/athlete/start_workout/controller/start_workout_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExtendDataWidget extends StatefulWidget {
  final int itemIndex;

  const ExtendDataWidget({super.key, required this.itemIndex});

  @override
  State<ExtendDataWidget> createState() => _ExtendDataWidgetState();
}

class _ExtendDataWidgetState extends State<ExtendDataWidget> {
  var startWorkoutCtrl = Get.find<StartWorkoutController>();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: startWorkoutCtrl.visibleFAQ.value == widget.itemIndex,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            (startWorkoutCtrl.workoutDataList[widget.itemIndex].exercise ?? [])
                .length,
        itemBuilder: (context, dIndex) {
          if ((startWorkoutCtrl.workoutDataList[widget.itemIndex].exercise ??
                  [])
              .isNotEmpty) {
            var exerciseList =
                startWorkoutCtrl.workoutDataList[widget.itemIndex].exercise!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 1,
                  color: BaseColors.grey3.withOpacity(.2),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        value: exerciseList[dIndex].exercise ?? '',
                        // Removed overflow: TextOverflow.ellipsis to show all text
                        color: BaseColors.black1,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      buildSizeWidth(5),
                      Expanded(
                        child: Wrap(
                          spacing: 5.0, // gap between adjacent chips
                          runSpacing: 2.0, // gap between lines
                          children: List.generate(
                            (exerciseList[dIndex].rules ?? []).length,
                            (index) {
                              var rulesList =
                                  (exerciseList[dIndex].rules ?? []);
                              return BaseText(
                                value:
                                    "${rulesList[index].name ?? ''}- ${rulesList[index].value ?? ''},",
                                // Removed overflow: TextOverflow.ellipsis to show all text
                                color: BaseColors.grey3,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
