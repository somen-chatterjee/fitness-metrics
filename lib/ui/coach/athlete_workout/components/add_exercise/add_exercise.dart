
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/add_exercise/components/exercise_cards.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/add_exercise/components/exercise_suggestion_cards.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/add_exercise/controller/add_exercise_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/add_exercise_library/add_exercise_library.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/set_preferences/set_preferences.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/models/coach_preference_model.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/models/exercises_model.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class AddExercise extends StatefulWidget {
  final Sections sectionData;

  const AddExercise({super.key, required this.sectionData});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  // var addExerciseCtrl = Get.put(AddExerciseController());
  var addExerciseCtrl = Get.find<AddExerciseController>();

  @override
  void initState() {
    super.initState();
    // addExerciseCtrl.getExerciseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          BaseAppBar(title: widget.sectionData.name),
          Expanded(
            child: BaseColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(20),
                const BaseText(
                  value: 'Exercise Library',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: BaseColors.black1,
                ),
                buildSizeHeight(10),
                GetBuilder<AddExerciseController>(builder: (logic) {
                  return TypeAheadField<ExerciseData>(
                    key: UniqueKey(),
                    suggestionsCallback: addExerciseCtrl.suggestionsCallback,
                    // hideOnUnfocus: false,
                    //   hideWithKeyboard: false,
                    builder: (context, controller, focusNode) {
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        autofocus: false,
                        decoration: InputDecoration(
                          // hintText: 'Search',
                          // hintStyle: const TextStyle(
                          //   fontWeight: FontWeight.w400,
                          //   fontSize: 14,
                          // ),
                          labelText: 'Search',
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: SvgPicture.asset(BaseAssets.search),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: BaseColors.textFilledBorder, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: BaseColors.textFilledBorder, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          controller.clear();

                        },
                      );
                    },
                    itemBuilder: (context, value) {
                      return ExerciseSuggestionCards(
                        exerciseData: value,
                        sectionId: widget.sectionData.id?.toString() ?? '',
                      );
                    },
                    // itemSeparatorBuilder: (context, value) {
                    //   return buildSizeHeight(5);
                    // },
                    onSelected: (city) {
                      return;
                      // Navigator.of(context).push<void>(
                      //   MaterialPageRoute(
                      //     builder: (context) => CityPage(city: city),
                      //   ),
                      // );
                    },
                  );
                }),
                buildSizeHeight(20),
                Expanded(
                  child: Obx(() {
                    return addExerciseCtrl.exerciseDisplayList.isNotEmpty
                        ? ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount:
                                addExerciseCtrl.exerciseDisplayList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ExerciseCards(
                                itemIndex: index,
                                exerciseFor: widget.sectionData.name,
                                sectionId: widget.sectionData.id.toString(),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return buildSizeHeight(10);
                            },
                          )
                        : const BaseNoData(
                            message: "No Exercises Found!",
                          );
                  }),
                ),
                buildSizeHeight(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => Get.to(() => const SetPreferences())
                          ?.then((val) async {
                        await addExerciseCtrl.getExerciseList();
                        await addExerciseCtrl.sectionExerciseList(
                          sectionId: widget.sectionData.id?.toString() ?? '',
                        );
                      }),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(BaseAssets.addRound),
                          buildSizeWidth(10),
                          const BaseText(
                            value: 'Preferences',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => Get.to(() => const AddExerciseLibrary())
                          ?.then((val) async {
                        await addExerciseCtrl.getExerciseList();
                        await addExerciseCtrl.sectionExerciseList(
                          sectionId: widget.sectionData.id?.toString() ?? '',
                        );
                      }),
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
                  ],
                ),
                // buildSizeHeight(10),
                // BaseButton(
                //   title: 'Continue',
                //   btnHeight: 45,
                //   leftMargin: 20,
                //   rightMargin: 20,
                //   onPressed: () {
                //     // Get.back(),
                //     // addExerciseCtrl.coachSectionExerciseCreate(
                //     //     sectionId: widget.sectionData.id?.toString() ?? '',
                //     // );
                //   },
                // ),
                buildSizeHeight(30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
