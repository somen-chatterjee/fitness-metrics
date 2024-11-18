
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/edit_exercise/controllers/edit_workout_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/edit_exercise/models/exercise_view_model.dart';

class DynamicEditField extends StatefulWidget {
  const DynamicEditField({super.key});

  @override
  State<DynamicEditField> createState() => _DynamicEditFieldState();
}

class _DynamicEditFieldState extends State<DynamicEditField> {
  var editWorkoutCtrl = Get.find<EditWorkoutController>();

  @override
  void initState() {
    super.initState();
    editWorkoutCtrl.setInitEditData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 16,
        ),
        child: Obx(() {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: editWorkoutCtrl.rulesEditList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var rules = editWorkoutCtrl.rulesEditList[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BaseText(
                    value: rules.training ?? "",
                    color: BaseColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  SizedBox(
                    width: 80,
                    height: 52,
                    child: TextFormField(
                      // key: UniqueKey(),
                      controller: rules.valueCtrl,
                      keyboardType: editWorkoutCtrl.setInputType(rules: rules),
                      inputFormatters: editWorkoutCtrl.setInputFormatter(rules: rules),
                      maxLength: editWorkoutCtrl.setMaxLength(rules: rules),

                      decoration: const InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                      ),
                      onChanged: (val) {
                        // Check if the current field is for "Sets" (trainingId == "1")
                        if (rules.trainingId.toString() == "1") {
                          editWorkoutCtrl.handleRepChange(onChangeVal: val);
                        }

                        if (rules.trainingId.toString() == "1" && editWorkoutCtrl.load.value) {
                          editWorkoutCtrl.handleLoadChange(val);
                        }
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              );
            },
          );
        }),

        /*Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: editWorkoutCtrl.rulesList.toSet().map<Widget>((entry) {
            return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
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
                    SizedBox(
                      width: 80,
                      height: 52,
                      child: TextFormField(
                        controller: entry.valueCtrl,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
            );
          }).toList(),
        );
      }),*/
        );
  }

  Widget checkLoad({required Rules rules, required int itemIndex}) {
    //"training_id":"2" => rep
    // "training_id":"5","training":"Load"
    return Column(
      children: [
        Column(
          children: List.generate(
            3,
            (index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BaseText(
                    value: index.toString(),
                    color: BaseColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  SizedBox(
                    width: 80,
                    height: 52,
                    child: TextFormField(
                      controller: rules.valueCtrl,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BaseText(
              value: rules.training ?? "",
              color: BaseColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            SizedBox(
              width: 80,
              height: 52,
              child: TextFormField(
                controller: rules.valueCtrl,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 0,
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "* Required";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );

    // return SizedBox();
  }
}
