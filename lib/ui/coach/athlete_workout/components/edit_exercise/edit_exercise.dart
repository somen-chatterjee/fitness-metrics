import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/edit_exercise/components/create_block_note_sheet.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/edit_exercise/components/dynamic_edit_field.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/edit_exercise/components/dynamic_view_field.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/edit_exercise/controllers/edit_workout_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditExercise extends StatefulWidget {
  final String exerciseTitle;
  final String exerciseId;
  final String sectionId;

  const EditExercise(
      {super.key,
      required this.exerciseTitle,
      required this.sectionId,
      required this.exerciseId});

  @override
  State<EditExercise> createState() => _EditExerciseState();
}

class _EditExerciseState extends State<EditExercise> {
  var editWorkoutCtrl = Get.put(EditWorkoutController());

  @override
  void initState() {
    super.initState();
    editWorkoutCtrl.exerciseView(
      sectionId: widget.sectionId,
      exerciseId: widget.exerciseId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          BaseAppBar(title: widget.exerciseTitle),
          Expanded(
            child: SingleChildScrollView(
              child: BaseColumn(
                children: [
                  buildSizeHeight(20),
                  Obx(() {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 0),
                      decoration: BoxDecoration(
                        color: BaseColors.yellowGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Form(
                        key: editWorkoutCtrl.exerciseFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildSizeHeight(10),
                            // pop-menu button
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BaseText(
                                    value: widget.exerciseTitle,
                                    color: BaseColors.black1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                  SizedBox(
                                    height: 25,
                                    width: 12,
                                    child: PopupMenuButton(
                                      key: UniqueKey(),
                                      offset: const Offset(0, 2),
                                      position: PopupMenuPosition.under,
                                      constraints:
                                          const BoxConstraints.tightFor(
                                        width: 80,
                                        // height: 200,
                                      ),
                                      icon: SvgPicture.asset(BaseAssets.menu),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            height: 25,
                                            onTap: () {
                                              // Get.toNamed(RouteName.wardRodeListScreen);
                                              if (editWorkoutCtrl
                                                  .isEdit.value) {
                                                if (editWorkoutCtrl
                                                    .exerciseFormKey
                                                    .currentState!
                                                    .validate()) {
                                                  editWorkoutCtrl.exerciseRules(
                                                    sectionId: widget.sectionId,
                                                    exerciseId:
                                                        widget.exerciseId,
                                                  );
                                                }
                                              }

                                              editWorkoutCtrl.isEdit.value =
                                                  !editWorkoutCtrl.isEdit.value;
                                            },
                                            value: editWorkoutCtrl.isEdit.value
                                                ? 'Save'
                                                : 'Edit',
                                            child: BaseText(
                                              value:
                                                  editWorkoutCtrl.isEdit.value
                                                      ? 'Save'
                                                      : 'Edit',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          PopupMenuItem(
                                            height: 25,
                                            onTap: () {
                                              // Get.toNamed(RouteName.scheduleOutfit);
                                              editWorkoutCtrl
                                                  .coachSectionExerciseDelete(
                                                sectionId: widget.sectionId,
                                                exerciseId: widget.exerciseId,
                                              );
                                            },
                                            value: 'Delete',
                                            child: const BaseText(
                                              value: 'Delete',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                          PopupMenuItem(
                                            height: 25,
                                            onTap: () {
                                              // Get.toNamed(RouteName.settingScreen);
                                              // Get.to(const SettingScreen());
                                            },
                                            value: 'Copy',
                                            child: const BaseText(
                                              value: 'Copy',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ];
                                      },
                                      onSelected: (String value) {
                                        // log('You Click on po up menu item');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: BaseColors.grey3.withOpacity(.2),
                            ),
                            Flexible(
                              child: editWorkoutCtrl.isEdit.value
                                  ? const DynamicEditField()
                                  : const DynamicViewField(),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16),
                              child: editWorkoutCtrl.isEdit.value
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        buildSizeHeight(12),
                                        const BaseText(
                                          value: 'Video URL',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: BaseColors.black1,
                                        ),
                                        SizedBox(
                                          height: 52,
                                          child: TextFormField(
                                            controller: editWorkoutCtrl
                                                .videoTextController,
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 0,
                                              ),
                                            ),
                                            validator: (val) {
                                              final RegExp youtubeRegex =
                                                  RegExp(
                                                r'^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$',
                                                caseSensitive: false,
                                              );

                                              if (val!.isEmpty) {
                                                return "* Required";
                                              }

                                              if (!youtubeRegex.hasMatch(val)) {
                                                return "Enter Valid Youtube Url";
                                              }

                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            editWorkoutCtrl.isEdit.value =
                                                !editWorkoutCtrl.isEdit.value;
                                          },
                                          child: SvgPicture.asset(
                                            BaseAssets.editPencil,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Get.to(()=>const VideoPlayerScreen());
                                            Get.find<CommonController>().showYoutubePlayer(
                                              context: context,
                                              videoUrl: editWorkoutCtrl
                                                  .videoUrl.value,
                                            );
                                          },
                                          child: SvgPicture.asset(
                                              BaseAssets.playVideo,
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                            buildSizeHeight(10),
                          ],
                        ),
                      ),
                    );
                  }),
                  buildSizeHeight(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => _addBlockNoteBottomSheet(
                          context,
                          widget.exerciseId,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SvgPicture.asset(BaseAssets.editNotes),
                            buildSizeWidth(5),
                            const BaseText(
                              value: 'Block Notes',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: BaseColors.black1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildSizeHeight(30),
                  // BaseButton(
                  //   title: 'Continue',
                  //   btnHeight: 45,
                  //   leftMargin: 20,
                  //   rightMargin: 20,
                  //   onPressed: () => Get.back(),
                  // ),
                  // buildSizeHeight(30),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // InkWell(
                //   splashColor: Colors.transparent,
                //   highlightColor: Colors.transparent,
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       SvgPicture.asset(BaseAssets.addRound),
                //       buildSizeWidth(10),
                //       const BaseText(
                //         value: 'Add',
                //         fontWeight: FontWeight.w400,
                //         fontSize: 18,
                //       ),
                //     ],
                //   ),
                // ),
                const Spacer(),
                Obx(() {
                  return Visibility(
                    visible: editWorkoutCtrl.isEdit.value,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (editWorkoutCtrl.exerciseFormKey.currentState!
                            .validate()) {
                          editWorkoutCtrl.exerciseRules(
                            sectionId: widget.sectionId,
                            exerciseId: widget.exerciseId,
                          );
                        }
                      },
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
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addBlockNoteBottomSheet(BuildContext context, String exerciseId) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return CreateBlockNoteSheet(exerciseId: exerciseId);
      },
    );
  }
}
