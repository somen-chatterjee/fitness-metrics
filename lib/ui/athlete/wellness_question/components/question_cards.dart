import 'package:fitness_metrics/ui/athlete/wellness_question/controller/wellness_question_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionCards extends StatefulWidget {
  const QuestionCards({
    super.key,
    required this.index,
    required this.title,
  });

  final String title;
  final int index;

  @override
  State<QuestionCards> createState() => _QuestionCardsState();
}

class _QuestionCardsState extends State<QuestionCards> {
  final wellnessQuestionCtrl = Get.find<WellnessQuestionController>();

  final List<Color> listColors = [
    const Color(0xff6E4CA0),
    const Color(0xff4D73BA),
    const Color(0xff41B049),
    const Color(0xffF0EA0E),
    const Color(0xffFFC80B),
    const Color(0xffE37E31),
    const Color(0xffE92E25),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          value: widget.title,
          color: BaseColors.black1,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        buildSizeHeight(5),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              value: 'Very, very good',
              color: BaseColors.black1,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            BaseText(
              value: 'Very, very bad',
              color: BaseColors.black1,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 22,
          child: Obx(() {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                listColors.length,
                    (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          wellnessQuestionCtrl.setAnswer(widget.index, index),
                      child: Container(
                        padding: const EdgeInsets.all(1.5),
                        margin: EdgeInsets.only(
                            right: index == listColors.length - 1 ? 0 : 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: wellnessQuestionCtrl.answers[widget
                                .index] == index ? Border.all(
                              color: BaseColors.primaryColor,
                              width: 1,
                            ) : null),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: listColors[index],
                            borderRadius: BorderRadius.circular(2),
                            // border: Border.all(color: Color(0xff000000),width: 2,)
                          ),
                          child: BaseText(
                            value: "${index + 1}",
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          // ListView.builder(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: 7,
          //   itemBuilder: (context, index) {
          //     return ;
          //   },
          // ),
        ),
        buildSizeHeight(15),
      ],
    );
  }
}
