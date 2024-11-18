import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/components/progress_view_photo_card.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/controller/progress_photo_view_controller.dart';
import 'package:fitness_metrics/ui/common_ui/upload_progress_photo.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProgressPhoto extends StatefulWidget {
  const ProgressPhoto({super.key});

  @override
  State<ProgressPhoto> createState() => _ProgressPhotoState();
}

class _ProgressPhotoState extends State<ProgressPhoto> {
  late ProgressPhotoViewController evalCtrl;

  final PageController _scrollController = PageController();

  @override
  void initState() {
    super.initState();
    Get.delete<ProgressPhotoViewController>();
    evalCtrl = Get.put(ProgressPhotoViewController());

    evalCtrl.progressImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            value:
            'Last Update on ${evalCtrl.currentDate.value}',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: BaseColors.grey3,
          ),

          Align(
            alignment: Alignment.centerRight,
            child: BaseText(
              value:
              '${(evalCtrl.pageIndex.value + 1).toString().padLeft(2)}/${evalCtrl.imageList.length}',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: BaseColors.grey3,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 170,
            child: Row(
              children: [
                InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      _scrollController.previousPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeIn,
                      );
                    },
                    child: SvgPicture.asset(BaseAssets.leftIndicator)),
                buildSizeWidth(5),
                Expanded(
                  child: PageView.builder(
                    controller: _scrollController,
                    // physics: const NeverScrollableScrollPhysics(),
                    // padding: EdgeInsets.zero,
                    itemCount: evalCtrl.imageList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ProgressPhotoCard(index: index);
                    },
                    onPageChanged: (value) {
                      evalCtrl.pageIndex.value = value;
                      evalCtrl.getCurrentData();
                    },

                    // separatorBuilder: (BuildContext context, int index) =>
                    //     buildSizeWidth(6),
                  ),
                ),
                buildSizeWidth(5),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    _scrollController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                    );
                  },
                  child: SvgPicture.asset(BaseAssets.rightIndicator),
                ),
              ],
            ),
          ),
          buildSizeHeight(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async{
                  var ctrl = Get.find<AthleteDataController>();

                  Get.to(() => UploadProgressPhoto(athleteId: ctrl.athleteData.value.userId ?? ""));
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      BaseAssets.uploadPhoto,
                      width: 21,
                      height: 21,
                    ),
                    buildSizeWidth(10),
                    const BaseText(
                      value: 'Add New Photo',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: BaseColors.grey3,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
