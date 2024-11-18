import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/controller/athlete_dash_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/notifications/notifications.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DashboardAppBar extends StatefulWidget {
  const DashboardAppBar({super.key});

  @override
  State<DashboardAppBar> createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  var athleteDashCtrl = Get.find<AthleteDashController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: BaseColors.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          )),
      child: Stack(
        children: [
          SvgPicture.asset(BaseAssets.ellipse),
          SvgPicture.asset(BaseAssets.ellipse1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
            child: GestureDetector(
              onTap: () {
                var athleteDashCtrl = Get.find<AthleteDashController>();
                athleteDashCtrl.selectBody(2);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSizeHeight(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return ClipOval(
                          child: (athleteDashCtrl.athleteData.value.image ?? "")
                                  .isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: athleteDashCtrl.athleteData.value.image ?? '',
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.fill,
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
                  buildSizeHeight(10),
                  BaseText(
                    value: getGreetingMessage(),
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                  Obx(() {
                    return BaseText(
                      value: athleteDashCtrl.athleteData.value.name ?? "",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white,
                    );
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
