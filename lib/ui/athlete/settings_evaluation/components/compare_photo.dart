import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/controller/progress_photo_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ComparePhoto extends StatefulWidget {
  final String title;
  final int itemIndex;

  const ComparePhoto({
    super.key,
    required this.title,
    required this.itemIndex,
  });

  @override
  State<ComparePhoto> createState() => _ComparePhotoState();
}

class _ComparePhotoState extends State<ComparePhoto> {
  var evalCtrl = Get.find<ProgressPhotoController>();

  final PageController _firstScrollCtrl = PageController();
  final PageController _secondScrollCtrl = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _firstScrollCtrl.animateToPage(
        widget.itemIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );

      _secondScrollCtrl.animateToPage(
        widget.itemIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );

      evalCtrl.getFirstData(itemIndex: widget.itemIndex);
      evalCtrl.getSecondData(itemIndex: widget.itemIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Evaluation',
          ),
          buildSizeHeight(30),
          SingleChildScrollView(
            child: BaseColumn(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BaseText(
                    value: widget.title,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildSizeHeight(10),
                      BaseText(
                        value: evalCtrl.firstDate.value,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: BaseColors.grey3,
                      ),
                      buildSizeHeight(10),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                _firstScrollCtrl.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: SvgPicture.asset(
                                BaseAssets.leftIndicator,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            buildSizeWidth(5),
                            Container(
                              width: 176,
                              height: 208,
                              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: BaseColors.grey5.withOpacity(0.3)),
                              ),
                              child: PageView.builder(
                                controller: _firstScrollCtrl,
                                // physics: const NeverScrollableScrollPhysics(),
                                // padding: EdgeInsets.zero,
                                itemCount: evalCtrl.imageList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CachedNetworkImage(
                                    imageUrl: evalCtrl.setImage(
                                      index: evalCtrl.firstImageIndex.value,
                                      title: widget.title,
                                    ),
                                    width: 83,
                                    height: 83,
                                    errorWidget: (context, url, error) => errorWidget(),
                                  );
                                },
                                onPageChanged: (value) {
                                  evalCtrl.getFirstData(itemIndex: value);
                                },
                              ),
                            ),
                            buildSizeWidth(5),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                _firstScrollCtrl.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: SvgPicture.asset(
                                BaseAssets.rightIndicator,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                buildSizeHeight(20),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildSizeHeight(10),
                      BaseText(
                        value: evalCtrl.secondDate.value,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: BaseColors.grey3,
                      ),
                      buildSizeHeight(10),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                _secondScrollCtrl.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: SvgPicture.asset(
                                BaseAssets.leftIndicator,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            buildSizeWidth(5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                width: 176,
                                height: 208,
                                // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: BaseColors.grey5.withOpacity(0.3)),
                                ),
                                child: PageView.builder(
                                  controller: _secondScrollCtrl,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  // padding: EdgeInsets.zero,
                                  itemCount: evalCtrl.imageList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return CachedNetworkImage(
                                      imageUrl: evalCtrl.setImage(
                                        index: evalCtrl.secondImageIndex.value,
                                        title: widget.title,
                                      ),
                                      width: 83,
                                      height: 83,
                                      fit: BoxFit.fitHeight,
                                      errorWidget: (context, url, error) => errorWidget(),
                                    );
                                  },
                                  onPageChanged: (value) {
                                    evalCtrl.getSecondData(itemIndex: value);
                                  },
                                ),
                              ),
                            ),
                            buildSizeWidth(5),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                _secondScrollCtrl.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: SvgPicture.asset(
                                BaseAssets.rightIndicator,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
