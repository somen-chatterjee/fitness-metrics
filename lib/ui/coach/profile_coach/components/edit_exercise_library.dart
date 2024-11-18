import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/controller/exercise_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditExerciseLibrary extends StatefulWidget {
  const EditExerciseLibrary({super.key});

  @override
  State<EditExerciseLibrary> createState() => _EditExerciseLibraryState();
}

class _EditExerciseLibraryState extends State<EditExerciseLibrary> {
  var exerciseCtrl = Get.find<ExerciseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          BaseAppBar(title: exerciseCtrl.editData.value.name ?? ""),
          Expanded(
            child: BaseColumn(
              children: [
                buildSizeHeight(20),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  decoration: BoxDecoration(
                    color: BaseColors.yellowGreen,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSizeHeight(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BaseText(
                              value: exerciseCtrl.editData.value.name ?? "",
                              color: BaseColors.black1,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            // SvgPicture.asset(BaseAssets.menu),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: BaseColors.grey3.withOpacity(.2),
                      ),
                      Form(
                        key: exerciseCtrl.exerciseEditFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const BaseText(
                                value: 'Video URL',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller:
                                      exerciseCtrl.videoUrlEditController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Video Url",
                                    hintStyle:
                                        TextStyle(color: BaseColors.grey1),
                                  ),
                                  validator: (value) {
                                    if ((value ?? "").isEmpty) {
                                      return "Please Enter The Video Url";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              buildSizeHeight(20),
                              const BaseText(
                                value: 'Notes',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              buildSizeHeight(10),

                              TextFormField(
                                controller: exerciseCtrl.notesEditController,
                                maxLines: 4,
                                decoration: const InputDecoration(
                                  hintText: "Enter Notes",
                                  hintStyle: TextStyle(color: BaseColors.grey1),
                                ),
                                validator: (value) {
                                  if ((value ?? "").isEmpty) {
                                    return "Please Enter The Notes";
                                  }
                                  return null;
                                },
                              ),

                              // const BaseText(
                              //   value:
                              //       'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
                              //   fontWeight: FontWeight.w400,
                              //   fontSize: 14,
                              // ),
                            ],
                          ),
                        ),
                      ),
                      buildSizeHeight(10),
                    ],
                  ),
                ),
                buildSizeHeight(30),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(BaseAssets.addRound),
                      buildSizeWidth(10),
                      const BaseText(
                        value: 'Add',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if (exerciseCtrl.exerciseEditFormKey.currentState!
                        .validate()) {
                      exerciseCtrl.exerciseUpdate(
                        exerciseId: exerciseCtrl.editData.value.id ?? "",
                        name: exerciseCtrl.editData.value.name ?? "",
                      );
                    }
                  },
                  // onTap: () => Get.to(() => const ExerciseLibrarySettings()),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(BaseAssets.save),
                      buildSizeWidth(10),
                      const BaseText(
                        value: 'Save',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
