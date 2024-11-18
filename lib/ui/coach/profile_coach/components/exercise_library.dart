import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/small_components/create_exercise_sheet.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/small_components/exercise_library_cards.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/controller/exercise_controller.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExerciseLibrary extends StatefulWidget {
  const ExerciseLibrary({super.key});

  @override
  State<ExerciseLibrary> createState() => _ExerciseLibraryState();
}

class _ExerciseLibraryState extends State<ExerciseLibrary> {
  late ExerciseController exerciseCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<ExerciseController>();
    exerciseCtrl = Get.put(ExerciseController());
    exerciseCtrl.getExerciseList(searchKey: "", page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return SmartRefresher(
              controller: exerciseCtrl.refreshController,
              // enablePullUp: exerciseCtrl.currentPage != exerciseCtrl.lastPage,
              // onLoading: () {
              //   if (exerciseCtrl.currentPage != exerciseCtrl.lastPage) {
              //     exerciseCtrl.getExerciseList(
              //       searchKey: "",
              //       page: exerciseCtrl.currentPage += 1,
              //     );
              //   }
              // },
              onRefresh: () {
                exerciseCtrl.getExerciseList(searchKey: "", page: 1);
                exerciseCtrl.refreshController.refreshCompleted();
              },
              child: exerciseCtrl.exerciseList.isNotEmpty
                  ? ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return ExerciseLibraryCards(
                          itemIndex: index,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return buildSizeHeight(10);
                      },
                      itemCount: exerciseCtrl.exerciseList.length,
                    )
                  : const BaseNoData(message: "No Exercises Found!"),
            );
          }),
        ),
        buildSizeHeight(20),
        BaseButton(
          title: 'Create Exercise',
          btnHeight: 45,
          leftMargin: 20,
          rightMargin: 20,
          onPressed: () => _createExerciseBottomSheet(context),
        ),
        buildSizeHeight(10),
      ],
    );
  }

  void _createExerciseBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return const CreateExerciseSheet();
      },
    );
  }
}
