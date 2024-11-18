import 'package:fitness_metrics/ui/athlete/workout_questions/controller/workout_feedback_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutQuestions extends StatefulWidget {
  const WorkoutQuestions({super.key});

  @override
  State<WorkoutQuestions> createState() => _WorkoutQuestionsState();
}

class _WorkoutQuestionsState extends State<WorkoutQuestions> {
  var workoutFeedbackCtrl = Get.put(WorkoutFeedbackController());

  final List<Color> listColors = [
    const Color(0xffFE0000),
    const Color(0xffF58E10),
    const Color(0xffF58E10),
    const Color(0xffFBE56D),
    const Color(0xffFBE56D),
    const Color(0xffFBE56D),
    const Color(0xffC4D698),
    const Color(0xffC4D698),
    const Color(0xff96B2D7),
    const Color(0xff96B2D7),
    const Color(0xff96B2D7),
    const Color(0xff96B2D7),
  ];

  @override
  void initState() {
    super.initState();
    workoutFeedbackCtrl.questionnairesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'RPE Questionnaire',
          ),
          Expanded(
            child: Obx(() {
              return SingleChildScrollView(
                child: BaseColumn(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(30),
                    BaseText(
                      value: workoutFeedbackCtrl.question.value,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    buildSizeHeight(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        // reverse: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: workoutFeedbackCtrl.answersList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(1.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: workoutFeedbackCtrl
                                  .answersList[index].isSelected ??
                                  false
                                  ? Border.all(
                                color: BaseColors.primaryColor,
                                width: 1.5,
                              )
                                  : null,
                            ),
                            child: GestureDetector(
                              onTap: () =>
                                  workoutFeedbackCtrl.selectAnswer(
                                      index: index),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                decoration: BoxDecoration(
                                  color: listColors[index],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Row(
                                  children: [
                                    BaseText(
                                      value: '${index + 1}',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                    Expanded(
                                      child: BaseText(
                                        textAlign: TextAlign.center,
                                        value:
                                        '${workoutFeedbackCtrl
                                            .answersList[index].answer}',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            buildSizeHeight(10),
                      ),
                    ),
                    buildSizeHeight(30),
                    GetBuilder<WorkoutFeedbackController>(
                      builder: (logic) {
                      return Visibility(
                        visible: logic.selectedIndex != null,
                        child: BaseButton(
                          title: "Send",
                          borderRadius: 15,
                          fontSize: 18,
                          btnColor: BaseColors.primaryColor,
                          leftMargin: 30,
                          rightMargin: 30,
                          onPressed: () => logic.rpeQuestionsSubmit(),
                        ),
                      );
                    },
                    ),
                    buildSizeHeight(25),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
