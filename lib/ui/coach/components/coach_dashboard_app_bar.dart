import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/dashboard/controller/coach_dash_controller.dart';
import 'package:fitness_metrics/ui/notifications/notifications.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CoachDashboardAppBar extends StatefulWidget {
  const CoachDashboardAppBar({super.key});

  @override
  State<CoachDashboardAppBar> createState() => _CoachDashboardAppBarState();
}

class _CoachDashboardAppBarState extends State<CoachDashboardAppBar> {
  var coachDashCtrl = Get.find<CoachDashController>();

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
                        child: (coachDashCtrl.profileData.value.image ?? "")
                            .isNotEmpty
                            ? CachedNetworkImage(
                          imageUrl: coachDashCtrl.profileData.value.image ?? '',
                          width: 44,
                          height: 44,
                          fit: BoxFit.fill,
                        )
                            : Image.asset(
                          BaseAssets.coachProfile,
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
                    value: coachDashCtrl.profileData.value.name ?? '',
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.white,
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
