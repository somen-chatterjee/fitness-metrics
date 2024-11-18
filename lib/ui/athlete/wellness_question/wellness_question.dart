import 'package:fitness_metrics/ui/athlete/wellness_question/components/question_cards.dart';
import 'package:fitness_metrics/ui/athlete/wellness_question/controller/wellness_question_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WellnessQuestion extends StatefulWidget {
  const WellnessQuestion({super.key});

  @override
  State<WellnessQuestion> createState() => _WellnessQuestionState();
}

class _WellnessQuestionState extends State<WellnessQuestion> {
  final wellnessQuestionCtrl = Get.put(WellnessQuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const BaseAppBar(
          title: 'Wellness Questionnaire',
        ),
        Expanded(
          child: BaseColumn(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSizeHeight(25),
              const BaseText(
                value: 'Tell me about your wellness today.',
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              buildSizeHeight(10),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: wellnessQuestionCtrl.title.length,
                  itemBuilder: (context, index) {
                    return QuestionCards(
                      index: index,
                      title: wellnessQuestionCtrl.title[index],
                    );
                  },
                ),
              ),
              buildSizeHeight(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: BaseButton(
                  btnHeight: 45,
                  title: "Send",
                  borderRadius: 15,
                  onPressed: () => wellnessQuestionCtrl.wellnessQuestionnaireCreate(),
                ),
              ),
              buildSizeHeight(25),
            ],
          ),
        )
      ]),
    );
  }
}
