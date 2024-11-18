import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/components/athlete_view_measurement.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/components/athlete_view_progress_photo.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/components/athlete_view_weight.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/controller/coach_athlete_evaluation_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodyComposition extends StatefulWidget {
  const BodyComposition({super.key});

  @override
  State<BodyComposition> createState() => _BodyCompositionState();
}

class _BodyCompositionState extends State<BodyComposition> {
  late CoachAthleteEvaluationController evaluationCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<CoachAthleteEvaluationController>();
    evaluationCtrl = Get.put(CoachAthleteEvaluationController());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: BaseText(
                value: 'Body Composition',
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Obx(() {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: BaseColors.yellowGreen,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 40,
                child: PopupMenuButton<String>(
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) {
                    return evaluationCtrl.compositionList.map((str) {
                      return PopupMenuItem(
                        value: str,
                        child: BaseText(
                          value: str,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      );
                    }).toList();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      BaseText(
                        value: evaluationCtrl.compositionType.value,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: BaseColors.black1,
                      ),
                    ],
                  ),
                  onSelected: (v) {
                    evaluationCtrl.compositionType.value = v;
                  },
                ),
              );
            }),
          ],
        ),
        buildSizeHeight(25),
        Obx(() {
          return SizedBox(
            // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            // decoration: BoxDecoration(
            //   color: evaluationCtrl.compositionType.value != 'Progress Photo'
            //       ? Colors.white
            //       : Colors.transparent,
            //   borderRadius: const BorderRadius.all(Radius.circular(10)),
            // ),
            height: 330,
            child: selectCompositionType(
                compositionType: evaluationCtrl.compositionType.value),
          );
        }),
      ],
    );
  }

  Widget selectCompositionType({required String compositionType}) {
    if (compositionType == 'Weight') {
      return const Weight();
    } else if (compositionType == 'Measurement') {
      return const Measurement();
    } else if (compositionType == 'Progress Photo') {
      return const ProgressPhoto();
    }
    return const SizedBox();
  }
}
