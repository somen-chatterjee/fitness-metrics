import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/controller/exercise_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateExerciseSheet extends StatefulWidget {
  const CreateExerciseSheet({super.key});

  @override
  State<CreateExerciseSheet> createState() => _CreateExerciseSheetState();
}

class _CreateExerciseSheetState extends State<CreateExerciseSheet> {
  var exerciseCtrl = Get.find<ExerciseController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      exerciseCtrl.clearController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: exerciseCtrl.exerciseCreateFormKey,
      child: Padding(
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
                  child: BaseColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            value: 'Create Exercise',
                            color: BaseColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      buildSizeHeight(30),
                      //Exercise Name
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseText(
                            value: 'Exercise Name',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          buildSizeHeight(8),
                          BaseTextField(
                            controller: exerciseCtrl.nameController,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.sentences,
                            labelText: '',
                            hintText: 'Exercise Name',
                            hintTextColor: BaseColors.grey,
                            borderColor: BaseColors.textFilledBorder,
                            fillColor: BaseColors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 17.0,
                            ),
                            borderRadius: 15,
                            validator: (val) {
                              if (exerciseCtrl.nameController.value.text
                                  .trim()
                                  .isEmpty) {
                                return "Please Enter Exercise Name";
                              }
                              return null;
                            },
                          ),
                          buildSizeHeight(10),
                        ],
                      ),
                      //Video URL
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseText(
                            value: 'Video URL',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          buildSizeHeight(8),
                          BaseTextField(
                            controller: exerciseCtrl.videoUrlController,
                            textInputType: TextInputType.text,
                            // textCapitalization: TextCapitalization.sentences,
                            labelText: '',
                            hintText: 'https://',
                            hintTextColor: BaseColors.grey,
                            borderColor: BaseColors.textFilledBorder,
                            fillColor: BaseColors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 17.0,
                            ),
                            borderRadius: 15,
                            validator: (val) {
                              final RegExp youtubeRegex = RegExp(
                                r'^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$',
                                caseSensitive: false,
                              );

                              if (exerciseCtrl.videoUrlController.value.text
                                  .trim()
                                  .isEmpty) {
                                return "Please Enter Video Url";
                              }

                              if(!youtubeRegex.hasMatch(val!)) {
                                return "Enter A Valid YouTube URL";
                              }
                              return null;
                            },
                          ),
                          buildSizeHeight(10),
                        ],
                      ),
                      //Notes
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseText(
                            value: 'Notes',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          buildSizeHeight(8),
                          BaseTextField(
                            controller: exerciseCtrl.noteController,
                            textInputType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            labelText: '',
                            hintText: '',
                            maxLine: 2,
                            hintTextColor: BaseColors.grey,
                            borderColor: BaseColors.textFilledBorder,
                            fillColor: BaseColors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 17.0,
                            ),
                            borderRadius: 15,
                            validator: (val) {
                              if (exerciseCtrl.noteController.value.text
                                  .trim()
                                  .isEmpty) {
                                return "Please Enter Your Notes";
                              }
                              return null;
                            },
                          ),
                          buildSizeHeight(10),
                        ],
                      ),
                      BaseButton(
                        title: 'Create',
                        btnHeight: 45,
                        leftMargin: 20,
                        rightMargin: 20,
                        onPressed: () {
                          if(exerciseCtrl.exerciseCreateFormKey.currentState!.validate()) {
                            exerciseCtrl.exerciseCreate();
                          }
                        },
                      ),
                    ],
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
      ),
    );
  }
}
