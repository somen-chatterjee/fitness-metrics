import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/ui/notifications/notifications.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CoachDashboardAppBar1 extends StatefulWidget {
  final String profileTitle;

  const CoachDashboardAppBar1({super.key, required this.profileTitle});

  @override
  State<CoachDashboardAppBar1> createState() => _CoachDashboardAppBar1State();
}

class _CoachDashboardAppBar1State extends State<CoachDashboardAppBar1> {
  var athleteDataCtrl = Get.find<AthleteDataController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: BaseColors.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Stack(
        children: [
          SvgPicture.asset(BaseAssets.ellipse),
          SvgPicture.asset(BaseAssets.ellipse1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return ClipOval(
                        child: (athleteDataCtrl.athleteData.value.image ?? "")
                                .isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl:
                                    athleteDataCtrl.athleteData.value.image ??
                                        '',
                                width: 44,
                                height: 44,
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) => errorWidget(),
                              )
                            : Image.asset(
                                BaseAssets.athleteProfile,
                                width: 44,
                                height: 44,
                              ),
                      );
                    }),
                    InkWell(
                      onTap: () => Get.to(() => const Notifications()),
                      child: SvgPicture.asset(BaseAssets.notification),
                    )
                  ],
                ),
                buildSizeHeight(5),
                BaseText(
                  value: widget.profileTitle,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                ),
                buildSizeHeight(10),
                InkWell(
                  onTap: () => Get.back(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(BaseAssets.leftArrow),
                      buildSizeWidth(30),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
