import 'package:fitness_metrics/ui/athlete/workout/components/archive/components/archive_cards.dart';
import 'package:fitness_metrics/ui/athlete/workout/controller/workout_controller.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  var workoutCtrl = Get.find<WorkoutController>();

  @override
  void initState() {
    super.initState();
    workoutCtrl.planGet(page: 1);
    // workoutCtrl.currentPage = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SmartRefresher(
        enablePullUp: workoutCtrl.currentPage != workoutCtrl.lastPage,
        controller: workoutCtrl.refreshController,
        onLoading: () {
          if (workoutCtrl.currentPage != workoutCtrl.lastPage) {
            workoutCtrl.planGet(page: workoutCtrl.currentPage += 1);
          }
        },
        onRefresh: () {
          workoutCtrl.planGet(page: 1);
        },
        child: workoutCtrl.planDataList.isNotEmpty
            ? ListView.separated(
                itemCount: workoutCtrl.planDataList.length,
                padding: EdgeInsets.zero,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return ArchiveCards(itemIndex: index);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    buildSizeHeight(12),
              )
            : const BaseNoData(message: "No Plans Found!"),
      );
    });
  }
}
