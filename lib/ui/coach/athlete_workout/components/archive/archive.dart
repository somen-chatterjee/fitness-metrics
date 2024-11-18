import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/archive/components/add_plan_sheet.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/components/archive/components/archive_cards.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/controller/coach_archive_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  late CoachArchiveController coachArchiveCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<CoachArchiveController>();
    coachArchiveCtrl = Get.put(CoachArchiveController());
    coachArchiveCtrl.planGet(page: 1);
    // workoutCtrl.currentPage = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return SmartRefresher(
              enablePullUp: coachArchiveCtrl.currentPage != coachArchiveCtrl.lastPage,
              controller: coachArchiveCtrl.refreshController,
              onLoading: () {
                if (coachArchiveCtrl.currentPage != coachArchiveCtrl.lastPage) {
                  coachArchiveCtrl.planGet(page: coachArchiveCtrl.currentPage += 1);
                }
              },
              onRefresh: () {
                coachArchiveCtrl.planGet(page: 1);
              },
              child: coachArchiveCtrl.planDataList.isNotEmpty
                  ? ListView.separated(
                itemCount: coachArchiveCtrl.planDataList.length,
                padding: EdgeInsets.zero,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return ArchiveCards(itemIndex: index);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    buildSizeHeight(12),
              )
                  : const BaseNoData(message: "No Plan Found!"),
            );
          }),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => _addPlanBottomSheet(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(BaseAssets.editNotes),
                  buildSizeWidth(10),
                  const BaseText(
                    value: 'New',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _addPlanBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return const AddPlanSheet();
      },
    );
  }
}
