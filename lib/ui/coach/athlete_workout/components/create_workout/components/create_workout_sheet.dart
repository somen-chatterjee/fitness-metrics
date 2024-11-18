import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/create_workout/controllers/create_workout_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateWorkoutSheet extends StatefulWidget {
  final String planId;

  const CreateWorkoutSheet({super.key, required this.planId});

  @override
  State<CreateWorkoutSheet> createState() => _CreateWorkoutSheetState();
}

class _CreateWorkoutSheetState extends State<CreateWorkoutSheet> {
  var createWorkoutCtrl = Get.find<CreateWorkoutController>();

  @override
  void initState() {
    super.initState();
    createWorkoutCtrl.workoutName.clear();
    createWorkoutCtrl.workoutIcon.clear();
  }

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
              child: SingleChildScrollView(
                child: Form(
                  key: createWorkoutCtrl.createWorkoutFormKey,
                  child: BaseColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            value: 'Create Workout',
                            color: BaseColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      buildSizeHeight(30),
                      //workout name
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseText(
                            value: 'Select Icon',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          BaseTextField(
                            controller: createWorkoutCtrl.workoutIcon,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.sentences,
                            labelText: '',
                            readOnly: true,
                            hintText: 'Select icon for workout',
                            hintTextColor: BaseColors.grey,
                            borderColor: BaseColors.textFilledBorder,
                            prefixIcon: Obx(() {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Visibility(
                                  visible: createWorkoutCtrl
                                      .selectedIcon.value.isNotEmpty,
                                  child: SvgPicture.network(
                                    createWorkoutCtrl.selectedIcon.value,
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                              );
                            }),
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SvgPicture.asset(BaseAssets.upload),
                            ),
                            fillColor: BaseColors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 17.0,
                            ),
                            borderRadius: 15,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "* Required";
                              }
                              return null;
                            },
                            onTap: () {
                              createWorkoutCtrl.showIcons(context: context);
                            },
                          ),
                          buildSizeHeight(10),
                          const BaseText(
                            value: 'Workout Name',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          BaseTextField(
                            controller: createWorkoutCtrl.workoutName,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.sentences,
                            labelText: '',
                            hintText: 'Workout Name',
                            hintTextColor: BaseColors.grey,
                            borderColor: BaseColors.textFilledBorder,
                            fillColor: BaseColors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 17.0,
                            ),
                            borderRadius: 15,
                            validator: (val) {
                              if (val!.trim().isEmpty) {
                                return "Please Enter Workout Name";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      buildSizeHeight(30),
                      BaseButton(
                        title: 'Create',
                        btnHeight: 45,
                        leftMargin: 20,
                        rightMargin: 20,
                        onPressed: () {
                          if (createWorkoutCtrl
                              .createWorkoutFormKey.currentState!
                              .validate()) {
                            createWorkoutCtrl.workoutCreate(
                                planId: widget.planId);
                          }
                        },
                      ),
                      buildSizeHeight(20),
                    ],
                  ),
                ),
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
